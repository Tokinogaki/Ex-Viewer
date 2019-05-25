import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

String toHumanFormat(DateTime dt) => DateFormat('yyyy-MM-dd hh:mm').format(dt.toLocal());

Color tagCategoryToColor(String tagCategory) {
  switch (tagCategory.toLowerCase()) {
    case 'reclass':
      return Color(0xFF2D4739);
      break;
    case 'language':
      return Color(0xFF09814A);
      break;
    case 'parody':
      return Color(0xFF246A73);
      break;
    case 'character':
      return Color(0xFF49393B);
      break;
    case 'group':
      return Color(0xFF4A6670);
      break;
    case 'artist':
      return Color(0xFF8D5A97);
      break;
    case 'male':
      return Color(0xFF565254);
      break;
    case 'female':
      return Color(0xFF04395E);
      break;
    default:
      return Color(0xFF22333B);
      break;
  }
}

IconData tagCategoryToIconData(String tagCategory) {
  switch (tagCategory.toLowerCase()) {
    case 'reclass':
      return CupertinoIcons.tag;
      break;
    case 'language':
      return CupertinoIcons.location;
      break;
    case 'parody':
      return CupertinoIcons.book;
      break;
    case 'character':
      return CupertinoIcons.book;
      break;
    case 'group':
      return CupertinoIcons.group;
      break;
    case 'artist':
      return CupertinoIcons.group;
      break;
    case 'male':
      return CupertinoIcons.tag;
      break;
    case 'female':
      return CupertinoIcons.tag;
      break;
    default:
      return CupertinoIcons.info;
      break;
  }
}
