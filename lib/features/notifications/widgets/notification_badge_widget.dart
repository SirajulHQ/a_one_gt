import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

class NotificationBadgeWidget extends StatelessWidget {
  final Widget child;
  final int count;
  final bool showBadge;

  const NotificationBadgeWidget({
    super.key,
    required this.child,
    this.count = 0,
    this.showBadge = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        if (showBadge && count > 0)
          Positioned(
            right: Dimensions.width10 - 8,
            top: Dimensions.height10 - 18,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.transparent,
                  width: Dimensions.width10 - 0.5,
                ),
              ),
              child: Center(
                child: Text(
                  count > 9 ? '9+' : count.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
