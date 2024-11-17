import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final IconData iconData;
  final String hint;
  final TextInputType textInputType;
  final String validatorText;
  final int? maxLength;
  final TextInputFormatter? inputFormatter;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.iconData,
    this.maxLength,
    required this.hint,
    required this.validatorText,
    this.textInputType = TextInputType.text,
    this.inputFormatter,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      cursorColor: Colors.black,
      inputFormatters: widget.inputFormatter == null
          ? null
          : <TextInputFormatter>[
              widget.inputFormatter!,
            ],
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.iconData,
          size: 24,
        ),
        hintText: widget.hint,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
      ),
      validator: (text) {
        if (text == '' || text == null) {
          return widget.validatorText;
        }
        return null;
      },
    );
  }
}
