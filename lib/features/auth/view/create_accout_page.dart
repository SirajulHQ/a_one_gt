import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  Widget buildTextField(String hint) {
    return Container(
      height: Dimensions.height45 + 5,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
      decoration: BoxDecoration(
        color: const Color(0xffEDEDED),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width20 * 1.8),
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

              /// First Name
              buildTextField("Firstname"),

              SizedBox(height: Dimensions.height20),

              /// Last Name
              buildTextField("Lastname"),

              SizedBox(height: Dimensions.height20),

              /// Email
              buildTextField("Email Address"),

              SizedBox(height: Dimensions.height20),

              /// Password
              buildTextField("Password"),

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
                  onPressed: () {},
                  child: const Text(
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
  }
}
