# MVVM Integration Guide

## 🚀 Quick Start

### 1. Basic Controller Usage

```dart
import 'package:a_one_gt/features/product/controller/product_controller.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ProductController _controller = ProductController();

  @override
  void initState() {
    super.initState();
    _controller.viewModel.addListener(_onStateChanged);
    _loadProducts();
  }

  void _onStateChanged() {
    setState(() {}); // Rebuild UI when state changes
  }

  Future<void> _loadProducts() async {
    await _controller.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = _controller.viewModel;

    return Scaffold(
      body: viewModel.isLoading
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: viewModel.filteredProducts.length,
              itemBuilder: (context, index) {
                final product = viewModel.filteredProducts[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('\$${product.price}'),
                );
              },
            ),
    );
  }

  @override
  void dispose() {
    _controller.viewModel.removeListener(_onStateChanged);
    _controller.dispose();
    super.dispose();
  }
}
```

### 2. Using Service Locator (Recommended)

```dart
import 'package:a_one_gt/core/service/service_locator.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late final ProductController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ServiceLocator.instance.get<ProductController>();
    _controller.viewModel.addListener(_onStateChanged);
    _loadProducts();
  }

  // Rest of the implementation remains the same...
}
```

## 📱 Feature-Specific Integration

### My Orders Integration

```dart
// In your existing MyOrdersPage
class _MyOrdersPageState extends State<MyOrdersPage> {
  final MyOrdersController _controller = MyOrdersController();

  Future<void> _loadOrders() async {
    try {
      final ordersModel = await _controller.getOrders();
      // Update your existing orders list
      setState(() {
        orders = ordersModel.orders.map((order) => {
          "orderId": order.orderId,
          "date": order.orderDate.toString(),
          "price": order.finalAmount,
          "status": order.status,
          // ... map other fields
        }).toList();
      });
    } catch (e) {
      // Handle error
      toastification.show(
        context: context,
        title: Text("Error loading orders: $e"),
        type: ToastificationType.error,
        style: ToastificationStyle.minimal,
        autoCloseDuration: const Duration(seconds: 3),
      );
    }
  }

  Future<void> _cancelOrder(String orderId) async {
    try {
      final success = await _controller.cancelOrder(orderId);
      if (success) {
        _loadOrders(); // Refresh the list
        if (mounted) {
          toastification.show(
            context: context,
            title: const Text("Order cancelled successfully"),
            type: ToastificationType.success,
            style: ToastificationStyle.minimal,
            autoCloseDuration: const Duration(seconds: 3),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        toastification.show(
          context: context,
          title: Text("Failed to cancel order: $e"),
          type: ToastificationType.error,
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
    }
  }
}
```

### Wishlist Integration

```dart
// Add to your existing ProductCard widget
class ProductCard extends StatefulWidget {
  final Product product;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final WishlistController _wishlistController = WishlistController();
  bool _isInWishlist = false;

  @override
  void initState() {
    super.initState();
    _checkWishlistStatus();
  }

  Future<void> _checkWishlistStatus() async {
    setState(() {
      _isInWishlist = _wishlistController.isProductInWishlist(widget.product.id);
    });
  }

  Future<void> _toggleWishlist() async {
    try {
      await _wishlistController.toggleWishlist(widget.product.id);
      await _checkWishlistStatus();
    } catch (e) {
      if (mounted) {
        toastification.show(
          context: context,
          title: Text("Error: $e"),
          type: ToastificationType.error,
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          // Your existing product card content...

          // Add wishlist button
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(
                _isInWishlist ? Icons.favorite : Icons.favorite_border,
                color: _isInWishlist ? Colors.red : Colors.grey,
              ),
              onPressed: _toggleWishlist,
            ),
          ),
        ],
      ),
    );
  }
}
```

### Settings Integration

```dart
// In your existing SettingsPage
class _SettingsPageState extends State<SettingsPage> {
  final SettingsController _controller = SettingsController();
  bool notifications = true;

  @override
  void initState() {
    super.initState();
    _controller.viewModel.addListener(_onStateChanged);
    _loadSettings();
  }

  void _onStateChanged() {
    final settings = _controller.viewModel.settings;
    if (settings != null) {
      setState(() {
        notifications = settings.pushNotifications;
      });
    }
  }

  Future<void> _loadSettings() async {
    await _controller.getSettings();
  }

  Future<void> _updateNotifications(bool value) async {
    try {
      await _controller.updatePushNotifications(value);
      setState(() {
        notifications = value;
      });
    } catch (e) {
      if (mounted) {
        toastification.show(
          context: context,
          title: Text("Failed to update settings: $e"),
          type: ToastificationType.error,
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
    }
  }

  // Update your existing _buildSwitchTile method
  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return ListTile(
      // ... existing implementation
      trailing: Switch(
        value: value,
        activeThumbColor: Appcolors.primaryGreen,
        onChanged: (newValue) {
          if (title == "Push Notifications") {
            _updateNotifications(newValue);
          } else {
            onChanged(newValue);
          }
        },
      ),
    );
  }
}
```

## 🔄 Backend Integration

### 1. Update Configuration

```dart
// In lib/core/config/app_config.dart
class AppConfig {
  // Update this when backend is ready
  static const String apiBaseUrl = 'https://your-api-domain.com/api/';

  // Set to false when backend is ready
  static const bool useMockData = false;
}
```

### 2. Update API Service

```dart
// In lib/core/service/api_service.dart
class ApiService {
  final String baseUrl = AppConfig.apiBaseUrl;
  final bool useMockData = AppConfig.useMockData; // Use config value

  // Rest remains the same...
}
```

### 3. Authentication Integration

```dart
// After successful login in your auth flow
await TokenStorageService.saveTokens(
  response['access_token'],
  response['refresh_token'],
);

// All API calls will now automatically include the token
final orders = await myOrdersController.getOrders();
```

## 🎯 Error Handling Patterns

### 1. Global Error Handling

```dart
class ErrorHandler {
  static void handleError(BuildContext context, String error) {
    toastification.show(
      context: context,
      title: Text(error),
      type: ToastificationType.error,
      style: ToastificationStyle.minimal,
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  static void handleSuccess(BuildContext context, String message) {
    toastification.show(
      context: context,
      title: Text(message),
      type: ToastificationType.success,
      style: ToastificationStyle.minimal,
      autoCloseDuration: const Duration(seconds: 3),
    );
  }
}
```

### 2. Controller Error Handling

```dart
class BaseController {
  void handleControllerError(BuildContext context, dynamic error) {
    String message;

    if (error.toString().contains('Network error')) {
      message = 'Please check your internet connection';
    } else if (error.toString().contains('401')) {
      message = 'Please login again';
      // Navigate to login
    } else {
      message = 'Something went wrong. Please try again.';
    }

    ErrorHandler.handleError(context, message);
  }
}
```

## 📊 State Management Best Practices

### 1. Listening to Multiple Controllers

```dart
class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final ProductController _productController;
  late final MyOrdersController _ordersController;
  late final ProfileController _profileController;

  @override
  void initState() {
    super.initState();

    _productController = ServiceLocator.instance.get<ProductController>();
    _ordersController = ServiceLocator.instance.get<MyOrdersController>();
    _profileController = ServiceLocator.instance.get<ProfileController>();

    // Listen to all controllers
    _productController.viewModel.addListener(_onStateChanged);
    _ordersController.viewModel.addListener(_onStateChanged);
    _profileController.viewModel.addListener(_onStateChanged);

    _loadDashboardData();
  }

  void _onStateChanged() {
    setState(() {});
  }

  Future<void> _loadDashboardData() async {
    await Future.wait([
      _productController.getFeaturedProducts(),
      _ordersController.getOrders(limit: 5),
      _profileController.getUserProfile(),
    ]);
  }

  @override
  void dispose() {
    _productController.viewModel.removeListener(_onStateChanged);
    _ordersController.viewModel.removeListener(_onStateChanged);
    _profileController.viewModel.removeListener(_onStateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Featured products section
          if (_productController.viewModel.products.isNotEmpty)
            ProductSection(products: _productController.viewModel.products),

          // Recent orders section
          if (_ordersController.viewModel.orders.isNotEmpty)
            OrdersSection(orders: _ordersController.viewModel.orders),

          // Profile section
          if (_profileController.viewModel.userProfile != null)
            ProfileSection(profile: _profileController.viewModel.userProfile!),
        ],
      ),
    );
  }
}
```

### 2. Conditional UI Updates

```dart
class SmartProductList extends StatefulWidget {
  @override
  _SmartProductListState createState() => _SmartProductListState();
}

class _SmartProductListState extends State<SmartProductList> {
  late final ProductController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ServiceLocator.instance.get<ProductController>();
    _controller.viewModel.addListener(_onStateChanged);
  }

  void _onStateChanged() {
    final viewModel = _controller.viewModel;

    // Handle different state changes
    if (viewModel.error != null) {
      _showError(viewModel.error!);
      _controller.clearError();
    }

    if (viewModel.message != null) {
      _showSuccess(viewModel.message!);
      _controller.clearMessage();
    }

    setState(() {});
  }

  void _showError(String error) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ErrorHandler.handleError(context, error);
    });
  }

  void _showSuccess(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ErrorHandler.handleSuccess(context, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = _controller.viewModel;

    return RefreshIndicator(
      onRefresh: () => _controller.getProducts(),
      child: viewModel.isLoading && viewModel.products.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: viewModel.filteredProducts.length +
                        (viewModel.hasMoreProducts ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == viewModel.filteredProducts.length) {
                  // Load more indicator
                  _controller.loadMoreProducts();
                  return Center(child: CircularProgressIndicator());
                }

                final product = viewModel.filteredProducts[index];
                return ProductCard(product: product);
              },
            ),
    );
  }
}
```

## 🔧 Testing Integration

### 1. Unit Testing Controllers

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:a_one_gt/features/product/controller/product_controller.dart';

void main() {
  group('ProductController Tests', () {
    late ProductController controller;

    setUp(() {
      controller = ProductController();
    });

    tearDown(() {
      controller.dispose();
    });

    test('should load products successfully', () async {
      // Act
      await controller.getProducts();

      // Assert
      expect(controller.viewModel.products, isNotEmpty);
      expect(controller.viewModel.isLoading, isFalse);
      expect(controller.viewModel.error, isNull);
    });

    test('should filter products by search query', () async {
      // Arrange
      await controller.getProducts();

      // Act
      controller.setSearchQuery('apple');

      // Assert
      final filteredProducts = controller.viewModel.filteredProducts;
      expect(filteredProducts.every((p) =>
        p.name.toLowerCase().contains('apple')), isTrue);
    });
  });
}
```

### 2. Widget Testing with Controllers

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:a_one_gt/features/product/view/product_list_page.dart';

void main() {
  testWidgets('ProductListPage should display products', (tester) async {
    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: ProductListPage(),
      ),
    );

    // Wait for loading to complete
    await tester.pump(Duration(seconds: 2));

    // Verify products are displayed
    expect(find.byType(ListTile), findsWidgets);
  });
}
```

## 🚀 Performance Optimization

### 1. Lazy Loading

```dart
class OptimizedProductList extends StatefulWidget {
  @override
  _OptimizedProductListState createState() => _OptimizedProductListState();
}

class _OptimizedProductListState extends State<OptimizedProductList> {
  late final ProductController _controller;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controller = ServiceLocator.instance.get<ProductController>();
    _scrollController = ScrollController();

    _scrollController.addListener(_onScroll);
    _controller.viewModel.addListener(_onStateChanged);

    _loadInitialProducts();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      _controller.loadMoreProducts();
    }
  }

  void _onStateChanged() {
    setState(() {});
  }

  Future<void> _loadInitialProducts() async {
    await _controller.getProducts(page: 1, limit: 20);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _controller.viewModel.filteredProducts.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: _controller.viewModel.filteredProducts[index],
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.viewModel.removeListener(_onStateChanged);
    super.dispose();
  }
}
```

## 📋 Summary

✅ **All MVVM controllers are ready to use**
✅ **Service Locator provides easy dependency management**
✅ **Error handling patterns established**
✅ **State management best practices documented**
✅ **Backend integration path defined**
✅ **Testing strategies provided**
✅ **Performance optimization techniques included**

The MVVM architecture is now fully integrated and ready for production use. All controllers work with mock data and can be easily switched to real API calls when the backend is ready.
