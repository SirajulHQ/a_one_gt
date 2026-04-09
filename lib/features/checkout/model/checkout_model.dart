import 'package:a_one_gt/features/address/model/address_model.dart';

class CheckoutModel {
  final List<CheckoutItemModel> items;
  final AddressModel deliveryAddress;
  final PaymentMethodModel paymentMethod;
  final double subtotal;
  final double tax;
  final double deliveryFee;
  final double discount;
  final double total;
  final String? couponCode;
  final String? specialInstructions;

  CheckoutModel({
    required this.items,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.subtotal,
    required this.tax,
    required this.deliveryFee,
    required this.discount,
    required this.total,
    this.couponCode,
    this.specialInstructions,
  });

  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    return CheckoutModel(
      items:
          (json['items'] as List<dynamic>?)
              ?.map((item) => CheckoutItemModel.fromJson(item))
              .toList() ??
          [],
      deliveryAddress: AddressModel.fromJson(json['delivery_address'] ?? {}),
      paymentMethod: PaymentMethodModel.fromJson(json['payment_method'] ?? {}),
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      deliveryFee: (json['delivery_fee'] ?? 0).toDouble(),
      discount: (json['discount'] ?? 0).toDouble(),
      total: (json['total'] ?? 0).toDouble(),
      couponCode: json['coupon_code'],
      specialInstructions: json['special_instructions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'delivery_address': deliveryAddress.toJson(),
      'payment_method': paymentMethod.toJson(),
      'subtotal': subtotal,
      'tax': tax,
      'delivery_fee': deliveryFee,
      'discount': discount,
      'total': total,
      'coupon_code': couponCode,
      'special_instructions': specialInstructions,
    };
  }
}

class CheckoutItemModel {
  final String productId;
  final String productName;
  final String productImage;
  final double price;
  final int quantity;
  final String unit;
  final double total;

  CheckoutItemModel({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
    required this.unit,
    required this.total,
  });

  factory CheckoutItemModel.fromJson(Map<String, dynamic> json) {
    return CheckoutItemModel(
      productId: json['product_id'] ?? '',
      productName: json['product_name'] ?? '',
      productImage: json['product_image'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 1,
      unit: json['unit'] ?? 'piece',
      total: (json['total'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'product_image': productImage,
      'price': price,
      'quantity': quantity,
      'unit': unit,
      'total': total,
    };
  }
}

class PaymentMethodModel {
  final String id;
  final String type; // 'card', 'cash', 'wallet', 'bank_transfer'
  final String name;
  final String? cardNumber; // masked for security
  final String? cardType; // 'visa', 'mastercard', etc.
  final bool isDefault;

  PaymentMethodModel({
    required this.id,
    required this.type,
    required this.name,
    this.cardNumber,
    this.cardType,
    required this.isDefault,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      name: json['name'] ?? '',
      cardNumber: json['card_number'],
      cardType: json['card_type'],
      isDefault: json['is_default'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'card_number': cardNumber,
      'card_type': cardType,
      'is_default': isDefault,
    };
  }
}

class PlaceOrderModel {
  final List<CheckoutItemModel> items;
  final String deliveryAddressId;
  final String paymentMethodId;
  final String? couponCode;
  final String? specialInstructions;
  final DateTime? preferredDeliveryTime;

  PlaceOrderModel({
    required this.items,
    required this.deliveryAddressId,
    required this.paymentMethodId,
    this.couponCode,
    this.specialInstructions,
    this.preferredDeliveryTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'delivery_address_id': deliveryAddressId,
      'payment_method_id': paymentMethodId,
      'coupon_code': couponCode,
      'special_instructions': specialInstructions,
      'preferred_delivery_time': preferredDeliveryTime?.toIso8601String(),
    };
  }
}

class CouponModel {
  final String code;
  final String name;
  final String description;
  final String type; // 'percentage', 'fixed'
  final double value;
  final double minOrderAmount;
  final double maxDiscount;
  final DateTime expiryDate;
  final bool isActive;

  CouponModel({
    required this.code,
    required this.name,
    required this.description,
    required this.type,
    required this.value,
    required this.minOrderAmount,
    required this.maxDiscount,
    required this.expiryDate,
    required this.isActive,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? 'percentage',
      value: (json['value'] ?? 0).toDouble(),
      minOrderAmount: (json['min_order_amount'] ?? 0).toDouble(),
      maxDiscount: (json['max_discount'] ?? 0).toDouble(),
      expiryDate: DateTime.parse(
        json['expiry_date'] ?? DateTime.now().toIso8601String(),
      ),
      isActive: json['is_active'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'description': description,
      'type': type,
      'value': value,
      'min_order_amount': minOrderAmount,
      'max_discount': maxDiscount,
      'expiry_date': expiryDate.toIso8601String(),
      'is_active': isActive,
    };
  }

  double calculateDiscount(double orderAmount) {
    if (!isActive || orderAmount < minOrderAmount) return 0;

    double discount = 0;
    if (type == 'percentage') {
      discount = (orderAmount * value) / 100;
    } else if (type == 'fixed') {
      discount = value;
    }

    return discount > maxDiscount ? maxDiscount : discount;
  }
}
