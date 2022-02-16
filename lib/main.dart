import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PersistentBNB',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          unselectedItemColor: Colors.grey[300],
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("ja", "JP"),
      ],
      home: WillPopScope(
        onWillPop: () async {
          // Android や iOS のスワイプジェスチャーでアプリが終了しないようにする
          NavigationUtil.instance.popUntilHome();
          return false;
        },
        child: const HomePage(),
      ),
    );
  }
}

const androidColor = Color(0xFFFF80A0);
const backpackColor = Color(0xFF66C3E3);
const cakeColor = Color(0xFFE3DA4F);

class NavigationUtil {
  NavigationUtil._();
  static final instance = NavigationUtil._();

  final homeNavigatorKey = GlobalKey<NavigatorState>();

  final androidNavigatorKey = GlobalKey<NavigatorState>();
  final backpackNavigatorKey = GlobalKey<NavigatorState>();
  final cakeNavigatorKey = GlobalKey<NavigatorState>();

  /// HOME画面まで戻る
  void popUntilHome() {
    homeNavigatorKey.currentState?.popUntil((route) => route.isFirst);
  }

  Future<T?> pushHomeNavigator<T>({required Widget page}) async {
    return _pushNavigator(key: homeNavigatorKey, page: page);
  }

  Future<T?> pushAndroidNavigatorAndRemoveUntilFirstPage<T>({required Widget page}) async {
    return _pushNavigatorAndRemoveUntilFirstPage(key: androidNavigatorKey, page: page);
  }

  Future<T?> _pushNavigator<T>({
    required GlobalKey<NavigatorState> key,
    required Widget page,
  }) async {
    return key.currentState?.push<T>(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  Future<T?> _pushNavigatorAndRemoveUntilFirstPage<T>({
    required GlobalKey<NavigatorState> key,
    required Widget page,
  }) async {
    return key.currentState?.pushAndRemoveUntil<T>(
      MaterialPageRoute(
        builder: (context) => page,
      ),
      (route) => route.isFirst,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  void handleBottomNavigation(int index) {
    setState(() {
      popUntilRootPageOnDoubleTap(index);
      currentIndex = index;
    });
  }

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

  /// [BottomNavigationBarItem]を二度タップした場合はそのNavigatorのRootPageに戻る
  void popUntilRootPageOnDoubleTap(int index) {
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

class NavigatorPage extends StatelessWidget {
  const NavigatorPage({
    Key? key,
    required this.globalKey,
    required this.page,
  }) : super(key: key);
  final GlobalKey<NavigatorState> globalKey;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: globalKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: ((context) {
            return page;
          }),
        );
      },
    );
  }
}

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

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: const Center(
        child: Text('ボトムナビゲーションバーを表示させないパターン'),
      ),
    );
  }
}
