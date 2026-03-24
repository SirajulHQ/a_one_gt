import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/features/my_orders/widgets/order_card_widget.dart';
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
      "items": ["Chicken Burger", "Pepsi"],
      "address": "Dubai Marina",
      "isExpanded": false,
    },
    {
      "orderId": "#X7Y8Z9",
      "date": "10 Mar 2026",
      "price": 899,
      "status": "Processing",
      "items": ["Pizza", "Fries"],
      "address": "JLT Cluster A",
      "isExpanded": false,
    },
    {
      "orderId": "#P4Q5R6",
      "date": "05 Mar 2026",
      "price": 299,
      "status": "Cancelled",
      "items": ["Sandwich"],
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Orders",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Appcolors.background,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Appcolors.gradientColor1, Appcolors.gradientColor2],
            ),
          ),
        ),
      ),
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
