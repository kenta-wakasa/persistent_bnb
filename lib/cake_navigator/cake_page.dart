import 'package:flutter/material.dart';

import '../android_navigator/next_android_page.dart';
import '../main.dart';
import '../navigation_util.dart';
import 'next_cake_page.dart';

class CakePage extends StatelessWidget {
  const CakePage({
    Key? key,
    required this.handleBottomNavigation,
  }) : super(key: key);
  final void Function(int) handleBottomNavigation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cakeColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const NextCakePage();
                    },
                  ),
                );
              },
              child: const Icon(
                Icons.cake,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.pink,
              ),
              onPressed: () {
                handleBottomNavigation(0);
                NavigationUtil.instance.pushAndroidNavigatorAndRemoveUntilFirstPage(
                  page: const NextAndroidPage(),
                );
              },
              child: const Icon(Icons.android),
            ),
          ],
        ),
      ),
    );
  }
}
