import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.height = 50,
      this.primaryColor = true,
      this.width = 100,
      this.backgroundColor,
      this.leftIcon,
      this.rightIcon})
      : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final double width;
  final double height;
  final bool primaryColor;
  final Color? backgroundColor;
  final AssetImage? leftIcon;
  final AssetImage? rightIcon;
 
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed.call();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(0, height),
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (leftIcon != null)
            ImageIcon(
              leftIcon,
              color: Colors.white,
            ),
          if (leftIcon != null || rightIcon != null) const Spacer(),
          Text(
            text,
            style: const TextStyle(
                color: const Color.fromARGB(250, 0, 0, 61),
                fontWeight: FontWeight.normal,
                fontSize: 18),
          ),
          if (leftIcon != null || rightIcon != null) const Spacer(),
          if (rightIcon != null)
            ImageIcon(
              rightIcon,
              color: Colors.white,
            ),
        ],
      ),
    );
  }
}
