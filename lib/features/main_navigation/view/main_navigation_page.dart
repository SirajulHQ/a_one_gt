import 'package:a_one_gt/features/profile/view/profile_page.dart';
import 'package:a_one_gt/features/wishlist/controller/wishlist_provider.dart';
import 'package:a_one_gt/features/wishlist/view/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    hide ChangeNotifierProvider;
import 'package:provider/provider.dart';
import 'package:a_one_gt/features/home/view/home_page.dart';
import 'package:a_one_gt/features/cart/view/cart_page.dart';
import 'package:a_one_gt/features/cart/controller/cart_controller.dart';

import '../controller/main_navigation_controller.dart';
import 'floating_nav_bar.dart';

class MainNavigationPage extends ConsumerStatefulWidget {
  final String category;
  const MainNavigationPage({super.key, this.category = "All"});

  @override
  ConsumerState<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends ConsumerState<MainNavigationPage>
    with TickerProviderStateMixin {
  late final List<Widget> _pages;

  static const _primaryGreen = Color(0xFF1AAE6F);
  static const _darkGreen = Color(0xFF0A4824);

  final List<NavItemModel> _navItems = const [
    NavItemModel(
      icon: Icons.home_rounded,
      outlineIcon: Icons.home_outlined,
      label: "Home",
    ),
    NavItemModel(
      icon: Icons.shopping_bag_rounded,
      outlineIcon: Icons.shopping_bag_outlined,
      label: "Cart",
    ),
    NavItemModel(
      icon: Icons.favorite_rounded,
      outlineIcon: Icons.favorite_border_rounded,
      label: "Wishlist",
    ),
    NavItemModel(
      icon: Icons.person_rounded,
      outlineIcon: Icons.person_outline_rounded,
      label: "Profile",
    ),
  ];

  @override
  void initState() {
    super.initState();

    _pages = [
      HomePage(category: widget.category),
      CartPage(category: widget.category),
      const WishlistPage(),
      const ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final wishlistCount = ref.watch(wishlistProvider).length;

    return ChangeNotifierProvider(
      create: (_) => MainNavigationController(),
      child: Consumer2<MainNavigationController, CartService>(
        builder: (context, controller, cartService, _) {
          return Scaffold(
            extendBody: true,
            body: IndexedStack(
              index: controller.selectedIndex,
              children: _pages,
            ),
            bottomNavigationBar: FloatingNavBar(
              selectedIndex: controller.selectedIndex,
              onTap: controller.onItemTapped,
              items: _navItems,
              cartCount: cartService.itemCountForCategory(widget.category),
              wishlistCount: wishlistCount,
              primaryGreen: _primaryGreen,
              darkGreen: _darkGreen,
            ),
          );
        },
      ),
    );
  }
}
