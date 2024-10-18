import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    Key? key,
    required this.userEditingController,
    this.prefixIconData,
    this.suffixIconData,
    this.obscure = false,
    this.hint = '',
    this.contentPadding = 16,
    this.maxLenght = 0,
    this.numeric = false,
    this.enable = true,
  }) : super(key: key);

  final TextEditingController userEditingController;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  bool obscure;
  final String hint;
  final double contentPadding;
  final int maxLenght;
  final bool numeric;
  final bool enable;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: widget.enable,
      maxLength: widget.maxLenght == 0 ? null : widget.maxLenght,
      controller: widget.userEditingController,
      obscureText: widget.obscure,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.normal, fontSize: 18),
      keyboardType: widget.numeric ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white, width: 1.0)),
        prefixIcon: Icon(
          widget.prefixIconData,
          color: Colors.white,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              widget.obscure = !widget.obscure;
            });
          },
          icon: Icon(widget.suffixIconData),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: widget.hint,
        hintStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.normal, fontSize: 18),
        contentPadding: EdgeInsets.symmetric(vertical: widget.contentPadding),
      ),
    );
  }
}
