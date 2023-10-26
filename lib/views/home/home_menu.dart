import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pj_paul_ministries/model/apiController.dart';
import 'package:pj_paul_ministries/model/tools.dart';
import '../../model/menuList.dart';
import '../screens/form.dart';
import 'package:share_plus/share_plus.dart';

class HomeMenu extends StatefulWidget {
  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    List menulist = [
      {"menu": 1, "action": 0},
      {"menu": 2, "action": 1},
      {"menu": 3, "action": 2},
      {"menu": 4, "action": 3},
      {"menu": 6, "action": 5},
      // {"menu": 8, "action": 7},
      {"menu": 5, "action": 4},
      {"menu": 9, "action": 8}
    ];
    return Scaffold(
      body: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          print(index);
          Map menuindex = menulist[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
                padding: EdgeInsets.all(2),
                // shadowColor: Colors.redAccent.withOpacity(0.3),
                elevation: 10,
                splashColor: Colors.grey,
                child: ClipRRect(
                  borderRadius: new BorderRadius.circular(30.0),
                  child: Image.asset(
                    'assets/icons/menu${menuindex['menu']}.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: Theme.of(context).cardColor,
                onPressed: () {
                  // onTapped(index, context);
                  homeGridAction(menuindex['action'], context);
                }),
          );
        },
        itemCount: menulist.length,
      ),
    );
  }
}

class HomeDrwer {
  Drawer build(context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Image.asset('assets/sir.jpg'),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.church),
            title: Text('Our Churches'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, 'our-charches');
            },
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, 'tv-programs');
            },
            leading: Icon(Icons.tv),
            title: Text('T.V Programs'),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, 'bible-college');
            },
            leading: Icon(FontAwesomeIcons.bookBible),
            title: Text('Bible College Registration'),
          ),
          // ListTile(
          //   leading: Icon(FontAwesomeIcons.bookOpenReader),
          //   title: Text('Bible Registration'),
          //   onTap: () {
          //     Navigator.of(context).pop();
          //     Map menuDataPray = mainMenuConfiguration(12);
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => DynamicFields(
          //           title: menuDataPray["title"],
          //           apilink: menuDataPray["apilink"],
          //           formFieldList: menuDataPray["formData"],
          //         ),
          //       ),
          //     );
          //   },
          // ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, 'paster-leaders');
            },
            leading: Icon(FontAwesomeIcons.personMilitaryPointing),
            title: Text('Pastors & Leaders'),
          ),
          // ListTile(
          //   leading: Icon(FontAwesomeIcons.personCircleCheck),
          //   title: Text('Pastor Registration'),
          //   onTap: () {
          //     Navigator.of(context).pop();
          //     Map menuDataPray = mainMenuConfiguration(11);
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => DynamicFields(
          //           title: menuDataPray["title"],
          //           apilink: menuDataPray["apilink"],
          //           formFieldList: menuDataPray["formData"],
          //         ),
          //       ),
          //     );
          //   },
          // ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, 'books-literatures');
            },
            leading: Icon(FontAwesomeIcons.bookOpen),
            title: Text('Book & Literature'),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.facebookMessenger),
            title: Text('Testimony'),
            onTap: () {
              Navigator.of(context).pop();
              Map menuDataPray = mainMenuConfiguration(10);
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
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.locationArrow),
            onTap: () {
              Navigator.of(context).pop();
              Map menuDataReach = mainMenuConfiguration(13);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReachusPage(
                    menuData: menuDataReach,
                  ),
                ),
              );
              // formActionCallRequest(context, menuDataReach);
            },
            title: Text('Reach us'),
          ),
          // ListTile(
          //   leading: Icon(FontAwesomeIcons.share),
          //   onTap: () {
          //     Share.share(
          //         "PlayStore: https://play.google.com/store/apps/details?id=dr.legend.pj_paul_ministries&hl=en_US \n AppStore: https://apps.apple.com/us/app/evans-francis/id1492924453?ls=1",
          //         subject: 'Download P.J. Stephen Paul Ministries App');
          //   },
          //   title: Text('Share'),
          // ),
          ListTile(
            leading: Icon(FontAwesomeIcons.info),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, 'aboutus');
            },
            title: Text('About us'),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.circleInfo),
            onTap: () {
              Navigator.of(context).pop();
              ApiController apiobj = ApiController();
              apiobj.launchInBrowserExt("www.christianappdevelopers.com");
              // _launchURL(Constants.CREATED_BY);
            },
            title: Text('Created By'),
          ),
        ],
      ),
    );
  }
}

class ReachusPage extends StatefulWidget {
  const ReachusPage({
    super.key,
    required this.menuData,
  });
  final Map menuData;

  @override
  State<ReachusPage> createState() => _ReachusPageState();
}

class _ReachusPageState extends State<ReachusPage> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    List socialList = socialListConfig();
    return Scaffold(
      appBar: AppBar(
        title: Text("Reach Us"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "P J Stephen Paul Ministries",
              style: TextStyle(fontSize: 20),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.map),
              title: Text(
                "Plot No.21 , HAS Colony\nBeside State Bank of India\nKharkhana\nSecundrabad 500062",
              ),
            ),
            ListTile(
                leading: Icon(Icons.phone),
                title: Text(
                  "+91-7799902106",
                )),
            ListTile(
                leading: Icon(Icons.email),
                title: Text(
                  "pjspaulministry@gmail.com",
                )),
            Divider(),
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/map.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: null /* add child content here */,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      ApiController apiobj = ApiController();

                      apiobj.launchUrlExternal(
                          "https://maps.app.goo.gl/HU2z4cQycmySDXjD6");
                    },
                    child: Text("Get Direction"))
              ],
            ),
            Container(
              height: 450,
              child: DynamicFields(
                title: "",
                apilink: widget.menuData["apilink"],
                formFieldList: widget.menuData["formData"],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
