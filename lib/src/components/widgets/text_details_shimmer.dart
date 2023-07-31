import 'package:flutter/material.dart';

class TextDetailsShimmer extends StatelessWidget {
  const TextDetailsShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      width: MediaQuery.of(context).size.width * 0.55,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(4)),
    );
  }
}
