// MVVM Integration Examples
// This file shows how to integrate the new MVVM controllers with existing UI

import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:a_one_gt/features/my_orders/controller/my_orders_controller.dart';
import 'package:a_one_gt/features/product/controller/product_controller.dart';
import 'package:a_one_gt/features/wishlist/controller/wishlist_controller.dart';
import 'package:a_one_gt/features/settings/controller/settings_controller.dart';
import 'package:a_one_gt/features/profile/controller/profile_controller.dart';
import 'package:a_one_gt/features/profile/model/profile_model.dart';

/// Example 1: Integrating My Orders Controller with existing UI
class MyOrdersIntegrationExample extends StatefulWidget {
  const MyOrdersIntegrationExample({super.key});

  @override
  State<MyOrdersIntegrationExample> createState() =>
      _MyOrdersIntegrationExampleState();
}

class _MyOrdersIntegrationExampleState
    extends State<MyOrdersIntegrationExample> {
  final MyOrdersController _controller = MyOrdersController();
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final orders = await _controller.getOrders();
      // Use orders data to update UI
      debugPrint('Loaded ${orders.orders.length} orders');
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _cancelOrder(String orderId) async {
    try {
      final success = await _controller.cancelOrder(orderId);
      if (success && mounted) {
        toastification.show(
          context: context,
          title: const Text("Order cancelled successfully"),
          type: ToastificationType.success,
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 3),
        );
        _loadOrders(); // Refresh the list
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Orders')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text('Error: $_error'))
          : ListView(
              children: [
                ListTile(
                  title: Text('Order #12345'),
                  trailing: ElevatedButton(
                    onPressed: () => _cancelOrder('12345'),
                    child: Text('Cancel'),
                  ),
                ),
              ],
            ),
    );
  }
}

/// Example 2: Product Controller with State Management
class ProductListIntegrationExample extends StatefulWidget {
  const ProductListIntegrationExample({super.key});

  @override
  State<ProductListIntegrationExample> createState() =>
      _ProductListIntegrationExampleState();
}

class _ProductListIntegrationExampleState
    extends State<ProductListIntegrationExample> {
  final ProductController _controller = ProductController();

  @override
  void initState() {
    super.initState();
    _controller.viewModel.addListener(_onStateChanged);
    _loadProducts();
  }

  void _onStateChanged() {
    setState(() {}); // Rebuild when state changes
  }

  Future<void> _loadProducts() async {
    await _controller.getProducts();
  }

  Future<void> _searchProducts(String query) async {
    await _controller.searchProducts(query);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = _controller.viewModel;

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products...',
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                _controller.setSearchQuery(query);
              },
              onSubmitted: _searchProducts,
            ),
          ),
        ),
      ),
      body: viewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : viewModel.error != null
          ? Center(child: Text('Error: ${viewModel.error}'))
          : ListView.builder(
              itemCount: viewModel.filteredProducts.length,
              itemBuilder: (context, index) {
                final product = viewModel.filteredProducts[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('\$${product.price}'),
                  trailing: Text('${product.rating} ⭐'),
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

/// Example 3: Wishlist Integration
class WishlistButtonExample extends StatefulWidget {
  final String productId;

  const WishlistButtonExample({super.key, required this.productId});

  @override
  State<WishlistButtonExample> createState() => _WishlistButtonExampleState();
}

class _WishlistButtonExampleState extends State<WishlistButtonExample> {
  final WishlistController _controller = WishlistController();
  bool _isInWishlist = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkWishlistStatus();
  }

  Future<void> _checkWishlistStatus() async {
    setState(() {
      _isInWishlist = _controller.isProductInWishlist(widget.productId);
    });
  }

  Future<void> _toggleWishlist() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _controller.toggleWishlist(widget.productId);
      await _checkWishlistStatus();

      if (mounted) {
        toastification.show(
          context: context,
          title: Text(
            _isInWishlist ? "Added to wishlist" : "Removed from wishlist",
          ),
          type: ToastificationType.success,
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
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
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(
              _isInWishlist ? Icons.favorite : Icons.favorite_border,
              color: _isInWishlist ? Colors.red : Colors.grey,
            ),
      onPressed: _isLoading ? null : _toggleWishlist,
    );
  }
}

/// Example 4: Settings Integration
class SettingsIntegrationExample extends StatefulWidget {
  const SettingsIntegrationExample({super.key});

  @override
  State<SettingsIntegrationExample> createState() =>
      _SettingsIntegrationExampleState();
}

class _SettingsIntegrationExampleState
    extends State<SettingsIntegrationExample> {
  final SettingsController _controller = SettingsController();

  @override
  void initState() {
    super.initState();
    _controller.viewModel.addListener(_onStateChanged);
    _loadSettings();
  }

  void _onStateChanged() {
    setState(() {});
  }

  Future<void> _loadSettings() async {
    await _controller.getSettings();
  }

  Future<void> _updateNotifications(bool enabled) async {
    await _controller.updatePushNotifications(enabled);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = _controller.viewModel;
    final settings = viewModel.settings;

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: viewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : settings == null
          ? Center(child: Text('No settings loaded'))
          : ListView(
              children: [
                SwitchListTile(
                  title: Text('Push Notifications'),
                  value: settings.pushNotifications,
                  onChanged: _updateNotifications,
                ),
                ListTile(
                  title: Text('Language'),
                  subtitle: Text(settings.language),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  title: Text('Theme'),
                  subtitle: Text(settings.theme),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ],
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

/// Example 5: Profile Integration
class ProfileIntegrationExample extends StatefulWidget {
  const ProfileIntegrationExample({super.key});

  @override
  State<ProfileIntegrationExample> createState() =>
      _ProfileIntegrationExampleState();
}

class _ProfileIntegrationExampleState extends State<ProfileIntegrationExample> {
  final ProfileController _controller = ProfileController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.viewModel.addListener(_onStateChanged);
    _loadProfile();
  }

  void _onStateChanged() {
    setState(() {});

    // Update text field when profile loads
    final profile = _controller.viewModel.userProfile;
    if (profile != null) {
      _nameController.text = profile.name;
    }
  }

  Future<void> _loadProfile() async {
    await _controller.getUserProfile();
  }

  Future<void> _updateProfile() async {
    final updateData = UpdateProfileModel(name: _nameController.text);

    try {
      await _controller.updateUserProfile(updateData);
      if (mounted) {
        toastification.show(
          context: context,
          title: const Text("Profile updated successfully"),
          type: ToastificationType.success,
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      if (mounted) {
        toastification.show(
          context: context,
          title: Text("Failed to update profile: $e"),
          type: ToastificationType.error,
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = _controller.viewModel;
    final profile = viewModel.userProfile;

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: viewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : profile == null
          ? Center(child: Text('No profile loaded'))
          : Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Email: ${profile.email}'),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _updateProfile,
                    child: Text('Update Profile'),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _controller.viewModel.removeListener(_onStateChanged);
    _controller.dispose();
    _nameController.dispose();
    super.dispose();
  }
}

/// Example 6: Error Handling Pattern
class ErrorHandlingExample extends StatefulWidget {
  const ErrorHandlingExample({super.key});

  @override
  State<ErrorHandlingExample> createState() => _ErrorHandlingExampleState();
}

class _ErrorHandlingExampleState extends State<ErrorHandlingExample> {
  final ProductController _controller = ProductController();

  @override
  void initState() {
    super.initState();
    _controller.viewModel.addListener(_onStateChanged);
  }

  void _onStateChanged() {
    final viewModel = _controller.viewModel;

    // Handle error messages
    if (viewModel.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          toastification.show(
            context: context,
            title: Text(viewModel.error!),
            type: ToastificationType.error,
            style: ToastificationStyle.minimal,
            autoCloseDuration: const Duration(seconds: 3),
          );
        }
      });
    }

    // Handle success messages
    if (viewModel.message != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          toastification.show(
            context: context,
            title: Text(viewModel.message!),
            type: ToastificationType.success,
            style: ToastificationStyle.minimal,
            autoCloseDuration: const Duration(seconds: 3),
          );
        }
        _controller.clearMessage();
      });
    }

    setState(() {});
  }

  Future<void> _loadProducts() async {
    await _controller.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Error Handling Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: _loadProducts,
          child: Text('Load Products'),
        ),
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
