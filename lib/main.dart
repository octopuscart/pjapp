import 'package:flutter/material.dart';
import 'package:pj_paul_ministries/views/home/home_menu.dart';
import 'views/home/home.dart';
import 'views/screens/commanview.dart';
import 'package:just_audio_background/just_audio_background.dart';
import './model/menuList.dart';

void main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'dr.legend.pj_paul_ministries',
    androidNotificationChannelName: 'Pjs Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.red,
      title: 'P.J Stephen Paul Ministries',
      theme: ThemeData(
        primaryColor: Colors.red,
        appBarTheme: const AppBarTheme(
          color: Colors.red,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.red,
          disabledColor: Colors.redAccent,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            elevation: 4,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white),
      ),
      home: const HomePage(title: 'P.J Stephen Paul Ministries'),
      initialRoute: 'home',
      routes: {
        'aboutus': (context) => const GallaryView(
            title: 'About Us', apilink: "listApiData/aboutUs"),
        'books-literatures': (context) => BooksLiteratures(),
        'paster-leaders': (context) => const GallaryView(
            title: 'Pastors & Leaders', apilink: "listApiData/pastorsLeaders"),
        'bible-college': (context) => const GallaryView(
            title: 'Bible College', apilink: "listApiData/bibleCollege"),
        'tv-programs': (context) => const GallaryView(
            title: 'Tv Programs', apilink: "listApiData/tvPrograms"),
        'our-charches': (context) => const GallaryView(
            title: 'Our Churches', apilink: "listApiData/ourChurchese"),
        'donate': (context) => const GallaryView(
            title: 'Donate', apilink: "listApiData/donateImages"),
        'charity-images': (context) => const GallaryView(
            title: 'Charity Work', apilink: "listApiData/charityImages"),
        'home': (context) =>
            const HomePage(title: 'P.J Stephen Paul Ministries'),
      },
    );
  }
}
