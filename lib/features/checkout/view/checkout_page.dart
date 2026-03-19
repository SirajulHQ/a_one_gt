import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/features/cart/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class CheckoutPage extends StatelessWidget {
  final String category;

  const CheckoutPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context);
    final items = cartService.itemsForCategory(category);

    return Scaffold(
      backgroundColor: Appcolors.background,

      /// APPBAR
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Checkout",
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _sectionCard(
              title: "Delivery Address",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Sirajul Haque",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text("Dubai, UAE"),
                  Text("+971 50 123 4567"),
                ],
              ),
            ),

            const SizedBox(height: 16),

            _sectionCard(
              title: "Payment Method",
              child: Column(
                children: [
                  _paymentTile(Icons.credit_card, "Credit / Debit Card", true),
                  _paymentTile(Icons.account_balance_wallet, "Wallet", false),
                  _paymentTile(Icons.money, "Cash on Delivery", false),
                ],
              ),
            ),

            const SizedBox(height: 16),

            _sectionCard(
              title: "Order Summary",
              child: Column(
                children: items.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${item.product.name} x${item.quantity}",
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                        Text(
                          "AED ${(item.product.price * item.quantity).toStringAsFixed(2)}",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),

      /// BOTTOM BAR
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(
          Dimensions.width30,
          Dimensions.height10,
          Dimensions.width30,
          Dimensions.height45,
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
                  const Text("Total", style: TextStyle(color: Colors.grey)),
                  Text(
                    "AED ${cartService.totalPriceForCategory(category).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: Dimensions.font20,
                      fontWeight: FontWeight.bold,
                      color: Appcolors.primaryGreen,
                    ),
                  ),
                ],
              ),
            ),

            /// PLACE ORDER BUTTON
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 13, 85, 43),
                  padding: EdgeInsets.symmetric(vertical: Dimensions.height15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () {
                  toastification.show(
                    context: context,
                    title: const Text("Order Placed Successfully!"),
                    type: ToastificationType.success,
                    autoCloseDuration: const Duration(seconds: 2),
                    alignment: Alignment.topCenter,
                  );
                },
                child: const Text(
                  "Place Order",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// SECTION CARD
  Widget _sectionCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  /// PAYMENT TILE
  Widget _paymentTile(IconData icon, String title, bool selected) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Appcolors.primaryGreen),
      title: Text(title),
      trailing: Icon(
        selected ? Icons.radio_button_checked : Icons.radio_button_off,
        color: Appcolors.primaryGreen,
      ),
    );
  }
}
