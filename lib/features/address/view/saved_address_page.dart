import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/features/address/view/add_edit_address_page.dart';
import 'package:a_one_gt/features/address/view/current_location_picker_page.dart';
import 'package:a_one_gt/features/address/widgets/action_outlined_button_widget.dart';
import 'package:a_one_gt/features/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';

class SavedAddressesPage extends StatefulWidget {
  const SavedAddressesPage({super.key});

  @override
  State<SavedAddressesPage> createState() => _SavedAddressesPageState();
}

class _SavedAddressesPageState extends State<SavedAddressesPage> {
  // Holds dynamically added addresses (from GPS or manual add)
  final List<Map<String, String>> _dynamicAddresses = [];

  void _openLocationPicker() async {
    HapticFeedback.lightImpact();
    final locationResult = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => const CurrentLocationPickerPage()),
    );
    if (locationResult == null || !mounted) return;

    // Navigate to AddEditAddressPage with pre-filled GPS data
    final addressResult = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => AddEditAddressPage(
          prefillStreet: locationResult['street'] as String?,
          prefillCity: locationResult['city'] as String?,
          prefillState: locationResult['state'] as String?,
          prefillPincode: locationResult['pincode'] as String?,
        ),
      ),
    );

    if (addressResult != null && mounted) {
      setState(() {
        _dynamicAddresses.add({
          'name': addressResult['name'] as String,
          'phone': addressResult['phone'] as String,
          'address': addressResult['address'] as String,
          'type': addressResult['type'] as String,
        });
      });
    }
  }

  void _openAddNewAddress() async {
    HapticFeedback.lightImpact();
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => const AddEditAddressPage()),
    );
    if (result != null && mounted) {
      setState(() {
        _dynamicAddresses.add({
          'name': result['name'] as String,
          'phone': result['phone'] as String,
          'address': result['address'] as String,
          'type': result['type'] as String,
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,
      appBar: CustomAppBar(title: "Saved Address"),
      body: ListView(
        padding: EdgeInsets.all(Dimensions.width20),
        children: [
          /// TOP BUTTONS
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _openAddNewAddress,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Appcolors.primaryGreen),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        Dimensions.radius15 - 10,
                      ),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
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
                ),
              ),
              SizedBox(width: Dimensions.width15),
              Expanded(
                child: OutlinedButton(
                  onPressed: _openLocationPicker,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Appcolors.primaryGreen),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        Dimensions.radius15 - 10,
                      ),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Appcolors.primaryGreen,
                        ),
                        SizedBox(width: Dimensions.width10),
                        Text(
                          "Use Current Location",
                          style: TextStyle(
                            color: Appcolors.primaryGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: Dimensions.height15),

          /// DYNAMIC ADDRESSES (from GPS or manual add)
          ..._dynamicAddresses.map(
            (a) => _addressCard(
              context,
              name: a['name']!,
              phone: a['phone']!,
              address: a['address']!,
              type: a['type']!,
            ),
          ),

          /// SAVED ADDRESS LIST
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
              ActionOutlinedButtonWidget(
                text: "Edit",
                icon: Icons.edit,
                color: Appcolors.primaryGreen,
                onPressed: () {
                  HapticFeedback.lightImpact();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AddEditAddressPage(isEdit: true),
                    ),
                  );
                },
              ),
              SizedBox(width: Dimensions.width20),
              ActionOutlinedButtonWidget(
                text: "Delete",
                icon: Icons.delete,
                color: Colors.red,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
