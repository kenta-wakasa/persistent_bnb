import 'package:flutter/material.dart';

import 'android_navigator/android_page.dart';
import 'backpack_navigator/backpack_page.dart';
import 'cake_navigator/cake_page.dart';
import 'navigation_util.dart';
import 'navigator_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  late final pages = [
    NavigatorPage(
      page: const AndroidPage(),
      globalKey: NavigationUtil.instance.androidNavigatorKey,
    ),
    NavigatorPage(
      page: const BackpackPage(),
      globalKey: NavigationUtil.instance.backpackNavigatorKey,
    ),
    NavigatorPage(
      page: CakePage(handleBottomNavigation: handleBottomNavigation),
      globalKey: NavigationUtil.instance.cakeNavigatorKey,
    ),
  ];

  /// ボトムナビゲーションバーをタップしたときの挙動
  void handleBottomNavigation(int index) {
    setState(() {
      _popUntilRootPageOnDoubleTap(index);
      currentIndex = index;
    });
  }

  /// [BottomNavigationBarItem]を二度タップした場合はそのNavigatorのRootPageに戻る
  void _popUntilRootPageOnDoubleTap(int index) {
    for (var i = 0; i < pages.length; i++) {
      if (currentIndex == i && index == i) {
        pages[i].globalKey.currentState?.popUntil((root) => root.isFirst);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: NavigationUtil.instance.homeNavigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: ((context) {
            return Scaffold(
              body: IndexedStack(
                index: currentIndex,
                children: pages,
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap: handleBottomNavigation,
                currentIndex: currentIndex,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.android),
                    label: 'Android',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.backpack),
                    label: 'Backpack',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.cake),
                    label: 'Cake',
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
