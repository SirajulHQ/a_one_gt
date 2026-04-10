import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConfirmReturnDialogWidget extends StatefulWidget {
  final int index;
  final String reason;
  final List<Map<String, dynamic>> selectedItems;
  final List<Map<String, dynamic>> orders;
  final VoidCallback onUpdate;

  const ConfirmReturnDialogWidget({
    super.key,
    required this.index,
    required this.reason,
    required this.selectedItems,
    required this.orders,
    required this.onUpdate,
  });

  @override
  State<ConfirmReturnDialogWidget> createState() => _ConfirmReturnDialogWidgetState();
}

class _ConfirmReturnDialogWidgetState extends State<ConfirmReturnDialogWidget> {
  @override
  Widget build(BuildContext context) {
    double totalRefund = widget.selectedItems.fold(
      0.0,
      (sum, item) => sum + item["price"],
    );

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius20 + 4),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Gradient Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.height30,
                horizontal: Dimensions.width20,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Appcolors.gradientColor1,
                    Appcolors.gradientColor2,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: Dimensions.height45 + 20,
                    height: Dimensions.height45 + 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.15),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.25),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.assignment_return_rounded,
                      color: Colors.white,
                      size: Dimensions.iconSize24 + 4,
                    ),
                  ),
                  SizedBox(height: Dimensions.height10),
                  Text(
                    "Confirm Return",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.font20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: Dimensions.height10 / 2),
                  Text(
                    "Return selected items from order ${widget.orders[widget.index]["orderId"]} for: ${widget.reason}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: Dimensions.font16 - 2,
                    ),
                  ),
                ],
              ),
            ),

            /// Return Summary
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              padding: EdgeInsets.all(Dimensions.width15),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Items to Return:",
                    style: TextStyle(
                      fontSize: Dimensions.font16 - 2,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: Dimensions.height10 / 2),
                  ...widget.selectedItems.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item["name"],
                            style: TextStyle(
                              fontSize: Dimensions.font16 - 2,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Text(
                            "AED ${item["price"]}",
                            style: TextStyle(
                              fontSize: Dimensions.font16 - 2,
                              fontWeight: FontWeight.w600,
                              color: Colors.red.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(height: Dimensions.height15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Refund:",
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "AED ${totalRefund.toInt()}",
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                          fontWeight: FontWeight.w700,
                          color: Colors.red.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: Dimensions.height15),

            /// Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: Dimensions.height45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade50,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius15,
                          ),
                        ),
                      ),
                      onPressed: () {
                        HapticFeedback.mediumImpact();
                        Navigator.pop(context);

                        // Original logic preserved
                        List<Map<String, dynamic>> remainingItems =
                            (widget.orders[widget.index]["items"] as List)
                                .map(
                                  (item) => Map<String, dynamic>.from(
                                    item as Map,
                                  ),
                                )
                                .where(
                                  (orderItem) => !widget.selectedItems.any(
                                    (selectedItem) =>
                                        selectedItem["name"] ==
                                        orderItem["name"],
                                  ),
                                )
                                .toList();

                        widget.orders[widget.index]["items"] = remainingItems;

                        int newPrice = remainingItems.fold(
                          0,
                          (sum, item) => sum + (item["price"] as int),
                        );
                        widget.orders[widget.index]["price"] = newPrice;

                        if (remainingItems.isEmpty) {
                          widget.orders[widget.index]["status"] = "Returned";
                        } else {
                          widget.orders[widget.index]["partialReturn"] = {
                            "returnedItems": widget.selectedItems,
                            "returnReason": widget.reason,
                            "refundAmount": totalRefund.toInt(),
                          };
                        }

                        widget.onUpdate(); // triggers parent setState
                      },
                      child: const Text(
                        "Confirm Return",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.height10),

                  SizedBox(
                    width: double.infinity,
                    height: Dimensions.height45,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black87,
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius15,
                          ),
                        ),
                      ),
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}