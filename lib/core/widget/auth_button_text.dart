import 'package:bookkia/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AuthButtonText extends StatelessWidget {
  const AuthButtonText({
    super.key,
    required this.leftText,
    required this.rigthText,
    this.onRigthTap,
    this.leftStyle,
    this.rigthStyle,
  });

  final String leftText;
  final String rigthText;
  final VoidCallback? onRigthTap;
  final TextStyle? leftStyle;
  final TextStyle? rigthStyle;

  @override
  Widget build(BuildContext context) {

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(leftText, style: leftStyle),
        GestureDetector(
          onTap: onRigthTap,
          child: Text(
            rigthText,
            style: rigthStyle ??
                TextStyle(
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}