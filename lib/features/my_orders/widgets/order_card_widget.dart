import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/apptheme/apptheme.dart';
import '../../../core/utils/dimensions.dart';

class OrderCardWidget extends StatelessWidget {
  final Map<String, dynamic> order;
  final int index;
  final Animation<double> animation;
  final VoidCallback onToggle;
  final VoidCallback? onReturn;
  final dynamic statusConfig;

  const OrderCardWidget({
    super.key,
    required this.order,
    required this.index,
    required this.animation,
    required this.onToggle,
    required this.statusConfig,
    this.onReturn,
  });

  @override
  Widget build(BuildContext context) {
    final cfg = statusConfig;

    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.height15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF065F46).withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Column(
          children: [
            /// TOP STRIP
            Container(
              height: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [cfg.color.withOpacity(0.5), cfg.color],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(Dimensions.width20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFF34D399).withOpacity(0.2),
                                  const Color(0xFF065F46).withOpacity(0.12),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.receipt_long_rounded,
                              color: Color(0xFF065F46),
                              size: 22,
                            ),
                          ),
                          SizedBox(width: Dimensions.width10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order["orderId"],
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_rounded,
                                    size: 11,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    order["date"],
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      /// STATUS
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: cfg.bg,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(cfg.icon, color: cfg.color, size: 13),
                            const SizedBox(width: 5),
                            Text(
                              cfg.label,
                              style: TextStyle(
                                color: cfg.color,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: Dimensions.height20),

                  /// PRICE + ITEMS
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FFFE),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: const Color(0xFF34D399).withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _infoTile(
                            icon: Icons.payments_rounded,
                            label: "Total",
                            value: "AED ${order["price"]}",
                            valueColor: Appcolors.primaryGreen,
                            bold: true,
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 36,
                          color: Colors.grey.shade200,
                        ),
                        Expanded(
                          child: _infoTile(
                            icon: Icons.fastfood_rounded,
                            label: "Items",
                            value: "${(order["items"] as List).length} items",
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: Dimensions.height15),

                  /// BUTTONS
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: onToggle,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            decoration: BoxDecoration(
                              color: order["isExpanded"]
                                  ? Appcolors.primaryGreen
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Appcolors.primaryGreen,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  order["isExpanded"]
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: order["isExpanded"]
                                      ? Colors.white
                                      : Appcolors.primaryGreen,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  order["isExpanded"]
                                      ? "Hide Details"
                                      : "View Details",
                                  style: TextStyle(
                                    color: order["isExpanded"]
                                        ? Colors.white
                                        : Appcolors.primaryGreen,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: Dimensions.width10),

                      Expanded(
                        child: GestureDetector(
                          onTap: () => HapticFeedback.mediumImpact(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            decoration: BoxDecoration(
                              color: Appcolors.primaryGreen,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.replay_rounded, color: Colors.white),
                                SizedBox(width: 6),
                                Text(
                                  "Reorder",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// EXPAND
                  SizeTransition(
                    sizeFactor: animation,
                    axisAlignment: -1,
                    child: Column(
                      children: [
                        SizedBox(height: Dimensions.height15),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _sectionLabel(
                                Icons.shopping_bag_rounded,
                                "Items Ordered",
                              ),
                              SizedBox(height: Dimensions.height10),

                              ...List.generate(
                                (order["items"] as List).length,
                                (i) => Text(order["items"][i]),
                              ),

                              SizedBox(height: Dimensions.height10),

                              _sectionLabel(
                                Icons.location_on_rounded,
                                "Delivery Address",
                              ),
                              SizedBox(height: Dimensions.height10),

                              Text(order["address"]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (order["status"] == "Delivered") ...[
                    SizedBox(height: Dimensions.height10),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        onReturn?.call();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.red.shade400,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.assignment_return_rounded,
                              color: Colors.red.shade400,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Return Order",
                              style: TextStyle(
                                color: Colors.red.shade400,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// INFO TILE
  Widget _infoTile({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
    bool bold = false,
  }) {
    return Column(
      children: [
        Icon(icon, size: 18, color: Appcolors.primaryGreen),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 11)),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  /// SECTION LABEL
  Widget _sectionLabel(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 15, color: const Color(0xFF059669)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
      ],
    );
  }
}
