import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/settings_page.dart';
import 'package:weather_app/pages/weather_page.dart';
import 'package:weather_app/provider/weather_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'MerriWeatherSans',
        primarySwatch: Colors.blue,
      ),
      initialRoute: WeatherPage.routeName,
      routes: {
        WeatherPage.routeName: (_) => WeatherPage(),
        SettingsPage.routeName: (_) => SettingsPage(),
      },
    );
  }
}
