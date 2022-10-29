import 'package:flutter/material.dart';
import 'package:pj_paul_ministries/views/ui/uiwidget.dart';

// Our churches
class OurChurches extends StatefulWidget {
  const OurChurches({super.key, required this.title});
  final String title;
  @override
  State<OurChurches> createState() => _OurChurchesState();
}

class _OurChurchesState extends State<OurChurches> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ImageViewer(
          apilink: "ourChurchese",
        ));
  }
}

// Tv Program
class TvPrograms extends StatefulWidget {
  const TvPrograms({super.key, required this.title});
  final String title;
  @override
  State<TvPrograms> createState() => _TvProgramsState();
}

class _TvProgramsState extends State<TvPrograms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ImageViewer(
          apilink: "tvPrograms",
        ));
  }
}

// Bible College
class BibleCollege extends StatefulWidget {
  const BibleCollege({super.key, required this.title});
  final String title;
  @override
  State<BibleCollege> createState() => _BibleCollegeState();
}

class _BibleCollegeState extends State<BibleCollege> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ImageViewer(
          apilink: "bibleCollege",
        ));
  }
}

// Paster & Leaders
class PastorsLeaders extends StatefulWidget {
  const PastorsLeaders({super.key, required this.title});
  final String title;
  @override
  State<PastorsLeaders> createState() => _PastorsLeadersState();
}

class _PastorsLeadersState extends State<PastorsLeaders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ImageViewer(
          apilink: "pastorsLeaders",
        ));
  }
}

//Books & Literatures
class BooksLiteratures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books & Literatures'),
      ),
      // backgroundColor: Colors.black,
      body: Container(
        child: Center(child: Image.asset('assets/books.jpg')),
      ),
    );
  }
}

// About us
class AboutUs extends StatefulWidget {
  const AboutUs({super.key, required this.title});
  final String title;
  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ImageViewer(
          apilink: "aboutUs",
        ));
  }
}
