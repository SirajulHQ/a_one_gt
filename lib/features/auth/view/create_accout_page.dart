import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/features/auth/controller/create_account_controller.dart';
import 'package:a_one_gt/features/category/view/Categories_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

import 'package:toastification/toastification.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateAccountController(),
      child: Consumer<CreateAccountController>(
        builder: (context, controller, child) {
          return Scaffold(
            backgroundColor: Appcolors.background,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width20 * 1.8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Dimensions.height20),

                    /// Back Button
                    Container(
                      height: Dimensions.height45,
                      width: Dimensions.height45,
                      decoration: const BoxDecoration(
                        color: Color(0xffEDEDED),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                        },
                      ),
                    ),

                    SizedBox(height: Dimensions.height45),

                    /// Title
                    Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: Dimensions.font26 + 6,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(height: Dimensions.height30),

                    buildTextField("Firstname", firstNameController),
                    SizedBox(height: Dimensions.height20),

                    buildTextField("Lastname", lastNameController),
                    SizedBox(height: Dimensions.height20),

                    buildTextField("Email Address", emailController),
                    SizedBox(height: Dimensions.height20),

                    buildTextField("Phone Number", phoneController),
                    SizedBox(height: Dimensions.height20),

                    buildTextField(
                      "Password",
                      passwordController,
                      isPassword: true,
                    ),

                    SizedBox(height: Dimensions.height30),

                    /// Continue Button
                    SizedBox(
                      width: double.infinity,
                      height: Dimensions.height45 + 5,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Appcolors.primaryGreen,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: controller.isLoading
                            ? null
                            : () async {
                                log(
                                  '🎯 [CreateAccountPage] Continue button pressed',
                                );
                                HapticFeedback.lightImpact();

                                // Validate input fields
                                final firstName = firstNameController.text
                                    .trim();
                                final lastName = lastNameController.text.trim();
                                final email = emailController.text.trim();
                                final password = passwordController.text.trim();

                                log(
                                  '📝 [CreateAccountPage] Form data collected:',
                                );
                                log('   - First Name: $firstName');
                                log('   - Last Name: $lastName');
                                log('   - Email: $email');
                                log(
                                  '   - Password: ${password.isNotEmpty ? "[PROVIDED]" : "[EMPTY]"}',
                                );

                                // Basic validation
                                if (firstName.isEmpty ||
                                    lastName.isEmpty ||
                                    email.isEmpty ||
                                    password.isEmpty) {
                                  log(
                                    '⚠️ [CreateAccountPage] Validation failed: Empty fields detected',
                                  );
                                  toastification.show(
                                    context: context,
                                    title: const Text("Please fill all fields"),
                                    type: ToastificationType.warning,
                                    style: ToastificationStyle.minimal,
                                    autoCloseDuration: const Duration(
                                      seconds: 3,
                                    ),
                                  );
                                  return;
                                }

                                log(
                                  '✅ [CreateAccountPage] Validation passed, calling controller.register()',
                                );

                                await controller.register(
                                  firstName: firstName,
                                  lastName: lastName,
                                  email: email,
                                  password: password,
                                );

                                log(
                                  '🔄 [CreateAccountPage] Controller.register() completed',
                                );
                                log(
                                  '📊 [CreateAccountPage] Registration result:',
                                );
                                log(
                                  '   - Error: ${controller.errorMessage ?? "None"}',
                                );
                                log(
                                  '   - Success: ${controller.errorMessage == null}',
                                );

                                if (controller.errorMessage == null) {
                                  log(
                                    '🎉 [CreateAccountPage] Registration successful, showing success message',
                                  );
                                  toastification.show(
                                    context: context,
                                    title: const Text(
                                      "Registration Successful",
                                    ),
                                    type: ToastificationType.success,
                                    style: ToastificationStyle.minimal,
                                    autoCloseDuration: const Duration(
                                      seconds: 3,
                                    ),
                                  );
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const CategoriesPage(),
                                    ),
                                    (route) => false,
                                  );
                                } else {
                                  log(
                                    '❌ [CreateAccountPage] Registration failed, showing error message',
                                  );
                                  toastification.show(
                                    context: context,
                                    title: Text(controller.errorMessage!),
                                    type: ToastificationType.error,
                                    style: ToastificationStyle.minimal,
                                    autoCloseDuration: const Duration(
                                      seconds: 3,
                                    ),
                                  );
                                }
                              },
                        child: controller.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Continue",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    ),

                    SizedBox(height: Dimensions.height30),

                    /// Already have an Account
                    InkWell(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Text(
                            "Already have an account ? ",
                            style: TextStyle(
                              fontSize: Dimensions.font16 - 1,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: Dimensions.font16 - 1,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
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
        },
      ),
    );
  }

  Widget buildTextField(
    String hint,
    TextEditingController controller, {
    bool isPassword = false,
  }) {
    return Container(
      height: Dimensions.height45 + 5,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
      decoration: BoxDecoration(
        color: const Color(0xffEDEDED),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: Dimensions.font16 - 1,
          ),
        ),
      ),
    );
  }
}
