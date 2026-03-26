import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/features/product/widgets/product_card_widget.dart';
import 'package:a_one_gt/features/product/view/product_details_screen.dart';
import 'package:a_one_gt/features/widgets/custom_app_bar.dart';
import 'package:a_one_gt/features/wishlist/controller/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistPage extends ConsumerWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistItems = ref.watch(wishlistProvider);

    return Scaffold(
      backgroundColor: Appcolors.background,
      appBar: const CustomAppBar(title: "Wishlist"),
      body: wishlistItems.isEmpty
          ? _buildEmptyWishlist()
          : CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final product = wishlistItems[index];
                      return ProductCard(
                        product: product,
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailScreen(product: product),
                            ),
                          );
                        },
                      );
                    }, childCount: wishlistItems.length),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 14,
                          childAspectRatio: 0.95,
                        ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildEmptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 10),
          Text(
            "Your wishlist is empty",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
