import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

class ExitDialogWidget extends StatelessWidget {
  const ExitDialogWidget({super.key});

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
            /// Gradient Header
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
                  Container(
                    width: Dimensions.height45 + 20,
                    height: Dimensions.height45 + 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.15),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.25),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                      size: Dimensions.iconSize24 + 4,
                    ),
                  ),
                  SizedBox(height: Dimensions.height10),
                  Text(
                    "Exit App?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.font20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: Dimensions.height10 / 2),
                  Text(
                    "Are you sure you want to exit the app?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.75),
                      fontSize: Dimensions.font16 - 2,
                    ),
                  ),
                ],
              ),
            ),

            /// Buttons
            Padding(
              padding: EdgeInsets.all(Dimensions.width20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: Dimensions.height45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade50,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius15,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text(
                        "Exit App",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.height10),
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
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(fontWeight: FontWeight.w600),
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
