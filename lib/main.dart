import 'package:flutter/material.dart';

import 'screens/home.dart';
import 'screens/second.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImmutableWidget(),
    );
  }
}
