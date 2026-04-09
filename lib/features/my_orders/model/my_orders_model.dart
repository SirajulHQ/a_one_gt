class MyOrdersModel {
  final String status;
  final List<Order> orders;
  final Pagination? pagination;

  MyOrdersModel({required this.status, required this.orders, this.pagination});

  factory MyOrdersModel.fromJson(Map<String, dynamic> json) {
    return MyOrdersModel(
      status: json["status"] ?? "",
      orders:
          (json["orders"] as List<dynamic>?)
              ?.map((e) => Order.fromJson(e))
              .toList() ??
          [],
      pagination: json["pagination"] != null
          ? Pagination.fromJson(json["pagination"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "orders": orders.map((e) => e.toJson()).toList(),
      "pagination": pagination?.toJson(),
    };
  }
}

class Order {
  final String id;
  final String orderId;
  final String userId;
  final String vendorId;
  final String? vendorName;
  final double totalAmount;
  final double deliveryFee;
  final double taxAmount;
  final double finalAmount;
  final String status;
  final String paymentStatus;
  final String paymentMethod;
  final DateTime orderDate;
  final DateTime? deliveryDate;
  final String deliveryAddress;
  final List<OrderItem> items;
  final OrderTracking? tracking;
  final bool canCancel;
  final bool canReturn;
  final bool canReorder;

  Order({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.vendorId,
    this.vendorName,
    required this.totalAmount,
    required this.deliveryFee,
    required this.taxAmount,
    required this.finalAmount,
    required this.status,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.orderDate,
    this.deliveryDate,
    required this.deliveryAddress,
    required this.items,
    this.tracking,
    required this.canCancel,
    required this.canReturn,
    required this.canReorder,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"] ?? "",
      orderId: json["order_id"] ?? "",
      userId: json["user_id"] ?? "",
      vendorId: json["vendor_id"] ?? "",
      vendorName: json["vendor_name"],
      totalAmount: (json["total_amount"] as num?)?.toDouble() ?? 0.0,
      deliveryFee: (json["delivery_fee"] as num?)?.toDouble() ?? 0.0,
      taxAmount: (json["tax_amount"] as num?)?.toDouble() ?? 0.0,
      finalAmount: (json["final_amount"] as num?)?.toDouble() ?? 0.0,
      status: json["status"] ?? "",
      paymentStatus: json["payment_status"] ?? "",
      paymentMethod: json["payment_method"] ?? "",
      orderDate: DateTime.tryParse(json["order_date"] ?? "") ?? DateTime.now(),
      deliveryDate: json["delivery_date"] != null
          ? DateTime.tryParse(json["delivery_date"])
          : null,
      deliveryAddress: json["delivery_address"] ?? "",
      items:
          (json["items"] as List<dynamic>?)
              ?.map((e) => OrderItem.fromJson(e))
              .toList() ??
          [],
      tracking: json["tracking"] != null
          ? OrderTracking.fromJson(json["tracking"])
          : null,
      canCancel: json["can_cancel"] ?? false,
      canReturn: json["can_return"] ?? false,
      canReorder: json["can_reorder"] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "order_id": orderId,
      "user_id": userId,
      "vendor_id": vendorId,
      "vendor_name": vendorName,
      "total_amount": totalAmount,
      "delivery_fee": deliveryFee,
      "tax_amount": taxAmount,
      "final_amount": finalAmount,
      "status": status,
      "payment_status": paymentStatus,
      "payment_method": paymentMethod,
      "order_date": orderDate.toIso8601String(),
      "delivery_date": deliveryDate?.toIso8601String(),
      "delivery_address": deliveryAddress,
      "items": items.map((e) => e.toJson()).toList(),
      "tracking": tracking?.toJson(),
      "can_cancel": canCancel,
      "can_return": canReturn,
      "can_reorder": canReorder,
    };
  }
}

class OrderItem {
  final String id;
  final String productId;
  final String productName;
  final String? productImage;
  final double price;
  final int quantity;
  final double totalPrice;
  final String? variant;
  final List<String>? addons;

  OrderItem({
    required this.id,
    required this.productId,
    required this.productName,
    this.productImage,
    required this.price,
    required this.quantity,
    required this.totalPrice,
    this.variant,
    this.addons,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json["id"] ?? "",
      productId: json["product_id"] ?? "",
      productName: json["product_name"] ?? "",
      productImage: json["product_image"],
      price: (json["price"] as num?)?.toDouble() ?? 0.0,
      quantity: json["quantity"] ?? 0,
      totalPrice: (json["total_price"] as num?)?.toDouble() ?? 0.0,
      variant: json["variant"],
      addons: json["addons"] != null ? List<String>.from(json["addons"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "product_id": productId,
      "product_name": productName,
      "product_image": productImage,
      "price": price,
      "quantity": quantity,
      "total_price": totalPrice,
      "variant": variant,
      "addons": addons,
    };
  }
}

class OrderTracking {
  final String currentStatus;
  final List<TrackingStep> steps;
  final DateTime? estimatedDelivery;

  OrderTracking({
    required this.currentStatus,
    required this.steps,
    this.estimatedDelivery,
  });

  factory OrderTracking.fromJson(Map<String, dynamic> json) {
    return OrderTracking(
      currentStatus: json["current_status"] ?? "",
      steps:
          (json["steps"] as List<dynamic>?)
              ?.map((e) => TrackingStep.fromJson(e))
              .toList() ??
          [],
      estimatedDelivery: json["estimated_delivery"] != null
          ? DateTime.tryParse(json["estimated_delivery"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "current_status": currentStatus,
      "steps": steps.map((e) => e.toJson()).toList(),
      "estimated_delivery": estimatedDelivery?.toIso8601String(),
    };
  }
}

class TrackingStep {
  final String status;
  final String title;
  final String? description;
  final DateTime? timestamp;
  final bool isCompleted;

  TrackingStep({
    required this.status,
    required this.title,
    this.description,
    this.timestamp,
    required this.isCompleted,
  });

  factory TrackingStep.fromJson(Map<String, dynamic> json) {
    return TrackingStep(
      status: json["status"] ?? "",
      title: json["title"] ?? "",
      description: json["description"],
      timestamp: json["timestamp"] != null
          ? DateTime.tryParse(json["timestamp"])
          : null,
      isCompleted: json["is_completed"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "title": title,
      "description": description,
      "timestamp": timestamp?.toIso8601String(),
      "is_completed": isCompleted,
    };
  }
}

class Pagination {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  final bool hasNext;
  final bool hasPrevious;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    required this.hasNext,
    required this.hasPrevious,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json["current_page"] ?? 1,
      totalPages: json["total_pages"] ?? 1,
      totalItems: json["total_items"] ?? 0,
      itemsPerPage: json["items_per_page"] ?? 10,
      hasNext: json["has_next"] ?? false,
      hasPrevious: json["has_previous"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "current_page": currentPage,
      "total_pages": totalPages,
      "total_items": totalItems,
      "items_per_page": itemsPerPage,
      "has_next": hasNext,
      "has_previous": hasPrevious,
    };
  }
}
