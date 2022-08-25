import 'package:flutter/material.dart';
import 'package:flutter_firebase_bloc_with_peter/helpers/color_helper.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback? voidCallback;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final double? height;
  final double? width;
  final double fontSize;
  final double borderRadius;
  const CustomTextButton({
    Key? key,
    required this.voidCallback,
    required this.text,
    this.backgroundColor = ColorHelper.themeColor,
    this.textColor = Colors.black,
    this.height,
    this.width,
    this.fontSize = 16.0,
    this.borderRadius = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        onPressed: () => voidCallback?.call(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: fontSize),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
