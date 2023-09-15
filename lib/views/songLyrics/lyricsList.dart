import 'package:flutter/material.dart';

class LyricsViewer extends StatefulWidget {
  final String lyrics;

  const LyricsViewer({required this.lyrics});
  @override
  _LyricsViewerState createState() => _LyricsViewerState();
}

class _LyricsViewerState extends State<LyricsViewer> {
  double textSize = 14;
  double smallButtonElevation = 0;
  double mediumButtonElevation = 5;
  double largeButtonElevation = 5;
  @override
  Widget build(BuildContext context) {
    final ButtonStyle styleActive = ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        side: BorderSide(width: 2, color: Colors.red), //border width and color
        elevation: 3, //elevation of button
        shape: RoundedRectangleBorder(
            //to set border radius to button
            borderRadius: BorderRadius.circular(30)),
        padding:
            EdgeInsets.only(left: 10, right: 10) //content padding inside button
        );
    final ButtonStyle style = ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(width: 2, color: Colors.red), //border width and color
        elevation: 3, //elevation of button
        shape: RoundedRectangleBorder(
            //to set border radius to button
            borderRadius: BorderRadius.circular(30)),
        padding:
            EdgeInsets.only(left: 10, right: 10) //content padding inside button
        );

    return Scaffold(
      appBar: AppBar(
        title: Text("Song Lyrics"),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: smallButtonElevation == 0 ? styleActive : style,
                    onPressed: () {
                      setState(() {
                        smallButtonElevation = 0;
                        mediumButtonElevation = 5;
                        largeButtonElevation = 5;
                        textSize = 14;
                      });
                    },
                    child: Container(
                      child: Text(
                        "Small",
                        style: TextStyle(
                            color: smallButtonElevation == 0
                                ? Colors.white
                                : Colors.red),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: mediumButtonElevation == 0 ? styleActive : style,
                    onPressed: () {
                      setState(() {
                        smallButtonElevation = 5;
                        mediumButtonElevation = 0;
                        largeButtonElevation = 5;
                        textSize = 24;
                      });
                    },
                    child: Container(
                      child: Text(
                        "Medium",
                        style: TextStyle(
                            color: mediumButtonElevation == 0
                                ? Colors.white
                                : Colors.red),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: largeButtonElevation == 0 ? styleActive : style,
                    onPressed: () {
                      setState(() {
                        smallButtonElevation = 5;
                        mediumButtonElevation = 5;
                        largeButtonElevation = 0;
                        textSize = 30;
                      });
                    },
                    child: Container(
                      child: Text(
                        "Large",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: largeButtonElevation == 0
                                ? Colors.white
                                : Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    widget.lyrics,
                    style: TextStyle(
                      fontSize: textSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
