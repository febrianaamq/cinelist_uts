import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const SeriesListApp());
}

class SeriesListApp extends StatelessWidget {
  const SeriesListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'SeriesList',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6750a4),),
      useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}