import 'package:flutter/material.dart';
import 'screen/Home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: const MyHomePage(title: 'Flutter Hello World'),
    );
  }
}