import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReturnItemSelectionDialog extends StatefulWidget {
  final int index;
  final List<Map<String, dynamic>> orders;
  final Function(int, List<Map<String, dynamic>>) onContinue;

  const ReturnItemSelectionDialog({
    super.key,
    required this.index,
    required this.orders,
    required this.onContinue,
  });

  @override
  State<ReturnItemSelectionDialog> createState() => _ReturnItemSelectionDialogState();
}

class _ReturnItemSelectionDialogState extends State<ReturnItemSelectionDialog> {
  late List<Map<String, dynamic>> orderItems;

  @override
  void initState() {
    super.initState();

    orderItems = (widget.orders[widget.index]["items"] as List)
        .map(
          (item) =>
              Map<String, dynamic>.from(item as Map)..["selected"] = false,
        )
        .toList();
  }

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
                    "Select Items to Return",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.font20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: Dimensions.height10 / 2),
                  Text(
                    "Choose which items from order ${widget.orders[widget.index]["orderId"]} you want to return",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: Dimensions.font16 - 2,
                    ),
                  ),
                ],
              ),
            ),

            /// Item Selection
            Padding(
              padding: EdgeInsets.all(Dimensions.width20),
              child: Column(
                children: [
                  ...orderItems.asMap().entries.map((entry) {
                    int itemIndex = entry.key;
                    Map<String, dynamic> item = entry.value;

                    return Container(
                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                      child: InkWell(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          setState(() {
                            orderItems[itemIndex]["selected"] =
                                !orderItems[itemIndex]["selected"];
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
                              color: item["selected"]
                                  ? Appcolors.gradientColor1
                                  : Colors.grey.shade300,
                              width: item["selected"] ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(
                              Dimensions.radius15,
                            ),
                            color: item["selected"]
                                ? Appcolors.gradientColor1.withValues(
                                    alpha: 0.05,
                                  )
                                : Colors.transparent,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                item["selected"]
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                color: item["selected"]
                                    ? Appcolors.gradientColor1
                                    : Colors.grey.shade400,
                                size: Dimensions.iconSize24 - 2,
                              ),
                              SizedBox(width: Dimensions.width10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item["name"],
                                      style: TextStyle(
                                        fontSize: Dimensions.font16 - 1,
                                        fontWeight: item["selected"]
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                        color: item["selected"]
                                            ? Appcolors.gradientColor1
                                            : Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "AED ${item["price"]}",
                                      style: TextStyle(
                                        fontSize: Dimensions.font16 - 2,
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),

                  SizedBox(height: Dimensions.height10),

                  /// Continue Button
                  SizedBox(
                    width: double.infinity,
                    height: Dimensions.height45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            orderItems.any((item) => item["selected"])
                                ? Appcolors.gradientColor1
                                : Colors.grey.shade300,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius15,
                          ),
                        ),
                      ),
                      onPressed: orderItems.any((item) => item["selected"])
                          ? () {
                              HapticFeedback.mediumImpact();
                              Navigator.pop(context);

                              List<Map<String, dynamic>> selectedItems =
                                  orderItems
                                      .where((item) => item["selected"])
                                      .toList();

                              widget.onContinue(
                                widget.index,
                                selectedItems,
                              );
                            }
                          : null,
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: orderItems.any((item) => item["selected"])
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