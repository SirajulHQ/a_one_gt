import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/features/checkout/view/checkout_page.dart';
import 'package:a_one_gt/features/my_orders/dummy_data/my_orders_dummy_data.dart';
import 'package:a_one_gt/features/my_orders/widgets/confirm_return_dialog_widget.dart';
import 'package:a_one_gt/features/my_orders/widgets/order_card_widget.dart';
import 'package:a_one_gt/features/my_orders/widgets/return_item_selection_dialog.dart';
import 'package:a_one_gt/features/my_orders/widgets/return_reason_dialog_widget.dart';
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
                      ? () => _showItemSelectionDialog(index)
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

  void _showItemSelectionDialog(int index) {
    showDialog(
      context: context,
      builder: (_) => ReturnItemSelectionDialog(
        index: index,
        orders: orders,
        onContinue: (index, selectedItems) {
          _showReturnReasonDialog(index, selectedItems);
        },
      ),
    );
  }

  void _showReturnReasonDialog(
    int index,
    List<Map<String, dynamic>> selectedItems,
  ) {
    showDialog(
      context: context,
      builder: (_) => ReturnReasonDialogWidget(
        index: index,
        selectedItems: selectedItems,
        orders: orders,
        onConfirm: _confirmReturn,
      ),
    );
  }

  void _confirmReturn(
    int index,
    String reason,
    List<Map<String, dynamic>> selectedItems,
  ) {
    showDialog(
      context: context,
      builder: (_) => ConfirmReturnDialogWidget(
        index: index,
        reason: reason,
        selectedItems: selectedItems,
        orders: orders,
        onUpdate: () {
          setState(() {});
        },
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
}
