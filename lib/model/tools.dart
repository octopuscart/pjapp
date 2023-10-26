import 'package:flutter/material.dart';
import '../views/screens/commanview.dart';
import '../views/screens/form.dart';

import 'menuList.dart';

Map worshipSongs() {
  return {
    "Audio Songs": {"action": "audioSongs"},
    "Song Lyrics": {"action": "lyricsSongs"},
  };
}

void homeGridAction(int index, BuildContext context) {
  Map menuData = mainMenuConfiguration(index);
  print(menuData);
  if (menuData["type"] == "BottomSeet") {
    BottomSheetTemplate(
            context: context,
            title: menuData["title"],
            actionList: menuData["menu"],
            height: menuData["height"])
        .show();
  }
  if (menuData["type"] == "linkAction") {
    launchUrlExternalCall(menuData["action"]);
  }
  if (menuData["type"] == "paramAction") {
    streamViewCall(
      context: context,
      title: menuData["title"],
      apilink: menuData["apilink"],
      mappingobject: menuData["mapping"],
      viewType: menuData["viewType"],
    );
  }
  if (menuData["type"] == "formAction") {
    formActionCallRequest(context, menuData);
  }
}

void formActionCallRequest(BuildContext context, Map menuData) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DynamicFields(
        title: menuData["title"],
        apilink: menuData["apilink"],
        formFieldList: menuData["formData"],
      ),
    ),
  );
}
