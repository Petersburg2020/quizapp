import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({
    Key key,
    @required this.mobile,
    this.tablet,
    @required this.desktop,
  }) : super(key: key);

  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  bool isDesktop(BuildContext context) => _width(context) >= 1200;
  bool isTablet(BuildContext context) =>
      _width(context) >= 800 && _width(context) < 1200;
  bool isMobile(BuildContext context) => _width(context) < 800;
  double _width(BuildContext context) => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (context, constraint) {
      if (width >= 1200)
        return desktop;
      else if (width >= 800 && width < 1200)
        return tablet == null ? mobile : tablet;
      else
        return mobile;
    });
  }
}
