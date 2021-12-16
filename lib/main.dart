import 'package:flutter/material.dart';
import 'package:exam/pages/home.dart';
import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: primaryColor,
        primaryColor: primaryColor,
      ),
      home: const HomeScreen(),

    );
  }
}
