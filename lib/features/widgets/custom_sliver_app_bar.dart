import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? action;

  const CustomSliverAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 140,
      toolbarHeight: 93,
      pinned: true,
      floating: false,
      snap: false,
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Appcolors.darkGreen,
      iconTheme: const IconThemeData(color: Colors.white),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final double maxHeight = 140;
          final double minHeight = 93;
          final double currentHeight = constraints.biggest.height;

          // Collapse percentage (0 = expanded, 1 = collapsed)
          double collapsePercent =
              (maxHeight - currentHeight) / (maxHeight - minHeight);

          // Clamp between 0 and 1
          collapsePercent = collapsePercent.clamp(0.0, 1.0);

          // Calculate screen width for centering
          double screenWidth = Dimensions.width30 * 170;

          // Title moves from 20 (expanded) to center (collapsed)
          double expandedLeft = 20;
          double collapsedLeft =
              (screenWidth - Dimensions.width30 * 10) /
              2; // Approximate title width consideration
          double titleLeft =
              expandedLeft + ((collapsedLeft - expandedLeft) * collapsePercent);

          return Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(32),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Appcolors.gradientColor1, Appcolors.gradientColor2],
              ),
            ),
            child: Stack(
              children: [
                // Back button
                Positioned(
                  top: MediaQuery.of(context).padding.top + 4,
                  left: 8,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                // Decorative circles
                Positioned(
                  top: -20,
                  right: -20,
                  child: Container(
                    width: Dimensions.width30 * 8.5,
                    height: Dimensions.height45 * 2.5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.08),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 60,
                  child: Container(
                    width: Dimensions.width30 * 4,
                    height: Dimensions.height45 * 1.3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.06),
                    ),
                  ),
                ),

                // Animated Title Position
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 24,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: collapsePercent < 1.0 ? titleLeft : 0,
                    ),
                    alignment: collapsePercent >= 1.0
                        ? Alignment.center
                        : Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: collapsePercent >= 1.0
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.75),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      actions: action != null ? [action!] : null,
    );
  }
}
