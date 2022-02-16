import 'package:flutter/material.dart';

import '../main.dart';

class NextBackpackPage extends StatelessWidget {
  const NextBackpackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backpackColor,
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Icon(
          Icons.backpack,
          size: 80,
          color: Colors.white,
        ),
      ),
    );
  }
}
