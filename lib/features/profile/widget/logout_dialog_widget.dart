import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/features/auth/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LogoutDialogWidget extends StatelessWidget {
  const LogoutDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius20 + 4),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// ── Gradient Header ──
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.height30,
                horizontal: Dimensions.width20,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Appcolors.gradientColor1, Appcolors.gradientColor2],
                ),
              ),
              child: Column(
                children: [
                  /// Icon Circle
                  Container(
                    width: Dimensions.height45 + 20,
                    height: Dimensions.height45 + 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.15),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.25),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.logout_rounded,
                      color: Colors.white,
                      size: Dimensions.iconSize24 + 4,
                    ),
                  ),
                  SizedBox(height: Dimensions.height10),
                  Text(
                    "Logging out?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.font20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: Dimensions.height10 / 2),
                  Text(
                    "You'll need to sign in again\nto access your account.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.75),
                      fontSize: Dimensions.font16 - 2,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            /// ── Body ──
            Padding(
              padding: EdgeInsets.all(Dimensions.width20),
              child: Column(
                children: [
                  /// User info pill
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width15,
                      vertical: Dimensions.height10,
                    ),
                    decoration: BoxDecoration(
                      color: Appcolors.background,
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: Dimensions.height30 + 6,
                          height: Dimensions.height30 + 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Appcolors.primaryGreen.withOpacity(0.1),
                          ),
                          child: Icon(
                            Icons.person_outline,
                            color: Appcolors.primaryGreen,
                            size: Dimensions.iconSize24,
                          ),
                        ),
                        SizedBox(width: Dimensions.width10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sirajul Haque",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: Dimensions.font16 - 2,
                              ),
                            ),
                            Text(
                              "sirajul@gmail.com",
                              style: TextStyle(
                                fontSize: Dimensions.font16 - 4,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: Dimensions.height20),

                  /// Logout Button
                  SizedBox(
                    width: double.infinity,
                    height: Dimensions.height45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade50,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius15,
                          ),
                        ),
                      ),
                      onPressed: () {
                        HapticFeedback.mediumImpact();
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        "Yes, log me out",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.height10),

                  /// Cancel Button
                  SizedBox(
                    width: double.infinity,
                    height: Dimensions.height45,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black87,
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius15,
                          ),
                        ),
                      ),
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
