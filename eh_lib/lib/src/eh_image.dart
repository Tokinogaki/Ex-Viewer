import 'model/model.dart' as model;

class EhImage {
  final int page;
  final String iToken;
  final int gId;
  final String url;

  String thumb;
  String _cachedImage;

  EhImage(this.page, this.iToken, this.gId, this.url);

  Future<String> getFullImage() async {
    if (_cachedImage != null) return _cachedImage;

    return (_cachedImage = await model.getFullImage(gId, iToken, page));
  }

  @override
  String toString() => '$gId/$page: ${_cachedImage ?? thumb}';
}
