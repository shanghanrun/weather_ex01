import 'package:flutter/material.dart';

import 'loading.dart';
import 'screens/screenA.dart';
import 'screens/screenB.dart';
import 'screens/screenC.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Colors.blue),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const ScreenA(),
      //   '/screenB': (context) => const ScreenB(),
      //   '/screenC': (context) => const ScreenC(),
      // },
      home: const Loading(),
    );
  }
}
