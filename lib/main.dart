import 'package:flutter/material.dart';
import 'views/home/home.dart';
import 'views/screens/commanview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'P.J Stephen Paul Ministries',
      theme: ThemeData(
        primaryColor: Colors.red,
        appBarTheme: AppBarTheme(
          color: Colors.red,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            elevation: 4,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white),
      ),
      home: const HomePage(title: 'P.J Stephen Paul Ministries'),
      initialRoute: 'home',
      routes: {
        'aboutus': (context) => AboutUs(title: 'About Us'),
        'books-literatures': (context) => BooksLiteratures(),
        'paster-leaders': (context) =>
            PastorsLeaders(title: 'Pastors & Leaders'),
        'bible-college': (context) => BibleCollege(title: 'Bible College'),
        'tv-programs': (context) => TvPrograms(title: 'Tv Programs'),
        'our-charches': (context) => OurChurches(title: 'Our Churches'),
        'home': (context) => HomePage(title: 'P.J Stephen Paul Ministries'),
      },
    );
  }
}
