import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

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
                decoration: BoxDecoration(
                  color: const Color(0xffEDEDED),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              SizedBox(height: Dimensions.height45),

              /// Title
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: Dimensions.font26 + 6,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: Dimensions.height30),

              /// Email Field
              Container(
                height: Dimensions.height45 + 5,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                decoration: BoxDecoration(
                  color: const Color(0xffEDEDED),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
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
            ],
          ),
        ),
      ),
    );
  }
}
