import 'package:flutter/material.dart';

class NextAndroidPage extends StatelessWidget {
  const NextAndroidPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF80A0),
      appBar: AppBar(
        backgroundColor: Colors.pink,
      ),
      body: const Center(
        child: Icon(
          Icons.android,
          size: 80,
          color: Colors.white,
        ),
      ),
    );
  }
}
