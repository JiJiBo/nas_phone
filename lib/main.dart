import 'package:flutter/material.dart';
import 'package:nas_phone/ui/AddPage.dart';
import 'package:nas_phone/ui/HomePage.dart';
import 'package:nas_phone/ui/WelcomePage.dart';

import 'mobox/route.dart';
import 'np.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initBengBengDefault();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final routes = {
    routeStore.welcome_ui_route: (context, {arguments}) => WelcomePage(),
    routeStore.home_ui_route: (context, {arguments}) => HomePage(),
    routeStore.add_ui_route: (context, {arguments}) => AddPage(),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '电话本',
      routes: routes,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
    );
  }
}
