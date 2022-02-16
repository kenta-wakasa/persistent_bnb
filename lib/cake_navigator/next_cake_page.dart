
import 'package:flutter/material.dart';

import '../main.dart';

class NextCakePage extends StatelessWidget {
  const NextCakePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cakeColor,
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: const Center(
        child: Icon(
          Icons.cake,
          size: 80,
          color: Colors.white,
        ),
      ),
    );
  }
}