import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/features/address/view/saved_address_page.dart';
import 'package:a_one_gt/features/cart/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class CheckoutPage extends StatefulWidget {
  final String category;

  const CheckoutPage({super.key, required this.category});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int selectedPayment = 0;

  double _subtotal(List items) {
    return items.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  double _vat(List items) {
    return _subtotal(items) * 0.05;
  }

  double _total(List items) {
    return _subtotal(items) + _vat(items);
  }

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context);
    final items = cartService.itemsForCategory(widget.category);

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
              action: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SavedAddressesPage(),
                    ),
                  );
                },
                child: Text(
                  "Change",
                  style: TextStyle(
                    color: Appcolors.primaryGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
                  _paymentTile(
                    Icons.credit_card_outlined,
                    "Credit / Debit Card",
                    0,
                  ),
                  _paymentTile(Icons.money_outlined, "Card on Delivery", 1),
                  _paymentTile(Icons.money_outlined, "Cash on Delivery", 2),
                ],
              ),
            ),

            const SizedBox(height: 16),

            _sectionCard(
              title: "Order Summary",
              child: Column(
                children: [
                  /// Item List
                  ...items.map((item) {
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
                  }),

                  const Divider(height: 24),

                  /// Subtotal
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Subtotal"),
                      Text(
                        "AED ${_subtotal(items).toStringAsFixed(2)}",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  /// VAT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("VAT (5%)"),
                      Text(
                        "AED ${_vat(items).toStringAsFixed(2)}",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),

                  const Divider(height: 24),

                  /// Total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "AED ${_total(items).toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
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
                    "AED ${_total(items).toStringAsFixed(2)}",
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
  Widget _sectionCard({
    required String title,
    required Widget child,
    Widget? action, // optional button
  }) {
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
          /// Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              if (action != null) action,
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  /// PAYMENT TILE
  Widget _paymentTile(IconData icon, String title, int index) {
    return ListTile(
      onTap: () {
        setState(() {
          selectedPayment = index;
        });
      },
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Appcolors.primaryGreen),
      title: Text(title),
      trailing: Icon(
        selectedPayment == index
            ? Icons.radio_button_checked
            : Icons.radio_button_off,
        color: Appcolors.primaryGreen,
      ),
    );
  }
}
