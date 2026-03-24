import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/dummy_data/dummy_data.dart';
import 'package:a_one_gt/dummy_data/dummy_model.dart';
import 'package:a_one_gt/features/home/widgets/product_card_widget.dart';
import 'package:a_one_gt/features/product/view/product_details_screen.dart';
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
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            elevation: 0,
            backgroundColor: Appcolors.darkGreen,
            iconTheme: const IconThemeData(color: Colors.white),

            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
            ),

            flexibleSpace: Container(
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

                  Positioned(
                    left: 20,
                    bottom: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.subCategory,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),

                        const SizedBox(height: 2),

                        Text(
                          "${displayedProducts.length} products available",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.75),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 22,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
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
