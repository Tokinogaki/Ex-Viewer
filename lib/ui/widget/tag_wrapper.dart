import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TagWrapper extends StatefulWidget {
  final List<Tag> tags;

  const TagWrapper({this.tags}) : super();

  @override
  _TagWrapperState createState() => _TagWrapperState();
}

class _TagWrapperState extends State<TagWrapper> {
  var _renderedTags = <Widget>[];

  @override
  void initState() {
    super.initState();

    widget.tags.forEach((t) => _renderedTags.add(t._render()));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        runSpacing: 5.0,
        spacing: 8.0,
        children: _renderedTags,
      ),
    );
  }
}

class Tag {
  IconData icon;
  String label;
  String data;
  Color backgroundColor;
  Color textColor;

  Tag(
      {this.icon,
      this.label,
      @required this.data,
      this.backgroundColor = CupertinoColors.darkBackgroundGray,
      this.textColor = CupertinoColors.white});

  Widget _render() {
    return Stack(
      children: <Widget>[
        Container(
          height: 22,
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          decoration: BoxDecoration(
            border: Border.all(color: backgroundColor),
            borderRadius: BorderRadius.circular(11),
            color: backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              label ?? data,
              style: TextStyle(fontSize: 12, color: Color(0xCCFFFFFF)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0, top: 1.0),
          child: Icon(
            icon,
            size: 17,
            color: Color(0xCCFFFFFF),
          ),
        )
      ],
    );
  }
}
