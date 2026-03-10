import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

class PasswordSigninPage extends StatelessWidget {
  const PasswordSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,
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
                "Sign in",
                style: TextStyle(
                  fontSize: Dimensions.font26 + 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: Dimensions.height45),

              /// Password Field
              Container(
                height: Dimensions.height45 + 3,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                decoration: BoxDecoration(
                  color: const Color(0xffF2F2F2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: Dimensions.font16 - 1,
                    ),
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
                    Navigator.pushNamed(context, '/categories');
                  },
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

              const SizedBox(height: 20),

              /// Forgot Password
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/forgot_password');
                },
                child: Row(
                  children: const [
                    Text(
                      "Forgot Password ? ",
                      style: TextStyle(fontSize: 15, color: Colors.black87),
                    ),
                    Text(
                      "Reset",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
