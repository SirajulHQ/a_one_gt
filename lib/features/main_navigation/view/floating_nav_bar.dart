import 'package:a_one_gt/features/main_navigation/controller/main_navigation_controller.dart';
import 'package:flutter/material.dart';

class FloatingNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final List<NavItemModel> items;
  final int cartCount;
  final int wishlistCount;
  final Color primaryGreen;
  final Color darkGreen;

  const FloatingNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    required this.items,
    required this.cartCount,
    required this.wishlistCount,
    required this.primaryGreen,
    required this.darkGreen,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 63,
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
              final showBadge =
                  (index == 1 && cartCount > 0) ||
                  (index == 2 && wishlistCount > 0);
              final badgeCount = index == 1 ? cartCount : wishlistCount;

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

                        if (showBadge)
                          Positioned(
                            top: 6,
                            right: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 1.5,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF4757),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                badgeCount > 99 ? '99+' : '$badgeCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),

                        if (isSelected)
                          Positioned(
                            bottom: 5,
                            child: Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: primaryGreen,
                                shape: BoxShape.circle,
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
