import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/features/cart/controller/cart_controller.dart';
import 'package:a_one_gt/features/cart/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      /// APPBAR
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color.fromARGB(255, 103, 203, 147),
                const Color.fromARGB(255, 10, 72, 36).withValues(alpha: 0.78),
              ],
            ),
          ),
        ),
      ),

      /// BODY
      body: Consumer<CartService>(
        builder: (context, cartService, child) {
          if (cartService.isEmpty) {
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
            itemCount: cartService.items.length,
            itemBuilder: (context, index) {
              final cartItem = cartService.items[index];
              return _buildCartItem(context, cartItem, cartService);
            },
          );
        },
      ),

      /// BOTTOM BAR
      bottomNavigationBar: Consumer<CartService>(
        builder: (context, cartService, child) {
          if (cartService.isEmpty) return const SizedBox.shrink();
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
            width: 80,
            height: 80,
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

          const SizedBox(width: 14),

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

                const SizedBox(height: 10),

                Row(
                  children: [
                    _quantityButton(
                      Icons.remove,
                      () => cartService.decrementQuantity(cartItem.product.id),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${cartItem.quantity}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    _quantityButton(
                      Icons.add,
                      () => cartService.incrementQuantity(cartItem.product.id),
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
              cartService.removeItem(cartItem.product.id);
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
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Row(
        children: [
          /// TOTAL
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Total Price",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  "AED ${cartService.totalPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Appcolors.primaryGreen,
                  ),
                ),
                Text(
                  "${cartService.itemCount} items",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),

          /// CHECKOUT BUTTON
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
                // TODO: Implement checkout functionality
                toastification.show(
                  context: context,
                  title: const Text('Checkout functionality coming soon!'),
                  type: ToastificationType.success,
                  style: ToastificationStyle.minimal,
                  autoCloseDuration: const Duration(seconds: 2),
                  alignment: Alignment.topCenter,
                  borderRadius: BorderRadius.circular(10),
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
