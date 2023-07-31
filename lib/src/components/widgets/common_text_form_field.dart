import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final int? maxLength;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextCapitalization? textCapitalization;
  final Widget? suffixIcon;
  final bool? readOnly;
  final Function(String)? onChanged;
  final Function(String?)? validator;
  final void Function()? onTap;

  const CommonTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.maxLength,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.style,
    this.labelStyle,
    this.textCapitalization,
    this.suffixIcon,
    this.readOnly = false,
    this.onChanged,
    this.validator,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: TextFormField(
        keyboardType: keyboardType,
        style: const TextStyle(color: Color(0xFFF1F1F1)),
        inputFormatters: inputFormatters,
        textCapitalization: TextCapitalization.words,
        maxLength: maxLength,
        obscureText: obscureText,
        controller: controller,
        readOnly: readOnly!,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            color: Color(0xFFF1F1F1),
            fontWeight: FontWeight.normal,
          ),
          hintText: "",
          counterText: "",
          suffixIcon: suffixIcon,
          suffixIconColor: const Color(0xFFF1F1F1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: Color(0xFFF1F1F1)),
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Color(0xFF3466AA), width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.red, width: 1.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        ),
        validator: (str) => validator!.call(str),
        onTap: onTap,
        onChanged: onChanged,
      ),
    );
  }
}
