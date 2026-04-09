import 'package:a_one_gt/core/service/api_service.dart';
import 'package:a_one_gt/features/checkout/model/checkout_model.dart';
import 'package:a_one_gt/features/checkout/viewmodel/checkout_viewmodel.dart';
import 'package:a_one_gt/features/address/model/address_model.dart';
import 'package:flutter/foundation.dart';

class CheckoutController {
  final ApiService _apiService = ApiService();
  final CheckoutViewModel _viewModel = CheckoutViewModel();

  CheckoutViewModel get viewModel => _viewModel;

  /// Initialize checkout with cart items
  Future<void> initializeCheckout(String cartId) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.post('/checkout/initialize', {
        'cart_id': cartId,
      });

      if (response['success'] == true) {
        final checkoutData = response['data'] ?? {};
        final checkout = CheckoutModel.fromJson(checkoutData);
        _viewModel.setCheckout(checkout);
      } else {
        _viewModel.setError(
          response['message'] ?? 'Failed to initialize checkout',
        );
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('CheckoutController.initializeCheckout error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Get available payment methods
  Future<void> getPaymentMethods() async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get('/payment/methods');

      if (response['success'] == true) {
        final List<dynamic> methodsData = response['data'] ?? [];
        final methods = methodsData
            .map((json) => PaymentMethodModel.fromJson(json))
            .toList();
        _viewModel.setPaymentMethods(methods);
      } else {
        _viewModel.setError(
          response['message'] ?? 'Failed to fetch payment methods',
        );
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('CheckoutController.getPaymentMethods error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Get available coupons
  Future<void> getAvailableCoupons() async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.get('/coupons/available');

      if (response['success'] == true) {
        final List<dynamic> couponsData = response['data'] ?? [];
        final coupons = couponsData
            .map((json) => CouponModel.fromJson(json))
            .toList();
        _viewModel.setAvailableCoupons(coupons);
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to fetch coupons');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('CheckoutController.getAvailableCoupons error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Validate coupon
  Future<void> validateCoupon(String couponCode) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.post('/coupons/validate', {
        'coupon_code': couponCode,
        'order_amount': _viewModel.subtotal,
      });

      if (response['success'] == true) {
        final couponData = response['data'] ?? {};
        final coupon = CouponModel.fromJson(couponData);
        _viewModel.setAppliedCoupon(coupon);
        _viewModel.setMessage('Coupon applied successfully');
      } else {
        _viewModel.setError(response['message'] ?? 'Invalid coupon code');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('CheckoutController.validateCoupon error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Calculate delivery fee
  Future<void> calculateDeliveryFee(String addressId) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.post('/checkout/delivery-fee', {
        'address_id': addressId,
        'items':
            _viewModel.checkout?.items.map((item) => item.toJson()).toList() ??
            [],
      });

      if (response['success'] == true) {
        final deliveryFee = (response['data']['delivery_fee'] ?? 0).toDouble();
        // Update checkout with new delivery fee
        if (_viewModel.checkout != null) {
          final updatedCheckout = CheckoutModel(
            items: _viewModel.checkout!.items,
            deliveryAddress: _viewModel.checkout!.deliveryAddress,
            paymentMethod: _viewModel.checkout!.paymentMethod,
            subtotal: _viewModel.checkout!.subtotal,
            tax: _viewModel.checkout!.tax,
            deliveryFee: deliveryFee,
            discount: _viewModel.checkout!.discount,
            total:
                _viewModel.checkout!.subtotal +
                _viewModel.checkout!.tax +
                deliveryFee -
                _viewModel.checkout!.discount,
            couponCode: _viewModel.checkout!.couponCode,
            specialInstructions: _viewModel.checkout!.specialInstructions,
          );
          _viewModel.setCheckout(updatedCheckout);
        }
      } else {
        _viewModel.setError(
          response['message'] ?? 'Failed to calculate delivery fee',
        );
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        debugPrint('CheckoutController.calculateDeliveryFee error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Place order
  Future<void> placeOrder() async {
    try {
      if (!_viewModel.isCheckoutValid()) {
        return;
      }

      _viewModel.setLoading(true);

      final orderData = _viewModel.createPlaceOrderModel();
      final response = await _apiService.post(
        '/orders/place',
        orderData.toJson(),
      );

      if (response['success'] == true) {
        final orderData = response['data'] ?? {};
        _viewModel.setMessage('Order placed successfully');
        _viewModel.resetCheckout();

        // Return order ID for navigation
        return orderData['order_id'];
      } else {
        _viewModel.setError(response['message'] ?? 'Failed to place order');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        print('CheckoutController.placeOrder error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Process payment
  Future<void> processPayment(
    String orderId,
    Map<String, dynamic> paymentData,
  ) async {
    try {
      _viewModel.setLoading(true);

      final response = await _apiService.post('/payment/process', {
        'order_id': orderId,
        ...paymentData,
      });

      if (response['success'] == true) {
        _viewModel.setMessage('Payment processed successfully');
      } else {
        _viewModel.setError(response['message'] ?? 'Payment failed');
      }
    } catch (e) {
      _viewModel.setError('Network error: ${e.toString()}');
      if (kDebugMode) {
        print('CheckoutController.processPayment error: $e');
      }
    } finally {
      _viewModel.setLoading(false);
    }
  }

  /// Set delivery address
  void setDeliveryAddress(AddressModel address) {
    _viewModel.setSelectedAddress(address);
    // Recalculate delivery fee when address changes
    calculateDeliveryFee(address.id);
  }

  /// Set payment method
  void setPaymentMethod(PaymentMethodModel method) {
    _viewModel.setSelectedPaymentMethod(method);
  }

  /// Apply coupon
  void applyCoupon(String couponCode) {
    _viewModel.applyCoupon(couponCode);
  }

  /// Remove coupon
  void removeCoupon() {
    _viewModel.removeCoupon();
  }

  /// Set special instructions
  void setSpecialInstructions(String instructions) {
    _viewModel.setSpecialInstructions(instructions);
  }

  /// Set preferred delivery time
  void setPreferredDeliveryTime(DateTime time) {
    _viewModel.setPreferredDeliveryTime(time);
  }

  /// Clear error
  void clearError() {
    _viewModel.clearError();
  }

  /// Clear message
  void clearMessage() {
    _viewModel.clearMessage();
  }

  /// Dispose resources
  void dispose() {
    _viewModel.dispose();
  }
}
