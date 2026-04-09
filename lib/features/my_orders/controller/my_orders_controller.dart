import 'package:a_one_gt/features/my_orders/model/my_orders_model.dart';
import 'package:a_one_gt/features/my_orders/viewmodel/my_orders_viewmodel.dart';
import 'package:flutter/foundation.dart';

class MyOrdersController {
  final MyOrdersViewModel _viewModel = MyOrdersViewModel();

  MyOrdersViewModel get viewModel => _viewModel;

  /// Get user orders
  Future<MyOrdersModel> getOrders({
    int page = 1,
    int limit = 10,
    String? status,
  }) async {
    try {
      return await _viewModel.fetchOrders(
        page: page,
        limit: limit,
        status: status,
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint('MyOrdersController.getOrders error: $e');
      }
      rethrow;
    }
  }

  /// Get order details
  Future<Order> getOrderDetails(String orderId) async {
    try {
      return await _viewModel.fetchOrderDetails(orderId: orderId);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('MyOrdersController.getOrderDetails error: $e');
      }
      rethrow;
    }
  }

  /// Cancel order
  Future<bool> cancelOrder(String orderId) async {
    try {
      return await _viewModel.cancelOrder(orderId: orderId);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('MyOrdersController.cancelOrder error: $e');
      }
      rethrow;
    }
  }

  /// Return order
  Future<bool> returnOrder(String orderId, String reason) async {
    try {
      return await _viewModel.returnOrder(orderId: orderId, reason: reason);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('MyOrdersController.returnOrder error: $e');
      }
      rethrow;
    }
  }

  /// Reorder items
  Future<bool> reorderItems(String orderId) async {
    try {
      return await _viewModel.reorder(orderId: orderId);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('MyOrdersController.reorderItems error: $e');
      }
      rethrow;
    }
  }
}
