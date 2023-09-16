Map mainMenuConfiguration(int index) {
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
          "apilink": "insertDataApi/invite",
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
          "action": "magazine-registration",
          "title": "Registration",
          "actionType": "formAction",
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
          ],
          "apilink": "insertDataApi/magazine_registration",
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
    9: {
      "action": "prayer",
      "title": "Prayer Request",
      "actionType": "formAction",
      "apilink": "insertDataApi/prayer",
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
          "name": "message",
          "label": "Message",
          "fieldType": "textarea",
          "isRequired": true
        },
      ]
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
    },
    10: {
      "action": "testimony",
      "title": "Testimony Submission",
      "actionType": "formAction",
      "apilink": "insertDataApi/testimony",
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
          "name": "testimony",
          "label": "Testimony",
          "fieldType": "textarea",
          "isRequired": true
        },
        {
          "name": "state",
          "label": "State",
          "fieldType": "text",
          "isRequired": true
        },
        {
          "name": "city",
          "label": "City",
          "fieldType": "text",
          "isRequired": true
        },
      ]
    },
    11: {
      "action": "pastors",
      "title": "Pastors Registration",
      "actionType": "formAction",
      "apilink": "insertDataApi/pastors",
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
          "fieldType": "textarea",
          "isRequired": true
        },
      ]
    },
    12: {
      "action": "bibleregistration",
      "title": "Bible Registration",
      "actionType": "formAction",
      "apilink": "insertDataApi/bible_registration",
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
          "fieldType": "textarea",
          "isRequired": true
        },
      ]
    },
    13: {
      "action": "reachus",
      "title": "Reach Us",
      "actionType": "formAction",
      "apilink": "insertDataApi/reach_us",
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
          "name": "message",
          "label": "Message",
          "fieldType": "textarea",
          "isRequired": true
        },
      ]
    },
  };
  if (menuList.containsKey(index)) {
    print(index);
    Map menuData = menuList[index];
    return menuData;
  }
  return {};
}