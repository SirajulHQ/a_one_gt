import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/features/address/widgets/action_outlined_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddressCardWidget extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String name;
  final String phone;
  final String address;
  final String type;
  final String? street;
  final String? city;
  final String? state;
  final String? pincode;
  final int? dynamicIndex;

  final Function(int index) onSelect;
  final VoidCallback onEdit;
  final Function(int dynamicIndex) onDelete;

  const AddressCardWidget({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.name,
    required this.phone,
    required this.address,
    required this.type,
    required this.onSelect,
    required this.onEdit,
    required this.onDelete,
    this.street,
    this.city,
    this.state,
    this.pincode,
    this.dynamicIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;

    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.height15),
      padding: EdgeInsets.all(Dimensions.width20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius15),
        border: isSelected
            ? Border.all(color: Appcolors.primaryGreen, width: 1.5)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.font16,
                ),
              ),
              SizedBox(width: Dimensions.width10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  type,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (isSelected) ...[
                SizedBox(width: Dimensions.width10),
                const Text(
                  "SELECTED",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),

          SizedBox(height: Dimensions.height10),

          Text(
            "$address\nPhone: $phone",
            style: TextStyle(color: Colors.grey.shade700, height: 1.4),
          ),

          SizedBox(height: Dimensions.height15),

          /// ACTIONS
          Row(
            children: [
              Expanded(
                child: ActionOutlinedButtonWidget(
                  text: isSelected ? "Delivering Here" : "Deliver Here",
                  color: Appcolors.primaryGreen,
                  isExpanded: true,
                  isFilled: isSelected,
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                    vertical: 10,
                  ),
                  onPressed: () => onSelect(index),
                ),
              ),
              SizedBox(width: Dimensions.width20),
              ActionOutlinedButtonWidget(
                text: "Edit",
                icon: Icons.edit,
                color: Appcolors.primaryGreen,
                onPressed: () {
                  HapticFeedback.lightImpact();
                  onEdit();
                },
              ),
              SizedBox(width: Dimensions.width20),
              ActionOutlinedButtonWidget(
                text: "Delete",
                icon: Icons.delete,
                color: dynamicIndex != null ? Colors.red : Colors.grey.shade400,
                onPressed: dynamicIndex != null
                    ? () => onDelete(dynamicIndex!)
                    : () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
