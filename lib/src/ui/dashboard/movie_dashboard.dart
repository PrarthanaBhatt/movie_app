import 'package:flutter/material.dart';

class MovieDashboard extends StatelessWidget {
  const MovieDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.black45,
      ),
      body: const Center(
        child: Text("demo.."),
      ),
    );
  }
}
