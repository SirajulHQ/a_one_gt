import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:a_one_gt/features/home/view/home_page.dart';
import 'package:a_one_gt/features/cart/view/cart_page.dart';
import 'package:a_one_gt/features/cart/controller/cart_controller.dart';

class MainNavigationPage extends StatefulWidget {
  final String category;
  const MainNavigationPage({super.key, this.category = "All"});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late final List<Widget> _pages;
  late AnimationController _animController;

  static const _primaryGreen = Color(0xFF1AAE6F);
  static const _darkGreen = Color(0xFF0A4824);

  final List<_NavItem> _navItems = const [
    _NavItem(
      icon: Icons.home_rounded,
      outlineIcon: Icons.home_outlined,
      label: "Home",
    ),
    _NavItem(
      icon: Icons.shopping_bag_rounded,
      outlineIcon: Icons.shopping_bag_outlined,
      label: "Cart",
    ),
    _NavItem(
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
      const CartPage(),
      const _PlaceholderPage(label: "Profile"),
    ];
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    HapticFeedback.selectionClick();
    setState(() => _selectedIndex = index);
    _animController
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: Consumer<CartService>(
        builder: (context, cartService, _) {
          return _FloatingNavBar(
            selectedIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: _navItems,
            cartCount: cartService.itemCount,
            primaryGreen: _primaryGreen,
            darkGreen: _darkGreen,
          );
        },
      ),
    );
  }
}

// ── Data model ──────────────────────────────────────────────────────────────
class _NavItem {
  final IconData icon;
  final IconData outlineIcon;
  final String label;
  const _NavItem({
    required this.icon,
    required this.outlineIcon,
    required this.label,
  });
}

// ── Floating Nav Bar Widget ─────────────────────────────────────────────────
class _FloatingNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final List<_NavItem> items;
  final int cartCount;
  final Color primaryGreen;
  final Color darkGreen;

  const _FloatingNavBar({
    required this.selectedIndex,
    required this.onTap,
    required this.items,
    required this.cartCount,
    required this.primaryGreen,
    required this.darkGreen,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.width15 + 5),
        child: Container(
          height: Dimensions.height45 + 18,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [darkGreen, const Color(0xFF0D5C2E)],
            ),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: darkGreen.withOpacity(0.45),
                blurRadius: 20,
                offset: const Offset(0, 8),
                spreadRadius: -2,
              ),
              BoxShadow(
                color: primaryGreen.withOpacity(0.15),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: List.generate(items.length, (index) {
              final isSelected = selectedIndex == index;
              final showBadge = index == 1 && cartCount > 0;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(index),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeOutCubic,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withOpacity(0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              transitionBuilder: (child, animation) =>
                                  ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  ),
                              child: Icon(
                                isSelected
                                    ? items[index].icon
                                    : items[index].outlineIcon,
                                key: ValueKey('${index}_$isSelected'),
                                color: isSelected
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.45),
                                size: isSelected ? 24 : 22,
                              ),
                            ),
                            const SizedBox(height: 3),
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 200),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w400,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.45),
                                letterSpacing: isSelected ? 0.3 : 0,
                              ),
                              child: Text(items[index].label),
                            ),
                          ],
                        ),

                        // Cart badge
                        if (showBadge)
                          Positioned(
                            top: 6,
                            right: 16,
                            child: TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.5, end: 1.0),
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.elasticOut,
                              builder: (_, scale, child) =>
                                  Transform.scale(scale: scale, child: child),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 1.5,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF4757),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: darkGreen,
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xFFFF4757,
                                      ).withOpacity(0.5),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Text(
                                  cartCount > 99 ? '99+' : '$cartCount',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                    height: 1.2,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),

                        // Active dot indicator
                        if (isSelected)
                          Positioned(
                            bottom: 5,
                            child: Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: primaryGreen,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryGreen.withOpacity(0.8),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ── Placeholder for Profile ──────────────────────────────────────────────────
class _PlaceholderPage extends StatelessWidget {
  final String label;
  const _PlaceholderPage({required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0A4824),
          ),
        ),
      ),
    );
  }
}
