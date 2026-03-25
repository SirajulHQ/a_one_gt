import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/features/settings/widgets/otp_dialog_widget.dart';
import 'package:flutter/material.dart';

class ConfirmationDialogWidget extends StatelessWidget {
  final bool isDelete;

  const ConfirmationDialogWidget({super.key, this.isDelete = false});

  @override
  Widget build(BuildContext context) {
    final icon = isDelete ? Icons.delete_outline : Icons.stop_circle_outlined;
    final title = isDelete ? "Delete Account?" : "Deactivate Account?";
    final subtitle = isDelete
        ? "This action is permanent and cannot be undone."
        : "You can reactivate anytime by logging in again.";
    final confirmLabel = isDelete ? "Yes, Delete" : "Yes, Deactivate";
    final confirmColor = isDelete ? Colors.red : Colors.orange;
    final confirmBgColor = isDelete
        ? Colors.red.shade50
        : Colors.orange.shade50;

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
            /// Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.height30,
                horizontal: Dimensions.width20,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
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
                      color: Colors.white.withOpacity(0.15),
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: Dimensions.iconSize24 + 6,
                    ),
                  ),
                  SizedBox(height: Dimensions.height10),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.font20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: Dimensions.height10 / 2),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white.withOpacity(0.75)),
                  ),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: EdgeInsets.all(Dimensions.width20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: Dimensions.height45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: confirmBgColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius15,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (_) => OtpDialogWidget(isDelete: isDelete),
                        );
                      },
                      child: Text(
                        confirmLabel,
                        style: TextStyle(
                          color: confirmColor,
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
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
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
