import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/dummy_data/dummy_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
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
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 100,
                    width: 180,
                    color: Colors.green.shade50,
                    // padding: const EdgeInsets.all(5),
                    child: Image.asset(
                      product.image,
                      height: 80,
                      width: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  "\$${product.price}",
                  style: const TextStyle(color: Appcolors.primaryGreen),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
