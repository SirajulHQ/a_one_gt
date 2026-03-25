import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

class OtpDialogWidget extends StatefulWidget {
  final bool isDelete;

  const OtpDialogWidget({super.key, this.isDelete = false});

  @override
  State<OtpDialogWidget> createState() => _OtpDialogWidgetState();
}

class _OtpDialogWidgetState extends State<OtpDialogWidget> {
  final List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final confirmLabel = widget.isDelete
        ? "Confirm Deletion"
        : "Confirm Deactivation";

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
      child: Container(
        padding: EdgeInsets.all(Dimensions.width20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius20 + 4),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock_outline, size: 40, color: Appcolors.primaryGreen),
            SizedBox(height: Dimensions.height10),
            Text(
              "Enter Verification Code",
              style: TextStyle(
                fontSize: Dimensions.font20,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: Dimensions.height10),
            const Text(
              "Enter the 6 digit OTP sent to your email",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Dimensions.height20),

            /// OTP Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 45,
                  child: TextField(
                    controller: controllers[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: "",
                      filled: true,
                      fillColor: Appcolors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                );
              }),
            ),

            SizedBox(height: Dimensions.height20),

            /// Confirm Button
            SizedBox(
              width: double.infinity,
              height: Dimensions.height45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.isDelete
                      ? Colors.red
                      : Appcolors.primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  confirmLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
