import 'package:flutter/material.dart';

import '../main.dart';
import '../navigation_util.dart';
import '../setting_page.dart';
import 'next_android_page.dart';

class AndroidPage extends StatelessWidget {
  const AndroidPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: androidColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  NavigationUtil.instance.pushHomeNavigator(
                    page: const SettingPage(),
                  );
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.pink,
            ),
            onPressed: () {
              // 特定のNavigatorの中で普通にpushすればそのNavigatorの上に重なっていくようになる
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const NextAndroidPage();
                  },
                ),
              );
            },
            child: const Icon(Icons.android),
          ),
        ],
      ),
    );
  }
}
