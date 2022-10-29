import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:pj_paul_ministries/model/apiController.dart';
import 'package:pj_paul_ministries/model/absModel.dart';

class UIWidget {
  Widget ImageCache(imagepath) {
    return CachedNetworkImage(
      imageUrl: imagepath,
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
      imageProvider: NetworkImage(imagepath),
    ));
  }
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
      var response =
          await apiobj.getDataFromServerList("listApiData/${widget.apilink}");
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
