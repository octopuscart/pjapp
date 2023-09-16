import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:pj_paul_ministries/model/apiController.dart';
import 'package:pj_paul_ministries/model/absModel.dart';
import 'package:pj_paul_ministries/views/audioPlayer/audioPlayer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:pj_paul_ministries/views/songLyrics/lyricsList.dart';

class UIWidget {
  Widget ImageCache(imagepath,
      {double height = 100.00, double width = 100.00}) {
    return CachedNetworkImage(
      imageUrl: imagepath,
      height: height,
      width: width,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
        ),
      ),
      placeholder: (context, url) =>
          Container(height: 20, width: 20, child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  Widget ImageUi(imagepath) {
    return Container(
        child: PhotoView(
      backgroundDecoration: BoxDecoration(color: Colors.white),
      imageProvider: NetworkImage(imagepath),
    ));
  }
}

String youtubeImage(String youtubeUrl) {
  return 'https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(youtubeUrl)}/0.jpg';
}

class ImageViewer extends StatefulWidget {
  const ImageViewer({required this.apilink});
  final String apilink;
  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  ApiController apiobj = ApiController();
  UIWidget uiobj = UIWidget();
  int _current = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  List imagelist = [];
  Future<List> fetchData() async {
    try {
      var response = await apiobj.getDataFromServerList("${widget.apilink}");
      setState(() {
        imagelist = response;
      });
    } catch (e) {
      print(e);
    }
    return [];
  }

  final double _directionwidth = 50.0;

  final ScrollController _controller = ScrollController();
  void _animateToIndex(int index) {
    _controller.animateTo(
      index * _directionwidth,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  PageController pageController = PageController(
    initialPage: 1,
  );
  void onPageChanged(int index) {
    setState(() {
      _current = index;
      _animateToIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
              color: Colors.white,
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  ImageModel imageobj = ImageModel.fromJson(imagelist[index]);
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(imageobj.imagePath),
                    initialScale: PhotoViewComputedScale.contained,
                    tightMode: false,
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 4.1,
                    heroAttributes:
                        PhotoViewHeroAttributes(tag: imagelist[index]["id"]),
                  );
                },
                itemCount: imagelist.length,
                loadingBuilder: (context, event) => Center(
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      value: event == null ? 0 : 1,
                    ),
                  ),
                ),
                backgroundDecoration: BoxDecoration(
                  color: Colors.white,
                ),
                pageController: pageController,
                onPageChanged: onPageChanged,
              )),
          Positioned(
            width: MediaQuery.of(context).size.width,
            height: 70,
            bottom: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: ListView.builder(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: imagelist.length,
                  itemBuilder: (BuildContext context, int index) {
                    ImageModel imageobj = ImageModel.fromJson(imagelist[index]);
                    return GestureDetector(
                      onTap: () => pageController.animateToPage(
                        index,
                        duration: Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                      ),
                      child: Container(
                        child: uiobj.ImageUi(imageobj.imagePath),
                        width: 50.0,
                        height: 50.0,
                        padding: EdgeInsets.all(3),
                        margin: EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 4.0,
                        ),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color.fromARGB(255, 0, 0, 0)),
                          color: _current == index
                              ? Color.fromARGB(255, 0, 0, 0)
                              : Colors.white54,
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    ));
  }
}

Future<void> launchUrlExternal(String urllink) async {
  final Uri _url = Uri.parse(urllink);
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

ListView blogViewBuilder(
    {required BuildContext context,
    required AsyncSnapshot snapshot,
    required Map mappingobject}) {
  UIWidget uiobj = UIWidget();
  return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        final Map blogObj = snapshot.data[index];

        Map mappedObject = {};

        blogObj.forEach((key, value) {
          if (mappingobject.containsKey(key)) {
            mappedObject[mappingobject[key]] = blogObj[key];
          }
        });
        if (mappingobject.containsKey("tableField")) {
          List tableContent = mappingobject["tableField"];
          List tableContentObj = [];
          tableContent.forEach((element) {
            if (blogObj.containsKey(element["key"])) {
              String elementVal = blogObj[element["key"]];
              Map elementObj = {"label": element["label"], "value": elementVal};
              tableContentObj.add(elementObj);
            }
          });
          mappedObject["tableField"] = tableContentObj;
        }

        return Card(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.white,
                        child: uiobj.ImageUi(mappedObject["image"]),
                        // width: 50.0,
                        height: 300.0,
                        padding: EdgeInsets.all(3),
                        margin: EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 4.0,
                        ),
                      ),
                      Text(
                        "${mappedObject["title"]}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Divider(),
                      Text(
                        "${mappedObject["description"]}",
                        style: const TextStyle(),
                      ),
                      Divider(),
                    ],
                  ),
                ),
                Column(
                  children: List.generate(mappedObject["tableField"].length,
                      (tbindex) {
                    Map colObj = mappedObject["tableField"][tbindex];
                    return Container(
                        child: ListTile(
                      title: Text(colObj["label"]),
                      subtitle: Text(colObj["value"]),
                    ));
                  }),
                )
              ],
            ),
          ),
        );
      });
}

returnSame(String value) => value;

GridView gridViewBuilder(
    {required BuildContext context,
    required AsyncSnapshot snapshot,
    required Map mappingobject,
    Function customeImageScript = returnSame}) {
  return GridView.builder(
      itemCount: snapshot.data.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        var itemObj = snapshot.data[index];
        Map mappedObject = {};

        itemObj.forEach((key, value) {
          if (mappingobject.containsKey(key)) {
            mappedObject[mappingobject[key]] = itemObj[key];
          }
        });

        return InkWell(
          onTap: () => launchUrlExternal(itemObj["url"]),
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Container(
                      width: 500,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              customeImageScript(mappedObject["image"])),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      mappedObject["title"],
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

GridView triGridViewBuilder(
    {required BuildContext context,
    required AsyncSnapshot snapshot,
    required String title,
    required Map mappingobject,
    required Map reference,
    Function customeImageScript = returnSame}) {
  UIWidget uiobj = UIWidget();
  return GridView.builder(
    itemCount: snapshot.data.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
    ),
    itemBuilder: (context, index) {
      var itemObj = snapshot.data[index];
      Map mappedObject = {};

      itemObj.forEach((key, value) {
        if (mappingobject.containsKey(key)) {
          mappedObject[mappingobject[key]] = itemObj[key];
        }
      });

      return Container(
        margin: EdgeInsets.all(5),
        child: MaterialButton(
          padding: EdgeInsets.all(2),
          // shadowColor: Colors.redAccent.withOpacity(0.3),
          elevation: 3,
          splashColor: Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Theme.of(context).cardColor,
          onPressed: () {
            print(reference);
            if (reference["referenceType"].isNotEmpty) {
              switch (reference["referenceType"]) {
                case "audio":
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AudioPlayerView(
                          title: title,
                          apilink:
                              "${reference["referenceLink"]}/${mappedObject['referenceId']}"),
                    ),
                  );
                  print("audio for connection");
                  break;
                case "lyrics":
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StreamView(
                        title: "${mappedObject["title"]}",
                        apilink:
                            "${reference["referenceLink"]}/${mappedObject['referenceId']}",
                        viewType: "listView",
                        reference: {},
                        mappingobject: {
                          "lyrics": "title",
                          "image": "image",
                        },
                      ),
                    ),
                  );
              }
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: new BorderRadius.circular(15.0),
                  child: uiobj.ImageCache(
                      customeImageScript("${mappedObject["image"]}"),
                      height: 80,
                      width: 100),
                ),
              ),
              Text(
                "${mappedObject["title"]}",
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      );
    },
  );
}

ListView listViewBuilder(
    {required BuildContext context,
    required AsyncSnapshot snapshot,
    required Map mappingobject}) {
  UIWidget uiobj = UIWidget();
  return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        final Map blogObj = snapshot.data[index];

        Map mappedObject = {};

        blogObj.forEach((key, value) {
          if (mappingobject.containsKey(key)) {
            mappedObject[mappingobject[key]] = blogObj[key];
          }
        });
        if (mappingobject.containsKey("tableField")) {
          List tableContent = mappingobject["tableField"];
          List tableContentObj = [];
          tableContent.forEach((element) {
            if (blogObj.containsKey(element["key"])) {
              String elementVal = blogObj[element["key"]];
              Map elementObj = {"label": element["label"], "value": elementVal};
              tableContentObj.add(elementObj);
            }
          });
          mappedObject["tableField"] = tableContentObj;
        }
        print(mappedObject);
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LyricsViewer(
                  lyrics: mappedObject["title"],
                ),
              ),
            );
          },
          leading: Container(
            color: Colors.white,
            child: uiobj.ImageUi(mappedObject["image"]),
            width: 50.0,
            height: 50.0,
            padding: EdgeInsets.all(3),
            margin: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 4.0,
            ),
          ),
          title: Container(
              height: 100,
              child: Text(
                softWrap: true,
                "${mappedObject["title"]}",
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )),
        );
      });
}

class StreamView extends StatefulWidget {
  const StreamView({
    required this.apilink,
    required this.title,
    required this.mappingobject,
    required this.viewType,
    required this.reference,
  });
  final String apilink;
  final String title;
  final String viewType;
  final Map mappingobject;
  final Map reference;

  @override
  State<StreamView> createState() => _StreamViewState();
}

class _StreamViewState extends State<StreamView> {
  @override
  void initState() {
    super.initState();
  }

  Stream<List> _fetchData() {
    late final StreamController<List> controller;
    controller = StreamController<List>(
      onListen: () async {
        ApiController apiobj = ApiController();
        var response = await apiobj.getDataFromServerList("${widget.apilink}");
        controller.add(response);
        await Future<void>.delayed(const Duration(seconds: 1));
        await controller.close();
      },
    );
    return controller.stream;
  }

  final double _directionwidth = 50.0;

  final ScrollController _controller = ScrollController();
  void _animateToIndex(int index) {
    _controller.animateTo(
      index * _directionwidth,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  PageController pageController = PageController(
    initialPage: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder(
        stream: _fetchData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data.length == 0) {
            return Center(child: Text("No Data Found"));
          }
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            //("Null for connection");
            case ConnectionState.waiting:
            //("Waiting for connection");
            case ConnectionState.active:
            //("Active Connection");
            case ConnectionState.done:
            //("Connection Done");
          }

          switch (widget.viewType) {
            case "blogView":
              return blogViewBuilder(
                  context: context,
                  snapshot: snapshot,
                  mappingobject: widget.mappingobject);
            case "youtubeView":
              //("youtubeView");
              return gridViewBuilder(
                  context: context,
                  snapshot: snapshot,
                  mappingobject: widget.mappingobject,
                  customeImageScript: youtubeImage);
            case "gridView":
              //("gridView");
              return gridViewBuilder(
                context: context,
                snapshot: snapshot,
                mappingobject: widget.mappingobject,
              );
            case "triGridView":
              //("triGridView");
              return triGridViewBuilder(
                context: context,
                title: widget.title,
                snapshot: snapshot,
                mappingobject: widget.mappingobject,
                reference: widget.reference,
              );
            case "listView":
              //("Active Connection");
              return listViewBuilder(
                context: context,
                snapshot: snapshot,
                mappingobject: widget.mappingobject,
              );

            case "imageLinkView":
            //("Active Connection");
          }
          return Center(child: Text("No Data Found"));
        },
      ),
    );
  }
}
