import 'package:eh_lib/eh_lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import '../util/util.dart' as util;
import 'package:ex_viewer/ui/widget/gallery_detail_hero.dart';
import 'image_viewer_page.dart';
import 'package:ex_viewer/ui/widget/tag_wrapper.dart';

class GalleryDetailPage extends StatefulWidget {
  final EhGallery gallery;

  GalleryDetailPage(this.gallery);

  @override
  State<StatefulWidget> createState() {
    return _GalleryDetailPageState();
  }
}

class _GalleryDetailPageState extends State<GalleryDetailPage> {
  List<Tag> _tags = [];

  @override
  void initState() {
    super.initState();

    widget.gallery.tags.forEach((t) {
      var tt = t.split(':');
      _tags.add(Tag(
          label: tt.length > 1 ? tt[1] : null,
          data: t,
          textColor: CupertinoColors.white,
          icon: util.tagCategoryToIconData(tt.length > 1 ? tt[0] : ''),
          backgroundColor: util.tagCategoryToColor(tt.length > 1 ? tt[0] : '')));
    });
  }

  void open(BuildContext context, final int index) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) {
          return GalleryPhotoViewWrapper(
            gallery: widget.gallery,
            initialIndex: index,
            backgroundDecoration: const BoxDecoration(
              color: CupertinoColors.black,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.extraLightBackgroundGray,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(CupertinoIcons.back),
          ),
          middle: Text('Gallery Detail'),
        ),
        child: SafeArea(
          child: Container(
            child: CustomScrollView(
              slivers: <Widget>[
                GalleryDetailHero(gallery: widget.gallery),
                SliverToBoxAdapter(
                  child: Container(
                    height: 60,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CupertinoButton(
                              child: const Text(
                                'Add to Favourite',
                                style: TextStyle(color: CupertinoColors.destructiveRed),
                              ),
                              onPressed: () => Navigator.pushReplacement(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => GalleryDetailPage(widget.gallery),
                                    ),
                                  ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CupertinoButton(
                              child: const Text(
                                'Read Now',
                              ),
                              onPressed: () => Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) {
                                        return GalleryPhotoViewWrapper(
                                          gallery: widget.gallery,
                                          initialIndex: 0,
                                          loadingChild: CupertinoActivityIndicator(),
                                          backgroundDecoration: const BoxDecoration(
                                            color: CupertinoColors.black,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 300),
                    child: TagWrapper(tags: _tags),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(height: 20, child: Text('text')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
