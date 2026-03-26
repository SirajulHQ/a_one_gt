import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/dummy_data/dummy_model.dart';
import 'package:a_one_gt/features/cart/controller/cart_controller.dart';
import 'package:a_one_gt/features/widgets/like_button_widget.dart';
import 'package:a_one_gt/features/wishlist/controller/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Consumer;
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class ProductCard extends ConsumerWidget {
  final Product product;
  final VoidCallback onTap;
  final bool showWishlistRemove;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    this.showWishlistRemove = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Container(
                        height: Dimensions.height45 * 2.0,
                        width: Dimensions.width30 * 12,
                        color: Colors.green.shade50,
                        child: Image.asset(
                          product.image,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.image_not_supported),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: showWishlistRemove
                            ? _WishlistRemoveButton(product: product, ref: ref)
                            : LikeButtonWidget(product: product),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "AED ${product.price}",
                      style: const TextStyle(
                        color: Appcolors.primaryGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Consumer<CartService>(
                      builder: (context, cartService, child) {
                        return GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            cartService.addItem(product);
                            toastification.show(
                              context: context,
                              title: Text('${product.name} added to cart!'),
                              type: ToastificationType.success,
                              style: ToastificationStyle.minimal,
                              autoCloseDuration: const Duration(seconds: 1),
                              alignment: Alignment.topCenter,
                              borderRadius: BorderRadius.circular(10),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Appcolors.primaryGreen,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.add_shopping_cart,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WishlistRemoveButton extends StatelessWidget {
  final Product product;
  final WidgetRef ref;

  const _WishlistRemoveButton({required this.product, required this.ref});

  @override
  Widget build(BuildContext context) {
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          items: [
            PopupMenuItem(
              onTap: () {
                HapticFeedback.lightImpact();
                ref.read(wishlistProvider.notifier).toggle(product);
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 18,
                    color: Colors.redAccent,
                  ),
                  SizedBox(width: 8),
                  Text("Remove from Wishlist"),
                ],
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
