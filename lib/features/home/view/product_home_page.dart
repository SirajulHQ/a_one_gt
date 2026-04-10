import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/dummy_data/dummy_data.dart';
import 'package:a_one_gt/dummy_data/dummy_model.dart';
import 'package:a_one_gt/features/notifications/view/notifications_page.dart';
import 'package:a_one_gt/features/notifications/widgets/smart_notification_badge_widget.dart';
import 'package:a_one_gt/features/product/widgets/product_card_widget.dart';
import 'package:a_one_gt/features/product/view/product_details_screen.dart';
import 'package:a_one_gt/features/widgets/custom_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductHomePage extends StatefulWidget {
  final String category;
  final String subCategory;

  const ProductHomePage({
    super.key,
    required this.category,
    required this.subCategory,
  });

  @override
  State<ProductHomePage> createState() => _ProductHomePageState();
}

class _ProductHomePageState extends State<ProductHomePage> {
  late List<Product> displayedProducts;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    displayedProducts = dummyProducts
        .where(
          (product) =>
              product.category == widget.category &&
              product.subCategory == widget.subCategory,
        )
        .toList();
  }

  void _runFilter(String query) {
    List<Product> results = [];

    if (query.isEmpty) {
      results = dummyProducts
          .where(
            (product) =>
                product.category == widget.category &&
                product.subCategory == widget.subCategory,
          )
          .toList();
    } else {
      results = dummyProducts
          .where(
            (product) =>
                product.category == widget.category &&
                product.subCategory == widget.subCategory &&
                product.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }

    setState(() {
      displayedProducts = results;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,

      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          /// ── App Bar ─────────────────────────────────
          CustomSliverAppBar(
            title: widget.subCategory,
            subtitle: "${displayedProducts.length} products available",
            action: Container(
              margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: SmartNotificationBadgeWidget(
                  child: const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                onPressed: () {
                  HapticFeedback.selectionClick();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationsPage(),
                    ),
                  );
                },
              ),
            ),
          ),

          /// ── Search ─────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),

              child: Container(
                height: 50,

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: TextField(
                  controller: _searchController,
                  onChanged: _runFilter,

                  decoration: InputDecoration(
                    hintText: "Search products...",

                    prefixIcon: Icon(
                      Icons.search,
                      color: Appcolors.primaryGreen,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// ── Product Grid ─────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),

            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                final product = displayedProducts[index];

                return ProductCardWidget(
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
              }, childCount: displayedProducts.length),

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
}
