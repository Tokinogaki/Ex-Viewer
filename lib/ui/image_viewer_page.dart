import 'package:eh_lib/eh_lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_advanced_networkimage/zoomable.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper(
      {this.loadingChild,
      this.backgroundDecoration,
      this.minScale,
      this.maxScale,
      this.initialIndex,
      @required this.gallery})
      : pageController = PageController(initialPage: initialIndex);

  final Widget loadingChild;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final EhGallery gallery;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  int currentIndex;

  bool _locked = false;

  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Swiper(
              index: currentIndex,
              onIndexChanged: (index) => setState(() => currentIndex = index),
              physics: _locked ? NeverScrollableScrollPhysics() : null,
              itemBuilder: (context, index) {
                return FutureBuilder<String>(
                  future: widget.gallery.getImage(index).then((i) => i.getFullImage()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ZoomableWidget(
                        minScale: 0.5,
                        maxScale: 2.0,
                        panLimit: 1.0,
                        onZoomChanged: (zoom) => setState(() => _locked = zoom != 1.0),
                        child: TransitionToImage(
                          image: AdvancedNetworkImage(
                            snapshot.data,
                            timeoutDuration: Duration(seconds: 10),
                            useDiskCache: true,
                            cacheRule: CacheRule(maxAge: const Duration(days: 7)),
                          ),
                          loadingWidget: CupertinoActivityIndicator(),
                          duration: Duration(seconds: 0),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Container(
                          child: Text('${snapshot.error}', style: TextStyle(color: CupertinoColors.white)));
                    } else {
                      return CupertinoActivityIndicator();
                    }
                  },
                );
              },
              itemCount: widget.gallery.fileCount,
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 12.0, right: 20.0),
              child: Text(
                "${currentIndex + 1} / ${widget.gallery.fileCount}",
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w100,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 3.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
