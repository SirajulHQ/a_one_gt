import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ActionOutlinedButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? color;
  final bool useHaptic;
  final EdgeInsetsGeometry? padding;
  final bool isExpanded;
  final bool isFilled;

  const ActionOutlinedButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.color,
    this.useHaptic = true,
    this.padding,
    this.isExpanded = false,
    this.isFilled = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? Colors.green;

    return SizedBox(
      width: isExpanded ? double.infinity : null,
      child: OutlinedButton(
        onPressed: () {
          if (useHaptic) HapticFeedback.mediumImpact();
          onPressed();
        },
        style: OutlinedButton.styleFrom(
          padding:
              padding ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          side: BorderSide(color: buttonColor),
          backgroundColor: isFilled ? buttonColor : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: isFilled ? Colors.white : buttonColor,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              text,
              style: TextStyle(
                color: isFilled ? Colors.white : buttonColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
