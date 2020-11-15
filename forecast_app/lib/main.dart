
import 'package:flutter/material.dart';
import 'package:forecast_app/user-interface/forecast_ui.dart';
import 'package:forecast_app/user-interface/search_city_ui.dart';

String cityNames;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: ForecastPage(),//(title: 'Flutter Weather Forecast'),
    );
  }
}

