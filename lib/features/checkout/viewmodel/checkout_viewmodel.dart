import 'package:a_one_gt/features/checkout/model/checkout_model.dart';
import 'package:a_one_gt/features/address/model/address_model.dart';
import 'package:flutter/foundation.dart';

class CheckoutViewModel extends ChangeNotifier {
  CheckoutModel? _checkout;
  List<PaymentMethodModel> _paymentMethods = [];
  List<CouponModel> _availableCoupons = [];
  CouponModel? _appliedCoupon;
  AddressModel? _selectedAddress;
  PaymentMethodModel? _selectedPaymentMethod;
  String _specialInstructions = '';
  DateTime? _preferredDeliveryTime;
  bool _isLoading = false;
  String? _error;
  String? _message;

  // Getters
  CheckoutModel? get checkout => _checkout;
  List<PaymentMethodModel> get paymentMethods => _paymentMethods;
  List<CouponModel> get availableCoupons => _availableCoupons;
  CouponModel? get appliedCoupon => _appliedCoupon;
  AddressModel? get selectedAddress => _selectedAddress;
  PaymentMethodModel? get selectedPaymentMethod => _selectedPaymentMethod;
  String get specialInstructions => _specialInstructions;
  DateTime? get preferredDeliveryTime => _preferredDeliveryTime;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get message => _message;

  // Calculated values
  double get subtotal => _checkout?.subtotal ?? 0;
  double get tax => _checkout?.tax ?? 0;
  double get deliveryFee => _checkout?.deliveryFee ?? 0;
  double get discount => _appliedCoupon?.calculateDiscount(subtotal) ?? 0;
  double get total => subtotal + tax + deliveryFee - discount;

  // Setters
  void setCheckout(CheckoutModel checkout) {
    _checkout = checkout;
    notifyListeners();
  }

  void setPaymentMethods(List<PaymentMethodModel> methods) {
    _paymentMethods = methods;
    notifyListeners();
  }

  void setAvailableCoupons(List<CouponModel> coupons) {
    _availableCoupons = coupons;
    notifyListeners();
  }

  void setAppliedCoupon(CouponModel? coupon) {
    _appliedCoupon = coupon;
    notifyListeners();
  }

  void setSelectedAddress(AddressModel? address) {
    _selectedAddress = address;
    notifyListeners();
  }

  void setSelectedPaymentMethod(PaymentMethodModel? method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  void setSpecialInstructions(String instructions) {
    _specialInstructions = instructions;
    notifyListeners();
  }

  void setPreferredDeliveryTime(DateTime? time) {
    _preferredDeliveryTime = time;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  void setMessage(String? message) {
    _message = message;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void clearMessage() {
    _message = null;
    notifyListeners();
  }

  // Apply coupon
  void applyCoupon(String couponCode) {
    final coupon = _availableCoupons.firstWhere(
      (c) => c.code.toLowerCase() == couponCode.toLowerCase(),
      orElse: () => CouponModel(
        code: '',
        name: '',
        description: '',
        type: 'percentage',
        value: 0,
        minOrderAmount: 0,
        maxDiscount: 0,
        expiryDate: DateTime.now(),
        isActive: false,
      ),
    );

    if (coupon.code.isNotEmpty && coupon.isActive) {
      if (subtotal >= coupon.minOrderAmount) {
        setAppliedCoupon(coupon);
        setMessage('Coupon applied successfully');
      } else {
        setError(
          'Minimum order amount for this coupon is AED ${coupon.minOrderAmount.toStringAsFixed(2)}',
        );
      }
    } else {
      setError('Invalid or expired coupon code');
    }
  }

  // Remove coupon
  void removeCoupon() {
    setAppliedCoupon(null);
    setMessage('Coupon removed');
  }

  // Validate checkout
  bool isCheckoutValid() {
    if (_selectedAddress == null) {
      setError('Please select a delivery address');
      return false;
    }

    if (_selectedPaymentMethod == null) {
      setError('Please select a payment method');
      return false;
    }

    if (_checkout == null || _checkout!.items.isEmpty) {
      setError('Your cart is empty');
      return false;
    }

    return true;
  }

  // Create place order model
  PlaceOrderModel createPlaceOrderModel() {
    return PlaceOrderModel(
      items: _checkout?.items ?? [],
      deliveryAddressId: _selectedAddress?.id ?? '',
      paymentMethodId: _selectedPaymentMethod?.id ?? '',
      couponCode: _appliedCoupon?.code,
      specialInstructions: _specialInstructions.isNotEmpty
          ? _specialInstructions
          : null,
      preferredDeliveryTime: _preferredDeliveryTime,
    );
  }

  // Reset checkout
  void resetCheckout() {
    _checkout = null;
    _appliedCoupon = null;
    _selectedAddress = null;
    _selectedPaymentMethod = null;
    _specialInstructions = '';
    _preferredDeliveryTime = null;
    _error = null;
    _message = null;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
