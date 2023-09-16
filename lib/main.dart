import 'package:flutter/material.dart';
import 'views/home/home.dart';
import 'views/screens/commanview.dart';
import 'package:just_audio_background/just_audio_background.dart';

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
        appBarTheme: AppBarTheme(
          color: Colors.red,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.red,
          disabledColor: Colors.redAccent,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            elevation: 4,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white),
      ),
      home: const HomePage(title: 'P.J Stephen Paul Ministries'),
      initialRoute: 'home',
      routes: {
        'aboutus': (context) =>
            GallaryView(title: 'About Us', apilink: "listApiData/aboutUs"),
        'books-literatures': (context) => BooksLiteratures(),
        'paster-leaders': (context) => GallaryView(
            title: 'Pastors & Leaders', apilink: "listApiData/pastorsLeaders"),
        'bible-college': (context) => GallaryView(
            title: 'Bible College', apilink: "listApiData/bibleCollege"),
        'tv-programs': (context) => GallaryView(
            title: 'Tv Programs', apilink: "listApiData/tvPrograms"),
        'our-charches': (context) => GallaryView(
            title: 'Our Churches', apilink: "listApiData/ourChurchese"),
        'donate': (context) =>
            GallaryView(title: 'Donate', apilink: "listApiData/donateImages"),
        'charity-images': (context) => GallaryView(
            title: 'Charity Work', apilink: "listApiData/charityImages"),
        'home': (context) => HomePage(title: 'P.J Stephen Paul Ministries'),
      },
    );
  }
}
