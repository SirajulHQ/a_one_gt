import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/features/address/view/add_edit_address_page.dart';
import 'package:a_one_gt/features/address/widgets/action_outlined_button_widget.dart';
import 'package:a_one_gt/features/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';

class SavedAddressesPage extends StatelessWidget {
  const SavedAddressesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,

      /// APPBAR
      appBar: CustomAppbar(title: "Saved Address"),

      /// BODY
      body: ListView(
        padding: EdgeInsets.all(Dimensions.width20),
        children: [
          /// ADD NEW ADDRESS
          OutlinedButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddEditAddressPage()),
              );
            },
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.all(Dimensions.width20),
              side: BorderSide(color: Appcolors.primaryGreen),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
              ),
              backgroundColor: Colors.white,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, color: Appcolors.primaryGreen),
                SizedBox(width: Dimensions.width10),
                Text(
                  "Add a new address",
                  style: TextStyle(
                    color: Appcolors.primaryGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: Dimensions.height15),

          /// ADDRESS LIST
          _addressCard(
            context,
            name: "Sirajul Haque",
            phone: "+91 9876543210",
            address:
                "Hilite Business Park, Ground Floor, Poovangal, Kozhikode, Kerala 673014",
            type: "HOME",
            isSelected: true,
          ),

          _addressCard(
            context,
            name: "Sirajul Haque",
            phone: "+91 9876543210",
            address: "Cyber Park, Kozhikode, Kerala 673016",
            type: "WORK",
          ),
        ],
      ),
    );
  }

  /// ADDRESS CARD
  Widget _addressCard(
    BuildContext context, {
    required String name,
    required String phone,
    required String address,
    required String type,
    bool isSelected = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.height15),
      padding: EdgeInsets.all(Dimensions.width20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER (NAME + TYPE)
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

              /// TYPE TAG
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

          /// ADDRESS
          Text(
            "$address\nPhone: $phone",
            style: TextStyle(color: Colors.grey.shade700, height: 1.4),
          ),

          SizedBox(height: Dimensions.height15),

          /// ACTIONS
          Row(
            children: [
              /// DELIVER HERE BUTTON
              Expanded(
                child: ActionOutlinedButtonWidget(
                  text: "Deliver Here",
                  color: Appcolors.primaryGreen,
                  isExpanded: true,
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                    vertical: 10,
                  ),
                  onPressed: () {
                    toastification.show(
                      context: context,
                      title: const Text("Address selected"),
                      autoCloseDuration: const Duration(seconds: 2),
                    );
                  },
                ),
              ),

              SizedBox(width: Dimensions.width20),

              /// EDIT
              ActionOutlinedButtonWidget(
                text: "Edit",
                icon: Icons.edit,
                color: Appcolors.primaryGreen,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AddEditAddressPage(isEdit: true),
                    ),
                  );
                },
              ),

              SizedBox(width: Dimensions.width20),

              /// DELETE
              ActionOutlinedButtonWidget(
                text: "Delete",
                icon: Icons.delete,
                color: Colors.red,
                onPressed: () {
                  // your delete logic
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
