import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pj_paul_ministries/model/menuList.dart';
import 'home_menu.dart';
import '../screens/form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CarouselController carouselController = CarouselController();
  int _current = 0;

  List imagelist = [
    Image.asset(
      'assets/banner1.jpg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/banner2.jpg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/banner3.jpg',
      fit: BoxFit.cover,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrwer().build(context),
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                Map menuDataPray = mainMenuConfiguration(9);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DynamicFields(
                      title: menuDataPray["title"],
                      apilink: menuDataPray["apilink"],
                      formFieldList: menuDataPray["formData"],
                    ),
                  ),
                );
              },
              icon: Icon(FontAwesomeIcons.handsPraying))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CarouselSlider(
                  carouselController: carouselController,
                  options: CarouselOptions(
                    autoPlay: true,
                    // enlargeCenterPage: true,
                    enlargeCenterPage: false,
                    // disableCenter: true,
                    height: 200.0,
                    // aspectRatio: 16 / 9,
                    viewportFraction: 1.2,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                  items: imagelist.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(color: Colors.amber),
                            child: i);
                      },
                    );
                  }).toList(),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.only(right: 20),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black38,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: imagelist.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () =>
                              carouselController.animateToPage(entry.key),
                          child: Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 4.0,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == entry.key
                                  ? Colors.red
                                  : Colors.white54,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: 400,
              child: HomeMenu(),
            ),
          ],
        ),
      ),
    );
  }
}
