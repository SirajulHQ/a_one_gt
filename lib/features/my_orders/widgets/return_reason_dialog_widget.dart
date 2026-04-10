import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReturnReasonDialogWidget extends StatefulWidget {
  final int index;
  final List<Map<String, dynamic>> selectedItems;
  final List<Map<String, dynamic>> orders;
  final Function(int, String, List<Map<String, dynamic>>) onConfirm;

  const ReturnReasonDialogWidget({
    super.key,
    required this.index,
    required this.selectedItems,
    required this.orders,
    required this.onConfirm,
  });

  @override
  State<ReturnReasonDialogWidget> createState() =>
      _ReturnReasonDialogWidgetState();
}

class _ReturnReasonDialogWidgetState extends State<ReturnReasonDialogWidget> {
  String? selectedReason;

  final List<String> returnReasons = [
    "Damaged product",
    "Wrong item received",
    "Poor quality",
    "Not as described",
    "Changed my mind",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
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
                  colors: [Appcolors.gradientColor1, Appcolors.gradientColor2],
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
                    "Return Reason",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.font20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: Dimensions.height10 / 2),
                  Text(
                    "Please select a reason for returning the selected items from order ${widget.orders[widget.index]["orderId"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: Dimensions.font16 - 2,
                    ),
                  ),
                ],
              ),
            ),

            /// Selected Items Summary
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
                              color: Appcolors.gradientColor1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: Dimensions.height15),

            /// Reason Selection
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              child: Column(
                children: [
                  ...returnReasons.map(
                    (reason) => Container(
                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                      child: InkWell(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          setState(() {
                            selectedReason = reason;
                          });
                        },
                        borderRadius: BorderRadius.circular(
                          Dimensions.radius15,
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width15,
                            vertical: Dimensions.height15,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedReason == reason
                                  ? Appcolors.gradientColor1
                                  : Colors.grey.shade300,
                              width: selectedReason == reason ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(
                              Dimensions.radius15,
                            ),
                            color: selectedReason == reason
                                ? Appcolors.gradientColor1.withValues(
                                    alpha: 0.05,
                                  )
                                : Colors.transparent,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                selectedReason == reason
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_unchecked,
                                color: selectedReason == reason
                                    ? Appcolors.gradientColor1
                                    : Colors.grey.shade400,
                                size: Dimensions.iconSize24 - 2,
                              ),
                              SizedBox(width: Dimensions.width10),
                              Expanded(
                                child: Text(
                                  reason,
                                  style: TextStyle(
                                    fontSize: Dimensions.font16 - 1,
                                    fontWeight: selectedReason == reason
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color: selectedReason == reason
                                        ? Appcolors.gradientColor1
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.height10),

                  /// Continue Button
                  SizedBox(
                    width: double.infinity,
                    height: Dimensions.height45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedReason != null
                            ? Appcolors.gradientColor1
                            : Colors.grey.shade300,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius15,
                          ),
                        ),
                      ),
                      onPressed: selectedReason != null
                          ? () {
                              HapticFeedback.mediumImpact();
                              Navigator.pop(context);
                              widget.onConfirm(
                                widget.index,
                                selectedReason!,
                                widget.selectedItems,
                              );
                            }
                          : null,
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: selectedReason != null
                              ? Colors.white
                              : Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.height10),

                  /// Cancel Button
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
