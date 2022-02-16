import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'home_page.dart';
import 'navigation_util.dart';

const androidColor = Color(0xFFFF80A0);
const backpackColor = Color(0xFF66C3E3);
const cakeColor = Color(0xFFE3DA4F);

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
