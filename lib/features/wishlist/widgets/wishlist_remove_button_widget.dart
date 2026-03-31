import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/dummy_data/dummy_model.dart';
import 'package:a_one_gt/features/wishlist/controller/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistRemoveButtonWidget extends ConsumerWidget {
  final Product product;

  const WishlistRemoveButtonWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTapDown: (details) {
        final overlay =
            Overlay.of(context).context.findRenderObject() as RenderBox;
        final position = RelativeRect.fromRect(
          details.globalPosition & const Size(1, 1),
          Offset.zero & overlay.size,
        );
        showMenu(
          context: context,
          position: position,
          color: Colors.transparent,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          items: [
            PopupMenuItem(
              padding: EdgeInsets.zero,
              onTap: () {
                HapticFeedback.lightImpact();
                ref.read(wishlistProvider.notifier).toggle(product);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width20,
                  vertical: Dimensions.height10 + 1,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Appcolors.gradientColor1,
                      Appcolors.gradientColor2,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: Dimensions.iconSize16 + 4,
                    ),
                    SizedBox(width: Dimensions.width20),
                    Text(
                      "Remove from Wishlist",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.more_vert, size: 16, color: Colors.grey),
      ),
    );
  }
}
