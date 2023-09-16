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
    return Scaffold(
      body: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
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
                    'assets/icons/menu${index + 1}.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: Theme.of(context).cardColor,
                onPressed: () {
                  // onTapped(index, context);
                  homeGridAction(index, context);
                }),
          );
        },
        itemCount: 9,
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
            title: Text('Bible College'),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.bookOpenReader),
            title: Text('Bible Registration'),
            onTap: () {
              Navigator.of(context).pop();
              Map menuDataPray = mainMenuConfiguration(12);
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
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, 'paster-leaders');
            },
            leading: Icon(FontAwesomeIcons.personMilitaryPointing),
            title: Text('Pastors & Leaders'),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.personCircleCheck),
            title: Text('Pastor Registration'),
            onTap: () {
              Navigator.of(context).pop();
              Map menuDataPray = mainMenuConfiguration(11);
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
              formActionCallRequest(context, menuDataReach);
            },
            title: Text('Reach us'),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.share),
            onTap: () {
              Share.share(
                  "PlayStore: https://play.google.com/store/apps/details?id=dr.legend.pj_paul_ministries&hl=en_US \n AppStore: https://apps.apple.com/us/app/evans-francis/id1492924453?ls=1",
                  subject: 'Download P.J. Stephen Paul Ministries App');
            },
            title: Text('Share'),
          ),
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
