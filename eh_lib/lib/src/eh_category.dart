enum EhCategories {
  Misc,
  Doujinshi,
  Manga,
  ArtistCG,
  GameCG,
  ImageSet,
  Cosplay,
  AsianPorn,
  NonH,
  Western,
  AllCategory,
}

class EhCategory {
  EhCategory._();

  static int category2Color(EhCategories cat) {
    switch (cat) {
      case EhCategories.Misc:
        return 0xFF777777;
        break;
      case EhCategories.Doujinshi:
        return 0xFF9E2720;
        break;
      case EhCategories.Manga:
        return 0xFFDB6C24;
        break;
      case EhCategories.ArtistCG:
        return 0xFFD38F1D;
        break;
      case EhCategories.GameCG:
        return 0xFF6A936D;
        break;
      case EhCategories.ImageSet:
        return 0xFF325CA2;
        break;
      case EhCategories.Cosplay:
        return 0xFF6A32A2;
        break;
      case EhCategories.AsianPorn:
        return 0xFFA23282;
        break;
      case EhCategories.NonH:
        return 0xFF5FA9CF;
        break;
      case EhCategories.Western:
        return 0xFFAB9F60;
        break;
      case EhCategories.AllCategory:
        return 0xFF000000;
        break;
    }

    return 0xFF000000;
  }

  static int include(List<EhCategories> cat) {
    int result = _category2Int(EhCategories.AllCategory);
    cat.forEach((c) => result ^= _category2Int(c));

    return result;
  }

  static int exclude(List<EhCategories> cat) {
    int result = 0;
    cat.forEach((c) => result |= _category2Int(c));

    return result;
  }

  static EhCategories parse(String cat) {
    switch (cat.toLowerCase()) {
      case 'misc':
        return EhCategories.Misc;
        break;
      case 'doujinshi':
        return EhCategories.Doujinshi;
        break;
      case 'manga':
        return EhCategories.Manga;
        break;
      case 'artist cg':
        return EhCategories.ArtistCG;
        break;
      case 'game cg':
        return EhCategories.GameCG;
        break;
      case 'image set':
        return EhCategories.ImageSet;
        break;
      case 'cosplay':
        return EhCategories.Cosplay;
        break;
      case 'asian porn':
        return EhCategories.AsianPorn;
        break;
      case 'non-h':
        return EhCategories.NonH;
        break;
      case 'western':
        return EhCategories.Western;
        break;
    }

    return EhCategories.AllCategory;
  }

  static List<EhCategories> int2Exclude(int exclude) => _int2Categories(exclude);

  static int _category2Int(EhCategories cat) {
    switch (cat) {
      case EhCategories.Misc:
        return _MISC;
        break;
      case EhCategories.Doujinshi:
        return _DOUJINSHI;
        break;
      case EhCategories.Manga:
        return _MANGA;
        break;
      case EhCategories.ArtistCG:
        return _ARTIST_CG;
        break;
      case EhCategories.GameCG:
        return _GAME_CG;
        break;
      case EhCategories.ImageSet:
        return _IMAGE_SET;
        break;
      case EhCategories.Cosplay:
        return _COSPLAY;
        break;
      case EhCategories.AsianPorn:
        return _ASIAN_PORN;
        break;
      case EhCategories.NonH:
        return _NON_H;
        break;
      case EhCategories.Western:
        return _WESTERN;
        break;
      case EhCategories.AllCategory:
        return _ALL_CATEGORY;
        break;
    }

    return 0;
  }

  static List<EhCategories> _int2Categories(int exclude) {
    var result = List<EhCategories>();

    if (exclude & _MISC != 0) result.add(EhCategories.Misc);
    if (exclude & _DOUJINSHI != 0) result.add(EhCategories.Doujinshi);
    if (exclude & _MANGA != 0) result.add(EhCategories.Manga);
    if (exclude & _ARTIST_CG != 0) result.add(EhCategories.ArtistCG);
    if (exclude & _GAME_CG != 0) result.add(EhCategories.GameCG);
    if (exclude & _IMAGE_SET != 0) result.add(EhCategories.ImageSet);
    if (exclude & _COSPLAY != 0) result.add(EhCategories.Cosplay);
    if (exclude & _ASIAN_PORN != 0) result.add(EhCategories.AsianPorn);
    if (exclude & _NON_H != 0) result.add(EhCategories.NonH);
    if (exclude & _WESTERN != 0) result.add(EhCategories.Western);
    if (exclude & _ALL_CATEGORY != 0) result.add(EhCategories.AllCategory);

    return result;
  }

  static const _MISC = 0x001;
  static const _DOUJINSHI = 0x002;
  static const _MANGA = 0x004;
  static const _ARTIST_CG = 0x008;
  static const _GAME_CG = 0x010;
  static const _IMAGE_SET = 0x020;
  static const _COSPLAY = 0x040;
  static const _ASIAN_PORN = 0x080;
  static const _NON_H = 0x100;
  static const _WESTERN = 0x200;
  static const _ALL_CATEGORY = 0x3ff;
}
