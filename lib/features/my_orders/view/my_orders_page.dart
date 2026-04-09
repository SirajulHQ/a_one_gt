import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/features/checkout/view/checkout_page.dart';
import 'package:a_one_gt/features/my_orders/widgets/order_card_widget.dart';
import 'package:a_one_gt/features/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage>
    with TickerProviderStateMixin {
  final List<Map<String, dynamic>> orders = [
    {
      "orderId": "#A1B2C3",
      "date": "12 Mar 2026",
      "price": 499,
      "status": "Delivered",
      "items": [
        {"name": "Chicken Burger", "price": 299},
        {"name": "Pepsi", "price": 200},
      ],
      "address": "Dubai Marina",
      "isExpanded": false,
    },
    {
      "orderId": "#X7Y8Z9",
      "date": "10 Mar 2026",
      "price": 899,
      "status": "Processing",
      "items": [
        {"name": "Pizza", "price": 599},
        {"name": "Fries", "price": 300},
      ],
      "address": "JLT Cluster A",
      "isExpanded": false,
    },
    {
      "orderId": "#P4Q5R6",
      "date": "05 Mar 2026",
      "price": 299,
      "status": "Cancelled",
      "items": [
        {"name": "Sandwich", "price": 299},
      ],
      "address": "Downtown Dubai",
      "isExpanded": false,
    },
  ];

  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      orders.length,
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 350),
      ),
    );
    _animations = _controllers
        .map((c) => CurvedAnimation(parent: c, curve: Curves.easeInOut))
        .toList();
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _toggleExpand(int index) {
    setState(() {
      orders[index]["isExpanded"] = !orders[index]["isExpanded"];
    });
    if (orders[index]["isExpanded"]) {
      _controllers[index].forward();
    } else {
      _controllers[index].reverse();
    }
    HapticFeedback.selectionClick();
  }

  void _confirmReturn(int index) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
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
                      "Return Order?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.font20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: Dimensions.height10 / 2),
                    Text(
                      "Are you sure you want to return order ${orders[index]["orderId"]}?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: Dimensions.font16 - 2,
                      ),
                    ),
                  ],
                ),
              ),

              /// Buttons
              Padding(
                padding: EdgeInsets.all(Dimensions.width20),
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
                          setState(() => orders[index]["status"] = "Returned");
                        },
                        child: const Text(
                          "Yes, Return Order",
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
      ),
    );
  }

  /// Status config
  StatusConfig _getStatusConfig(String status) {
    switch (status) {
      case "Delivered":
        return StatusConfig(
          color: const Color(0xFF22C55E),
          bg: const Color(0xFFDCFCE7),
          icon: Icons.check_circle_rounded,
          label: "Delivered",
        );
      case "Processing":
        return StatusConfig(
          color: const Color(0xFFF59E0B),
          bg: const Color(0xFFFEF3C7),
          icon: Icons.autorenew_rounded,
          label: "Processing",
        );
      case "Cancelled":
        return StatusConfig(
          color: const Color(0xFFEF4444),
          bg: const Color(0xFFFEE2E2),
          icon: Icons.cancel_rounded,
          label: "Cancelled",
        );
      case "Returned":
        return StatusConfig(
          color: const Color(0xFF8B5CF6),
          bg: const Color(0xFFEDE9FE),
          icon: Icons.assignment_return_rounded,
          label: "Returned",
        );
      default:
        return StatusConfig(
          color: Colors.grey,
          bg: Colors.grey.shade100,
          icon: Icons.help_outline_rounded,
          label: status,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "My orders"),
      backgroundColor: Appcolors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          /// ─── ORDER LIST ───────────────────────────────────────────────
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              Dimensions.width20,
              Dimensions.height20,
              Dimensions.width20,
              Dimensions.height20 + 20,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => OrderCardWidget(
                  order: orders[index],
                  index: index,
                  animation: _animations[index],
                  onToggle: () => _toggleExpand(index),
                  statusConfig: _getStatusConfig(orders[index]["status"]),
                  onReturn: orders[index]["status"] == "Delivered"
                      ? () => _confirmReturn(index)
                      : null,
                  onReorder: () {
                    HapticFeedback.mediumImpact();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CheckoutPage(
                          category: "reorder",
                          reorderItems: List<Map<String, dynamic>>.from(
                            orders[index]["items"],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                childCount: orders.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
