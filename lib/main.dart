import 'package:flutter/material.dart';
import 'package:weatherapp/pages/current.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            appBarTheme: const AppBarTheme(color: Colors.blueGrey), scaffoldBackgroundColor: Colors.transparent),
        title: 'Weather App',
        home: const CurrentPage());
  }
}
