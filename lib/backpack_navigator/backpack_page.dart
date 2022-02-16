import 'package:flutter/material.dart';

import '../main.dart';
import 'next_backpack_page.dart';

class BackpackPage extends StatelessWidget {
  const BackpackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backpackColor,
      body: Center(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const NextBackpackPage();
                  },
                ),
              );
            },
            child: const Icon(Icons.backpack)),
      ),
    );
  }
}
