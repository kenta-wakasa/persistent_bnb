import 'package:flutter/material.dart';

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
          builder: ((context) => page),
        );
      },
    );
  }
}
