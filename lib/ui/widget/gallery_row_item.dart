import 'package:eh_lib/eh_lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

import '../../util/util.dart';
import '../gallery_detail_page.dart';

class GalleryRowItem extends StatelessWidget {
  GalleryRowItem({
    @required this.gallery,
  });

  final EhGallery gallery;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => GalleryDetailPage(gallery),
            ),
          ),
      child: Column(
        children: <Widget>[
          SafeArea(
            top: false,
            bottom: false,
            minimum: const EdgeInsets.only(
              left: 10,
              top: 5,
              bottom: 5,
              right: 5,
            ),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 90.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AdvancedNetworkImage(
                          gallery.thumb,
                          header: EhSession().client.headers,
                          timeoutDuration: Duration(seconds: 5),
                          useDiskCache: true,
                          cacheRule: CacheRule(maxAge: const Duration(days: 7)),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 90,
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            gallery.titleJpn ?? gallery.title,
                            textAlign: TextAlign.left,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'by “${gallery.uploader}”'.toUpperCase(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: CupertinoColors.inactiveGray,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 24,
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(EhCategory.category2Color(EhCategory.parse(gallery.category))),
                                  ),
                                  borderRadius: BorderRadius.circular(3.0),
                                ),
                                child: Text(
                                  '${gallery.category}'.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(EhCategory.category2Color(EhCategory.parse(gallery.category))),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${gallery.fileCount} pages · ${toHumanFormat(gallery.postDate)}'.toUpperCase(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: CupertinoColors.inactiveGray,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 95,
              right: 10,
            ),
            child: Container(
              height: 1,
              color: CupertinoColors.lightBackgroundGray,
            ),
          ),
        ],
      ),
    );
  }
}
