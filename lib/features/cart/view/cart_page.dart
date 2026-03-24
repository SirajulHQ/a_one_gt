import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/features/cart/controller/cart_controller.dart';
import 'package:a_one_gt/features/cart/models/cart_item.dart';
import 'package:a_one_gt/features/checkout/view/checkout_page.dart';
import 'package:a_one_gt/features/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class CartPage extends StatelessWidget {
  final String category;
  const CartPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,

      /// APPBAR
      appBar: CustomAppBar(title: "$category Cart"),

      /// BODY
      body: Consumer<CartService>(
        builder: (context, cartService, child) {
          final items = cartService.itemsForCategory(category);

          if (items.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Your cart is empty",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Add some products to get started",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return _buildCartItem(context, items[index], cartService);
            },
          );
        },
      ),

      /// BOTTOM BAR
      bottomNavigationBar: Consumer<CartService>(
        builder: (context, cartService, child) {
          if (cartService.isEmptyForCategory(category))
            return const SizedBox.shrink();
          return _buildBottomCheckout(context, cartService);
        },
      ),
    );
  }

  Widget _buildCartItem(
    BuildContext context,
    CartItem cartItem,
    CartService cartService,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          /// PRODUCT IMAGE
          Container(
            width: Dimensions.width30 * 6.5,
            height: Dimensions.height45 * 1.7,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F7FB),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Image.asset(
              cartItem.product.image,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.image_not_supported),
                );
              },
            ),
          ),

          SizedBox(width: Dimensions.width30),

          /// PRODUCT INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "AED ${cartItem.product.price}",
                  style: TextStyle(
                    color: Appcolors.primaryGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Dimensions.height10),
                Row(
                  children: [
                    _quantityButton(
                      Icons.remove,
                      () => cartService.decrementQuantity(
                        cartItem.product.id,
                        category,
                      ),
                    ),
                    SizedBox(width: Dimensions.width20),
                    Text(
                      "${cartItem.quantity}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: Dimensions.width20),
                    _quantityButton(
                      Icons.add,
                      () => cartService.incrementQuantity(
                        cartItem.product.id,
                        category,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// DELETE BUTTON
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () {
              HapticFeedback.mediumImpact();
              cartService.removeItem(cartItem.product.id, category);
              toastification.show(
                context: context,
                title: Text('${cartItem.product.name} removed from cart'),
                type: ToastificationType.error,
                style: ToastificationStyle.minimal,
                autoCloseDuration: const Duration(seconds: 2),
                alignment: Alignment.topCenter,
                borderRadius: BorderRadius.circular(10),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _quantityButton(IconData icon, VoidCallback onTap) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7FB),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 16, color: Appcolors.primaryGreen),
        onPressed: onTap,
      ),
    );
  }

  Widget _buildBottomCheckout(BuildContext context, CartService cartService) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        Dimensions.width30 + 10,
        Dimensions.height15 * 0,
        Dimensions.width30 + 10,
        Dimensions.height45 * 2.2,
      ),
      decoration: BoxDecoration(
        color: Appcolors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Row(
        children: [
          /// TOTAL
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Total Price",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: Dimensions.font16 - 5,
                  ),
                ),
                Text(
                  "AED ${cartService.totalPriceForCategory(category).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: Dimensions.font20 + 0.8,
                    fontWeight: FontWeight.bold,
                    color: Appcolors.primaryGreen,
                  ),
                ),
                Text(
                  "${cartService.itemCountForCategory(category)} items",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: Dimensions.font16 - 5,
                  ),
                ),
              ],
            ),
          ),

          /// CHECKOUT BUTTON
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolors.darkGreen,
                padding: EdgeInsets.symmetric(vertical: Dimensions.height15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () {
                // toastification.show(
                //   context: context,
                //   title: const Text('Checkout functionality coming soon!'),
                //   type: ToastificationType.success,
                //   style: ToastificationStyle.minimal,
                //   autoCloseDuration: const Duration(seconds: 2),
                //   alignment: Alignment.topCenter,
                //   borderRadius: BorderRadius.circular(10),
                // );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CheckoutPage(category: category),
                  ),
                );
              },
              child: const Text(
                "Checkout",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
