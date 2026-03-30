import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/features/address/view/add_edit_address_page.dart';
import 'package:a_one_gt/features/address/view/current_location_picker_page.dart';
import 'package:a_one_gt/features/address/widgets/address_card_widget.dart';
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
  final List<Map<String, String>> _dynamicAddresses = [];
  int _selectedIndex = 0;

  void _openLocationPicker() async {
    HapticFeedback.lightImpact();
    final locationResult = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => const CurrentLocationPickerPage()),
    );
    if (locationResult == null || !mounted) return;

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
      setState(() => _dynamicAddresses.add(_mapFromResult(addressResult)));
    }
  }

  void _openAddNewAddress() async {
    HapticFeedback.lightImpact();
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => const AddEditAddressPage()),
    );
    if (result != null && mounted) {
      setState(() => _dynamicAddresses.add(_mapFromResult(result)));
    }
  }

  void _openEditAddress({
    required String name,
    required String phone,
    String? street,
    String? city,
    String? state,
    String? pincode,
    required String type,
  }) {
    HapticFeedback.lightImpact();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddEditAddressPage(
          isEdit: true,
          prefillName: name,
          prefillPhone: phone,
          prefillStreet: street,
          prefillCity: city,
          prefillState: state,
          prefillPincode: pincode,
          prefillType: type,
        ),
      ),
    );
  }

  // ── Actions ───────────────────────────────────────────────────────────────

  Map<String, String> _mapFromResult(Map<String, dynamic> result) => {
    'name': result['name'] as String,
    'phone': result['phone'] as String,
    'address': result['address'] as String,
    'street': result['street'] as String,
    'city': result['city'] as String,
    'state': result['state'] as String,
    'pincode': result['pincode'] as String,
    'type': result['type'] as String,
  };

  void _selectAddress(int index) {
    setState(() => _selectedIndex = index);
    toastification.show(
      context: context,
      title: const Text("Address selected"),
      autoCloseDuration: const Duration(seconds: 2),
      type: ToastificationType.success,
      style: ToastificationStyle.minimal,
    );
  }

  void _confirmDelete(int dynamicIndex) {
    HapticFeedback.lightImpact();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius15),
        ),
        title: const Text("Delete Address"),
        content: const Text("Are you sure you want to delete this address?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                if (_selectedIndex == dynamicIndex) _selectedIndex = 0;
                _dynamicAddresses.removeAt(dynamicIndex);
              });
              toastification.show(
                context: context,
                title: const Text("Address deleted"),
                autoCloseDuration: const Duration(seconds: 2),
                type: ToastificationType.error,
                style: ToastificationStyle.minimal,
              );
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,
      appBar: CustomAppBar(title: "Saved Address"),
      body: ListView(
        padding: EdgeInsets.all(Dimensions.width20),
        children: [
          Row(
            children: [
              Expanded(
                child: _topButton(
                  label: "Add a new address",
                  icon: Icons.add,
                  onPressed: _openAddNewAddress,
                ),
              ),
              SizedBox(width: Dimensions.width15),
              Expanded(
                child: _topButton(
                  label: "Use Current Location",
                  icon: Icons.location_on_outlined,
                  onPressed: _openLocationPicker,
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.height15),
          ..._dynamicAddresses.asMap().entries.map(
            (e) => AddressCardWidget(
              index: e.key,
              selectedIndex: _selectedIndex,
              name: e.value['name']!,
              phone: e.value['phone']!,
              address: e.value['address']!,
              type: e.value['type']!,
              street: e.value['street'],
              city: e.value['city'],
              state: e.value['state'],
              pincode: e.value['pincode'],
              dynamicIndex: e.key,
              onSelect: _selectAddress,
              onEdit: () => _openEditAddress(
                name: e.value['name']!,
                phone: e.value['phone']!,
                street: e.value['street'],
                city: e.value['city'],
                state: e.value['state'],
                pincode: e.value['pincode'],
                type: e.value['type']!,
              ),
              onDelete: _confirmDelete,
            ),
          ),
        ],
      ),
    );
  }

  Widget _topButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Appcolors.primaryGreen),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius15 - 10),
        ),
        backgroundColor: Colors.white,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Appcolors.primaryGreen),
            SizedBox(width: Dimensions.width10),
            Text(
              label,
              style: TextStyle(
                color: Appcolors.primaryGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
