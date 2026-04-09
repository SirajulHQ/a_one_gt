// Service Locator for Dependency Injection
// This provides a simple way to manage and access controllers throughout the app

import 'package:a_one_gt/features/my_orders/controller/my_orders_controller.dart';
import 'package:a_one_gt/features/product/controller/product_controller.dart';
import 'package:a_one_gt/features/wishlist/controller/wishlist_controller.dart';
import 'package:a_one_gt/features/settings/controller/settings_controller.dart';
import 'package:a_one_gt/features/profile/controller/profile_controller.dart';
import 'package:a_one_gt/features/address/controller/address_controller.dart';
import 'package:a_one_gt/features/checkout/controller/checkout_controller.dart';
import 'package:a_one_gt/features/help_and_support/controller/help_and_support_controller.dart';
import 'package:a_one_gt/features/home/controller/home_controller.dart';
import 'package:a_one_gt/features/category/controller/category_controller.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  // Controllers
  MyOrdersController? _myOrdersController;
  ProductController? _productController;
  WishlistController? _wishlistController;
  SettingsController? _settingsController;
  ProfileController? _profileController;
  AddressController? _addressController;
  CheckoutController? _checkoutController;
  HelpAndSupportController? _helpAndSupportController;
  HomeController? _homeController;
  CategoryController? _categoryController;

  // Getters for controllers (lazy initialization)
  MyOrdersController get myOrdersController {
    _myOrdersController ??= MyOrdersController();
    return _myOrdersController!;
  }

  ProductController get productController {
    _productController ??= ProductController();
    return _productController!;
  }

  WishlistController get wishlistController {
    _wishlistController ??= WishlistController();
    return _wishlistController!;
  }

  SettingsController get settingsController {
    _settingsController ??= SettingsController();
    return _settingsController!;
  }

  ProfileController get profileController {
    _profileController ??= ProfileController();
    return _profileController!;
  }

  AddressController get addressController {
    _addressController ??= AddressController();
    return _addressController!;
  }

  CheckoutController get checkoutController {
    _checkoutController ??= CheckoutController();
    return _checkoutController!;
  }

  HelpAndSupportController get helpAndSupportController {
    _helpAndSupportController ??= HelpAndSupportController();
    return _helpAndSupportController!;
  }

  HomeController get homeController {
    _homeController ??= HomeController();
    return _homeController!;
  }

  CategoryController get categoryController {
    _categoryController ??= CategoryController();
    return _categoryController!;
  }

  // Method to dispose all controllers
  void disposeAll() {
    // Only dispose controllers that have dispose methods
    _productController?.dispose();
    _wishlistController?.dispose();
    _settingsController?.dispose();
    _profileController?.dispose();
    _addressController?.dispose();
    _checkoutController?.dispose();
    _helpAndSupportController?.dispose();
    _homeController?.dispose();
    _categoryController?.dispose();

    // Reset all controllers
    _myOrdersController = null;
    _productController = null;
    _wishlistController = null;
    _settingsController = null;
    _profileController = null;
    _addressController = null;
    _checkoutController = null;
    _helpAndSupportController = null;
    _homeController = null;
    _categoryController = null;
  }

  // Method to dispose specific controller
  void dispose<T>() {
    if (T == MyOrdersController) {
      _myOrdersController = null;
    } else if (T == ProductController) {
      _productController?.dispose();
      _productController = null;
    } else if (T == WishlistController) {
      _wishlistController?.dispose();
      _wishlistController = null;
    } else if (T == SettingsController) {
      _settingsController?.dispose();
      _settingsController = null;
    } else if (T == ProfileController) {
      _profileController?.dispose();
      _profileController = null;
    } else if (T == AddressController) {
      _addressController?.dispose();
      _addressController = null;
    } else if (T == CheckoutController) {
      _checkoutController?.dispose();
      _checkoutController = null;
    } else if (T == HelpAndSupportController) {
      _helpAndSupportController?.dispose();
      _helpAndSupportController = null;
    } else if (T == HomeController) {
      _homeController?.dispose();
      _homeController = null;
    } else if (T == CategoryController) {
      _categoryController?.dispose();
      _categoryController = null;
    }
  }
}

// Extension for easy access
extension ServiceLocatorExtension on ServiceLocator {
  // Quick access methods
  static ServiceLocator get instance => ServiceLocator();

  // Usage: ServiceLocator.instance.get<ProductController>()
  T get<T>() {
    if (T == MyOrdersController) return myOrdersController as T;
    if (T == ProductController) return productController as T;
    if (T == WishlistController) return wishlistController as T;
    if (T == SettingsController) return settingsController as T;
    if (T == ProfileController) return profileController as T;
    if (T == AddressController) return addressController as T;
    if (T == CheckoutController) return checkoutController as T;
    if (T == HelpAndSupportController) return helpAndSupportController as T;
    if (T == HomeController) return homeController as T;
    if (T == CategoryController) return categoryController as T;

    throw Exception('Controller of type $T not found in ServiceLocator');
  }
}

// Usage Examples:
/*

// Method 1: Direct access
final productController = ServiceLocator().productController;

// Method 2: Generic access
final productController = ServiceLocator.instance.get<ProductController>();

// Method 3: In a StatefulWidget
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late final ProductController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = ServiceLocator.instance.get<ProductController>();
    _controller.viewModel.addListener(_onStateChanged);
  }
  
  void _onStateChanged() {
    setState(() {});
  }
  
  @override
  void dispose() {
    _controller.viewModel.removeListener(_onStateChanged);
    // Don't dispose the controller here as it's managed by ServiceLocator
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(); // Your UI here
  }
}

// Method 4: Dispose when app closes
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    ServiceLocator().disposeAll(); // Clean up all controllers
    super.dispose();
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      ServiceLocator().disposeAll();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Your app configuration
    );
  }
}

*/
