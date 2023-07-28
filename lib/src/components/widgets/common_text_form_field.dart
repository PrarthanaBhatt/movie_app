import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final int? maxLength;

  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CommonTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.maxLength,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: TextFormField(
        keyboardType: keyboardType,
        style: const TextStyle(color: Color(0xFFF1F1F1)),
        inputFormatters:
            inputFormatters ?? [FilteringTextInputFormatter.digitsOnly],
        maxLength: maxLength,
        controller: controller,
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
        validator: validator,
      ),
    );
  }
}
