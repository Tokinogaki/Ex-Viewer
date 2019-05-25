import 'package:eh_lib/eh_lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

import '../../util/util.dart';

class GalleryDetailHero extends StatelessWidget {
  const GalleryDetailHero({
    Key key,
    @required this.gallery,
  }) : super(key: key);

  final EhGallery gallery;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: CupertinoColors.extraLightBackgroundGray,
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
                      width: 140.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
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
                            height: 156,
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              gallery.titleJpn ?? gallery.title,
                              textAlign: TextAlign.left,
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(EhCategory.category2Color(EhCategory.parse(gallery.category))),
                                    ),
                                    borderRadius: BorderRadius.circular(3.0),
                                  ),
                                  child: Text(
                                    '${gallery.category}'.toUpperCase(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(EhCategory.category2Color(EhCategory.parse(gallery.category))),
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
                                Text(
                                  '${gallery.fileCount} pages · ${toHumanFormat(gallery.postDate)}'.toUpperCase(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: CupertinoColors.inactiveGray,
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
          ],
        ),
      ),
    );
  }
}
