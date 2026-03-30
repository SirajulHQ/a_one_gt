import 'package:flutter/material.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/core/apptheme/apptheme.dart';

class EmailFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? error;
  final Function(String) onChanged;

  const EmailFieldWidget({
    super.key,
    required this.controller,
    required this.error,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: Dimensions.height45 + 5,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
          decoration: BoxDecoration(
            color: const Color(0xffEDEDED),
            borderRadius: BorderRadius.circular(10),
            border: error != null
                ? Border.all(color: Colors.red, width: 1.2)
                : null,
          ),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            onChanged: onChanged,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter Email address",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: Dimensions.font16 - 1,
              ),
            ),
          ),
        ),
        if (error != null) ErrorTextWidget(message: error!),
      ],
    );
  }
}

class OtpFieldsWidget extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final String? error;
  final Function(int, String) onChanged;

  const OtpFieldsWidget({
    super.key,
    required this.controllers,
    required this.focusNodes,
    required this.error,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(6, (index) {
            return SizedBox(
              width: Dimensions.height45 + 2,
              height: Dimensions.height45 + 10,
              child: TextField(
                controller: controllers[index],
                focusNode: focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                style: TextStyle(
                  fontSize: Dimensions.font20,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  counterText: "",
                  filled: true,
                  fillColor: const Color(0xffEDEDED),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: error != null
                        ? const BorderSide(color: Colors.red, width: 1.2)
                        : BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: error != null
                        ? const BorderSide(color: Colors.red, width: 1.2)
                        : BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Appcolors.primaryGreen,
                      width: 1.5,
                    ),
                  ),
                ),
                onChanged: (value) => onChanged(index, value),
              ),
            );
          }),
        ),
        if (error != null) ErrorTextWidget(message: error!),
      ],
    );
  }
}

class PasswordFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final VoidCallback onToggle;
  final String? error;
  final Function(String)? onChanged;

  const PasswordFieldWidget({
    super.key,
    required this.controller,
    required this.hint,
    required this.obscure,
    required this.onToggle,
    this.error,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: Dimensions.height45 + 5,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
          decoration: BoxDecoration(
            color: const Color(0xffEDEDED),
            borderRadius: BorderRadius.circular(10),
            border: error != null
                ? Border.all(color: Colors.red, width: 1.2)
                : null,
          ),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            onChanged: onChanged,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: Dimensions.font16 - 1,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  obscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
                onPressed: onToggle,
              ),
            ),
          ),
        ),
        if (error != null) ErrorTextWidget(message: error!),
      ],
    );
  }
}

class ErrorTextWidget extends StatelessWidget {
  final String message;

  const ErrorTextWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5, left: Dimensions.width10),
      child: Text(
        message,
        style: TextStyle(
          color: Colors.red,
          fontSize: Dimensions.font16 - 3,
        ),
      ),
    );
  }
}