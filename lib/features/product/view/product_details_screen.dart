import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/dummy_data/dummy_model.dart';
import 'package:a_one_gt/features/cart/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  int quantity = 1;
  bool isLiked = false;

  late AnimationController _likeController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Instagram-style animation is very fast (approx 150ms)
    _likeController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    // Sequence: 1.0 -> 1.3 (Pop) -> 1.0 (Settle)
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 1.3,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.3,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_likeController);
  }

  @override
  void dispose() {
    _likeController.dispose();
    super.dispose();
  }

  void _handleLikeTap() {
    setState(() {
      isLiked = !isLiked;
    });

    if (isLiked) {
      // 1. Trigger "Medium" impact haptic (simulates a physical click)
      HapticFeedback.mediumImpact();

      // 2. Run the "Pop" animation
      _likeController.forward(from: 0.0);
    } else {
      // Light feedback for unliking
      HapticFeedback.lightImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: Appcolors.background,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Product Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
Appcolors.gradientColor1, Appcolors.gradientColor2              ],
            ),
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
              onPressed: _handleLikeTap,
              icon: ScaleTransition(
                scale: _scaleAnimation,
                child: Icon(
                  isLiked
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  size: 22,
                  color: isLiked ? Colors.redAccent : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(product),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildImageCard(product), _buildDetailsCard(product)],
        ),
      ),
    );
  }

  Widget _buildImageCard(Product product) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(28),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Appcolors.primaryGreen.withOpacity(0.07),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -10,
            right: -10,
            child: Container(
              // width: 90,
              // height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Appcolors.primaryGreen.withOpacity(0.05),
              ),
            ),
          ),
          Hero(
            tag: 'product_image_${product.name}',
            child: Image.asset(
              product.image,
              // height: 230,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard(Product product) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ),
              Text(
                "AED ${product.price}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Appcolors.primaryGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildRatingBadge(product.rating),
          const SizedBox(height: 24),
          Divider(color: Colors.grey.shade100, thickness: 1.5),
          const SizedBox(height: 20),
          const SectionTitle(title: "Description"),
          const SizedBox(height: 12),
          Text(
            product.description,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionTitle(title: "Quantity"),
              _buildQuantitySelector(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBadge(double rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
          const SizedBox(width: 5),
          Text(
            rating.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.amber.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7FB),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Appcolors.primaryGreen.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (quantity > 1) setState(() => quantity--);
            },
            icon: Icon(
              Icons.remove_rounded,
              size: 18,
              color: quantity > 1 ? Appcolors.primaryGreen : Colors.grey,
            ),
          ),
          Text(
            "$quantity Kg",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () => setState(() => quantity++),
            icon: Icon(
              Icons.add_rounded,
              size: 18,
              color: Appcolors.primaryGreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(Product product) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Total Price",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  "AED ${(product.price * quantity).toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Appcolors.primaryGreen,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolors.primaryGreen,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () {
                final cartService = Provider.of<CartService>(
                  context,
                  listen: false,
                );
                cartService.addItem(product, quantity: quantity);

                // Show success message
                toastification.show(
                  context: context,
                  title: Text('${product.name} added to cart!'),
                  type: ToastificationType.success,
                  style: ToastificationStyle.minimal,
                  autoCloseDuration: const Duration(seconds: 2),
                  alignment: Alignment.topCenter,
                  borderRadius: BorderRadius.circular(10),
                );
              },
              child: const Text(
                "Add to Cart",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: Dimensions.width10,
          height: 18,
          decoration: BoxDecoration(
            color: Appcolors.primaryGreen,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: Dimensions.width20),
        Text(
          title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}
