import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailSigninPage extends StatelessWidget {
  const EmailSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Dimensions.height30 * 3,
            horizontal: Dimensions.width20 * 1.8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Dimensions.height15),
              Text(
                "Sign in",
                style: TextStyle(
                  fontSize: Dimensions.font26 + 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: Dimensions.height45),

              Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Email Address",
                  ),
                ),
              ),

              SizedBox(height: Dimensions.height20),

              /// Continue Button
              SizedBox(
                width: double.infinity,
                height: Dimensions.height45 + 5,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolors.primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Navigator.pushNamed(context, '/password');
                  },
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: Dimensions.height10),

              /// Create account
              InkWell(
                onTap: () {
                  HapticFeedback.lightImpact();
                  Navigator.pushNamed(context, '/create_account');
                },
                child: Row(
                  children: [
                    Text(
                      "Dont have an Account ? ",
                      style: TextStyle(fontSize: Dimensions.font16 - 2),
                    ),
                    Text(
                      "Create One",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              SizedBox(height: Dimensions.height45),
              socialButton(icon: Icons.apple, text: "Continue With Apple"),
              SizedBox(height: Dimensions.height15),
              socialButton(
                icon: Icons.g_mobiledata,
                text: "Continue With Google",
              ),
              SizedBox(height: Dimensions.height15),
              socialButton(
                icon: Icons.facebook,
                text: "Continue With Facebook",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget socialButton({required IconData icon, required String text}) {
    return Container(
      height: Dimensions.height45 + 7,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: Dimensions.iconSize24),
          SizedBox(width: Dimensions.width10 + 4),
          Text(
            text,
            style: TextStyle(
              fontSize: Dimensions.font16 - 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
