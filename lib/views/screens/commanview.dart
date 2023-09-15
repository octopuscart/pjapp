import 'package:flutter/material.dart';
import 'package:pj_paul_ministries/views/ui/uiwidget.dart';
import 'package:pj_paul_ministries/model/absModel.dart';
import 'dart:async';
import 'package:pj_paul_ministries/model/apiController.dart';
import '../screens/form.dart';

// Our churches
class GallaryView extends StatefulWidget {
  const GallaryView({super.key, required this.title, required this.apilink});
  final String title;
  final String apilink;
  @override
  State<GallaryView> createState() => _GallaryViewState();
}

class _GallaryViewState extends State<GallaryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ImageViewer(
          apilink: widget.apilink,
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

class BottomSheetTemplate {
  final String title;
  final BuildContext context;
  final List actionList;
  final double height;

  BottomSheetTemplate({
    required this.context,
    required this.title,
    required this.actionList,
    this.height = 200,
  });

  Future<dynamic> show() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  color: Colors.red,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        this.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ))
                    ],
                  )),
              Container(
                height: this.height,
                child: Column(
                  children: List.generate(actionList.length, (index) {
                    Map<String, dynamic> elementObj = actionList[index];

                    ActionModel actionObj = ActionModel.fromJson(elementObj);

                    return ListTile(
                      title: Text(actionObj.title),
                      onTap: () {
                        Navigator.pop(context);
                        if (actionObj.actionType == "nameAction") {
                          Navigator.pushNamed(context, actionObj.actionName);
                        }
                        if (actionObj.actionType == "linkAction") {
                          launchUrlExternal(actionObj.actionName);
                        }
                        if (actionObj.actionType == "paramAction") {
                          if (actionObj.mapping.isNotEmpty) {
                            Map reference = {
                              "referenceLink":
                                  elementObj.containsKey("referenceLink")
                                      ? elementObj["referenceLink"]
                                      : "",
                              "referenceType":
                                  elementObj.containsKey("referenceType")
                                      ? elementObj["referenceType"]
                                      : "",
                            };

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StreamView(
                                  title: actionObj.title,
                                  apilink: actionObj.apilink,
                                  mappingobject: actionObj.mapping,
                                  viewType: actionObj.viewType,
                                  reference: reference,
                                ),
                              ),
                            );
                          }
                        }
                        if (actionObj.actionType == "formAction") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DynamicFields(
                                title: actionObj.title,
                                apilink: actionObj.apilink,
                                formFieldList: elementObj["formData"],
                              ),
                            ),
                          );
                        }
                      },
                      trailing: Icon(Icons.arrow_forward),
                    );
                  }),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

Future streamViewCall({
  required BuildContext context,
  required String apilink,
  required String title,
  required Map mappingobject,
  required String viewType,
  String referenceType = "",
  String referenceLink = "",
}) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => StreamView(
        apilink: apilink,
        title: title,
        mappingobject: mappingobject,
        viewType: viewType,
        reference: {},
      ),
    ),
  );
}

Future<void> audioPlayerCall() async {}

Future<void> launchUrlExternalCall(String urllink) async {
  launchUrlExternal(urllink);
}
