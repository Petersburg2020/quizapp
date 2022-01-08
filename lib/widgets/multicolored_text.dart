import 'package:flutter/material.dart';

class MultiColoredText extends StatelessWidget {
  MultiColoredText({
    Key key,
    @required this.text,
    @required this.width,
    this.radius = 0.0,
    this.fontSize = 18.0,
    this.color = Colors.white,
    this.subTexts = const [],
    this.onTap,
    this.padding = const EdgeInsets.all(0.0),
    this.backgroundColor = Colors.transparent,
    this.fontWeight = FontWeight.w600,
    this.alignment = TextAlignment.start,
    this.borderWidth=0.0,
    this.borderColor=Colors.transparent,
    this.borderStyle=BorderStyle.solid,
  }) : super(key: key);

  final double width;
  final double radius;
  final double fontSize;
  final String text;
  final Color color;
  final Color backgroundColor;
  final List<TextColor> subTexts;
  final FontWeight fontWeight;
  final Function onTap;

  final double borderWidth;
  final Color borderColor;
  final BorderStyle borderStyle;

  final TextAlignment alignment;
  final EdgeInsetsGeometry padding;

  List<TextColor> _addAllLeftOvers(List<TextColor> subs) {
    List<TextColor> values = [];
    if (subs.isNotEmpty)
      values = _addFromZero(subs);
    else
      values.add(TextColor(text, text,
          color: color, fontSize: fontSize, backgroundColor: backgroundColor));
    return values;
  }

  List<TextColor> _addFromZero(List<TextColor> subs) {
    List<TextColor> values = [];
    int lastIndex = -1;
    subs.forEach((sub) {
      if (sub.index - lastIndex > 1) {
        String dSub = text.substring(lastIndex + 1, sub.index);
        values.add(
          TextColor(
            text,
            dSub,
            onTap: onTap,
            index: lastIndex + 1,
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            backgroundColor: backgroundColor,
          ),
        );
      }
      values.add(sub);
      lastIndex = sub.endIndex;
    });
    return values;
  }

  List<TextColor> _removeInvalidSubs(List<TextColor> subs) {
    List<TextColor> values = [];
    if (subs.isNotEmpty)
      subs.forEach((sub) => sub.contains ? values.add(sub) : null);
    //for (TextColor sub in subs) if (sub.contains) values.add(sub);
    return values;
  }

  List<Widget> _toWidget(List<TextColor> subs) {
    List<Widget> widgets = [];
    subs.forEach((sub) => widgets.add(GestureDetector(
          onTap: () => sub.onTap != null ? sub.onTap(this, sub) : {},
          child: Text(
            sub.subText,
            style: TextStyle(
              color: sub.color,
              backgroundColor: sub.backgroundColor,
              fontSize: sub.fontSize,
              fontWeight: sub.fontWeight,
            ),
            maxLines: 1,
          ),
        )));
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    MainAxisAlignment main = MainAxisAlignment.start;
    switch (alignment) {
      case TextAlignment.start:
        main = MainAxisAlignment.start;
        break;
      case TextAlignment.center:
        main = MainAxisAlignment.center;
        break;
      case TextAlignment.end:
        main = MainAxisAlignment.end;
        break;
    }
    List<Widget> texts = [];
    List<TextColor> subs = [];
    if (subTexts.isNotEmpty) {
      subTexts.sort((a, b) => a.index.compareTo(b.index));
      subs = _removeInvalidSubs(subTexts);
    }
    subs = _addAllLeftOvers(subs);
    texts = _toWidget(subs);

    return GestureDetector(
      onTap: onTap != null ? onTap : () {},
      child: Container(
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            width: borderWidth,
            color: borderColor,
            style: borderStyle,
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Row(
          mainAxisAlignment: main,
          children: texts,
        ),
      ),
    );
  }
}

enum TextAlignment { start, center, end }

class TextColor {
  final String text;
  final String subText;
  int index;
  int endIndex;
  bool contains;
  final Color color;
  final Color backgroundColor;
  final double fontSize;
  final FontWeight fontWeight;
  final void Function(MultiColoredText widget, TextColor text) onTap;

  TextColor(
    this.text,
    this.subText, {
    this.index = -1,
    this.endIndex = -1,
    this.color = Colors.grey,
    this.backgroundColor = Colors.transparent,
    this.fontSize = 18.0,
    this.onTap,
    this.fontWeight = FontWeight.w600,
  }) {
    if (index == -1) index = text.indexOf(subText);
    if (index > -1) endIndex = index + subText.length;
    contains = text.contains(subText);
  }
}
