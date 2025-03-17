import 'package:flutter/material.dart';
import 'screen/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'Flutter Hello World'),
    );
  }
}