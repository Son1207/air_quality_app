import 'package:air_quality_app/page/HomePage.dart';
import 'package:flutter/material.dart';


void main() => runApp(const AirQualityApp());

class AirQualityApp extends StatelessWidget {
  const AirQualityApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const AirQualityHomePage(),
    );
  }
}

