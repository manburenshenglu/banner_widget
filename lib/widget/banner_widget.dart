import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

///author xiejianlong
///description
///date 2019/7/16 17:29
///modify
class BannerWidget extends StatefulWidget {
  final int duration = 1000;
  final double height = 80.0;

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class BannerItem {
  String imgPath;
  String description;

  BannerItem(this.imgPath, {this.description = ''});
}
