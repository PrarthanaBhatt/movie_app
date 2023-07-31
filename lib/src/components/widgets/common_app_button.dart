import 'package:flutter/material.dart';

class CommonAppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CommonAppButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
          backgroundColor: const Color(0xFF3466AA),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );

    // ElevatedButton(
    //   onPressed: onPressed,
    //   child: Text(text),
    //   style: ElevatedButton.styleFrom(
    //       // Customize button appearance here
    //       // For example, you can set the background color, text color, padding, etc.
    //       ),
    // );
  }
}
