import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/features/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';

class AddEditAddressPage extends StatefulWidget {
  final bool isEdit;

  const AddEditAddressPage({super.key, this.isEdit = false});

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

    if (widget.isEdit) {
      nameController.text = "Sirajul Haque";
      phoneController.text = "9876543210";
      pincodeController.text = "673014";
      addressController.text = "Hilite Business Park, Ground Floor";
      cityController.text = "Kozhikode";
      stateController.text = "Kerala";
      addressType = "Home";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,

      /// APPBAR
      appBar: CustomAppbar(
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
              _inputField(
                "Pincode",
                pincodeController,
                keyboard: TextInputType.number,
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

  /// INPUT FIELD
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

  /// 🔥 DROPDOWN
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

    toastification.show(
      context: context,
      title: Text(
        widget.isEdit
            ? "Address updated successfully"
            : "Address added successfully",
      ),
      autoCloseDuration: const Duration(seconds: 2),
    );

    Navigator.pop(context);
  }
}
