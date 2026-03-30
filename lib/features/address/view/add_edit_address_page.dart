import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/features/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';

class AddEditAddressPage extends StatefulWidget {
  final bool isEdit;
  final String? prefillStreet;
  final String? prefillCity;
  final String? prefillState;
  final String? prefillPincode;
  final String? prefillName;
  final String? prefillPhone;
  final String? prefillType;

  const AddEditAddressPage({
    super.key,
    this.isEdit = false,
    this.prefillStreet,
    this.prefillCity,
    this.prefillState,
    this.prefillPincode,
    this.prefillName,
    this.prefillPhone,
    this.prefillType,
  });

  @override
  State<AddEditAddressPage> createState() => _AddEditAddressPageState();
}

class _AddEditAddressPageState extends State<AddEditAddressPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final pincodeController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();

  String addressType = "Home";

  final List<String> addressTypes = [
    "Home",
    "Flat",
    "Office",
    "Apartment",
    "Other",
  ];

  @override
  void initState() {
    super.initState();

    if (widget.prefillName != null) nameController.text = widget.prefillName!;
    if (widget.prefillPhone != null)
      phoneController.text = widget.prefillPhone!;
    if (widget.prefillStreet != null)
      addressController.text = widget.prefillStreet!;
    if (widget.prefillCity != null) cityController.text = widget.prefillCity!;
    if (widget.prefillState != null)
      stateController.text = widget.prefillState!;
    if (widget.prefillPincode != null)
      pincodeController.text = widget.prefillPincode!;
    if (widget.prefillType != null) {
      final matched = addressTypes.firstWhere(
        (t) => t.toUpperCase() == widget.prefillType!.toUpperCase(),
        orElse: () => "Home",
      );
      addressType = matched;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,

      /// APPBAR
      appBar: CustomAppBar(
        title: widget.isEdit ? "Edit Address" : "Add Address",
      ),

      /// BODY
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Dimensions.width20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _inputField("Full Name", nameController),
              _inputField(
                "Phone Number",
                phoneController,
                keyboard: TextInputType.phone,
              ),
              _inputField("Address (House, Area)", addressController),
              _inputField("City", cityController),
              _inputField("State", stateController),

              SizedBox(height: Dimensions.height20),

              /// 🔥 ADDRESS TYPE LABEL + DROPDOWN
              Text(
                "Address Type",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.font16 - 2,
                ),
              ),
              SizedBox(height: 6),
              _addressTypeDropdown(),

              SizedBox(height: Dimensions.height30),

              /// SAVE BUTTON
              SizedBox(
                width: double.infinity,
                height: Dimensions.height45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolors.primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                    ),
                  ),
                  onPressed: _saveAddress,
                  child: Text(
                    widget.isEdit ? "Update Address" : "Save Address",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(
    String hint,
    TextEditingController controller, {
    TextInputType keyboard = TextInputType.text,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.height15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius15),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: Dimensions.width20,
            vertical: Dimensions.height15,
          ),
          hintText: hint,
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Required";
          }
          return null;
        },
      ),
    );
  }

  Widget _addressTypeDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius15),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: addressType,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade700),
          style: TextStyle(
            fontSize: Dimensions.font16,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          onChanged: (value) {
            if (value == null) return;
            HapticFeedback.selectionClick();
            setState(() => addressType = value);
          },
          items: addressTypes.map((type) {
            return DropdownMenuItem(value: type, child: Text(type));
          }).toList(),
        ),
      ),
    );
  }

  /// SAVE ACTION
  void _saveAddress() {
    if (!_formKey.currentState!.validate()) return;

    HapticFeedback.mediumImpact();

    String fullAddress =
        '${addressController.text.trim()}, ${cityController.text.trim()}, ${stateController.text.trim()}';

    if (pincodeController.text.trim().isNotEmpty) {
      fullAddress += ' ${pincodeController.text.trim()}';
    }

    toastification.show(
      context: context,
      title: Text(
        widget.isEdit
            ? "Address updated successfully"
            : "Address added successfully",
      ),
      autoCloseDuration: const Duration(seconds: 2),
      type: ToastificationType.success,
      style: ToastificationStyle.minimal,
    );

    Navigator.pop(
      context,
      widget.isEdit
          ? null
          : {
              'name': nameController.text.trim(),
              'phone': phoneController.text.trim(),
              'address': fullAddress,
              'street': addressController.text.trim(),
              'city': cityController.text.trim(),
              'state': stateController.text.trim(),
              'pincode': pincodeController.text.trim(),
              'type': addressType.toUpperCase(),
            },
    );
  }
}
