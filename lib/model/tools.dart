import 'package:flutter/material.dart';
import '../views/screens/commanview.dart';
import '../views/screens/form.dart';

Map worshipSongs() {
  return {
    "Audio Songs": {"action": "audioSongs"},
    "Song Lyrics": {"action": "lyricsSongs"},
  };
}

void homeGridAction(int index, BuildContext context) {
  Map menuList = {
    3: {
      "title": "Church Events & Updates",
      "menu": [
        {
          "action": "church-event",
          "title": "Church Events",
          "actionType": "paramAction",
          "apilink": "listApiData/churchEvent",
          "viewType": "blogView",
          "mapping": {
            "image": "image",
            "name": "title",
            "address": "description",
            "tableField": [
              {"key": "eventDate", "label": "Event Date"},
              {"key": "eventTime", "label": "Event Time"}
            ]
          }
        },
        {
          "action": "church-update",
          "title": "Church Updates",
          "actionType": "paramAction",
          "apilink": "listApiData/churchUpdate",
          "viewType": "blogView",
          "mapping": {
            "image": "image",
            "title": "title",
            "subtitle": "description",
            "tableField": []
          }
        },
      ],
      "height": 200.00,
      "type": "BottomSeet"
    },
    2: {
      "title": "Worship Songs",
      "menu": [
        {
          "action": "lyricsSongs",
          "title": "Audio Songs",
          "apilink": "listApiData/worshipSongsAlbum",
          "actionType": "paramAction",
          "viewType": "triGridView",
          "referenceLink": "albumData",
          "referenceType": "audio",
          "mapping": {
            "name": "title",
            "image": "image",
            "id": "referenceId",
          }
        },
        {
          "action": "lyricsSongs",
          "title": "Song Lyrics",
          "apilink": "listApiData/lyrics",
          "actionType": "paramAction",
          "viewType": "triGridView",
          "referenceLink": "lyricsData",
          "referenceType": "lyrics",
          "mapping": {
            "name": "title",
            "image": "image",
            "id": "referenceId",
          }
        },
      ],
      "height": 200.00,
      "type": "BottomSeet"
    },
    1: {
      "title": "Life Changing Videos",
      "menu": [
        {
          "action": "audioSongs",
          "apilink": "lifeChangeingVideos/HI",
          "actionType": "paramAction",
          "viewType": "youtubeView",
          "title": "Hindi",
          "mapping": {
            "name": "title",
            "url": "image",
          }
        },
        {
          "action": "lyricsSongs",
          "title": "Telugu",
          "viewType": "youtubeView",
          "apilink": "lifeChangeingVideos/TE",
          "actionType": "paramAction",
          "mapping": {
            "name": "title",
            "url": "image",
          }
        },
        {
          "action": "audioSongs",
          "title": "Malyalam",
          "viewType": "youtubeView",
          "apilink": "lifeChangeingVideos/ML",
          "actionType": "paramAction",
          "mapping": {
            "name": "title",
            "url": "image",
          }
        },
        {
          "action": "lyricsSongs",
          "title": "Tamil",
          "viewType": "youtubeView",
          "apilink": "lifeChangeingVideos/TA",
          "actionType": "paramAction",
          "mapping": {
            "name": "title",
            "url": "image",
          }
        },
        {
          "action": "lyricsSongs",
          "title": "Others",
          "viewType": "youtubeView",
          "apilink": "lifeChangeingVideos/Others",
          "actionType": "paramAction",
          "mapping": {
            "name": "title",
            "url": "image",
          }
        },
      ],
      "height": 350.00,
      "type": "BottomSeet"
    },
    6: {
      "title": "PJS Foundation",
      "menu": [
        {
          "action": "charity-images",
          "title": "Charity Works",
          "actionType": "nameAction",
        },
        {
          "action": "invite",
          "title": "Invite",
          "actionType": "formAction",
          "apilink": "insertDataApi/youngPartners",
          "formData": [
            {
              "name": "name",
              "label": "Name",
              "fieldType": "text",
              "isRequired": true
            },
            {
              "name": "mobile",
              "label": "Mobile / Phone No.",
              "fieldType": "mobile-no",
              "isRequired": true
            },
            {
              "name": "email",
              "label": "Email",
              "fieldType": "email",
              "isRequired": true
            },
            {
              "name": "address",
              "label": "Address",
              "fieldType": "text",
              "isRequired": true
            },
            {
              "name": "zipcode",
              "label": "Postal Code",
              "fieldType": "number",
              "isRequired": true
            },
            {
              "name": "state",
              "label": "State",
              "fieldType": "text",
              "isRequired": true
            },
          ]
        },
      ],
      "height": 200.00,
      "type": "BottomSeet"
    },
    7: {
      "title": "E-Magazine",
      "menu": [
        {
          "action": "prayer-request",
          "title": "Registration",
          "actionType": "formAction",
          "apilink": "insertData/amazoneBooks",
        },
        {
          "action": "amazonbook",
          "title": "Amazon Books",
          "apilink": "listApiData/amazoneBooks",
          "actionType": "paramAction",
          "viewType": "gridView",
          "mapping": {
            "name": "title",
            "image": "image",
            "url": "url",
          }
        },
      ],
      "height": 200.00,
      "type": "BottomSeet"
    },
    8: {
      "title": "Support Or Donate",
      "menu": [
        {
          "action": "donate",
          "actionType": "nameAction",
          "title": "Donate Images"
        },
        {
          "action": "https://www.pjspaul.org/donate-2/",
          "title": "Donate Now",
          "actionType": "linkAction",
        },
      ],
      "height": 200.00,
      "type": "BottomSeet"
    },
    0: {
      "type": "paramAction",
      "title": "Todays Blessings",
      "apilink": "listApiData/todaysBlessings",
      "viewType": "blogView",
      "mapping": {
        "image": "image",
        "title": "title",
        "description": "description",
        "tableField": [
          {"key": "eventDate", "label": "Event Date"},
          {"key": "eventTime", "label": "Event Time"}
        ]
      }
    },
    4: {
      "type": "formAction",
      "title": "Youg Partners Registration",
      "apilink": "insertDataApi/youngPartners",
      "formData": [
        {
          "name": "name",
          "label": "Name",
          "fieldType": "text",
          "isRequired": true
        },
        {
          "name": "mobile",
          "label": "Mobile No.",
          "fieldType": "mobile-no",
          "isRequired": true
        },
        {
          "name": "email",
          "label": "Email",
          "fieldType": "email",
          "isRequired": true
        },
        {
          "name": "whatsapp_number",
          "label": "WhatsApp No.",
          "fieldType": "mobile-no",
          "isRequired": true
        },
        {
          "name": "gender",
          "label": "Gender",
          "fieldType": "radio",
          "isRequired": true,
          "options": {
            "Male": "Male",
            "Female": "Female",
          }
        },
        {
          "name": "dob",
          "label": "Date Of Birth",
          "fieldType": "calenderDate",
          "isRequired": true
        },
      ]
    }
  };
  if (menuList.containsKey(index)) {
    Map menuData = menuList[index];
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
  }
}

Map formAction(String formid) {
  return {
    "prayer-request": {"name": "name", "label": "Name", "fieldType": "text"}
  };
}
