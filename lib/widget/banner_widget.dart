import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

const MAX_COUNT = 0x7fffffff;
enum InfoDirect { HORIZONTAL, VERTICAL }
enum IndicatorStyle {
  ///circle indicator
  CIRCLE,

  ///elliptical indicator
  ELLIPTICAL
}

///banner click callback
typedef void OnBannerItemClick(int position, BannerItem bannerItem);

typedef Widget CustomBuild(int position, BannerItem item);

///author xjl
///description
///date 2019/7/16 17:29
///modify
class BannerWidget extends StatefulWidget {
  final int duration;
  final double height;
  final List<BannerItem> data;
  final Color selectedColor;
  final Color unSelectedColor;
  final double circleRadius;

  ///elliptical indicator width
  final double ellipticalWidth;

  ///elliptical indicator height
  final double ellipticalHeight;

  ///elliptical indicator cornerRadius
  final double cornerRadius;
  final IndicatorStyle indicatorStyle;

  ///text background color
  final Color textBackgroundColor;
  final OnBannerItemClick onBannerItemClick;
  final CustomBuild build;

  final InfoDirect textInfoDirect;

  BannerWidget(this.data,
      {this.duration: 2000,
      this.height: 200.0,
      this.selectedColor: Colors.red,
      this.unSelectedColor: Colors.white,
      this.onBannerItemClick,
      this.build,
      this.textBackgroundColor: const Color(0x33000000),
      this.textInfoDirect: InfoDirect.HORIZONTAL,
      this.circleRadius: 5.0,
      this.indicatorStyle: IndicatorStyle.CIRCLE,
      this.ellipticalWidth: 16.0,
      this.ellipticalHeight: 8.0,
      this.cornerRadius: 10.0})
      : assert(data != null);

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  Timer _timer;

  PageController _pageController;

  ///current selected banner index
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    double current = widget.data.length > 0
        ? (MAX_COUNT / 2) - ((MAX_COUNT / 2) % widget.data.length)
        : 0.0;
    _pageController = PageController(initialPage: current.toInt());
    start();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: widget.height,
      color: Colors.black12,
      child: Stack(
        children: <Widget>[
          getPageView(),
          Align(
            alignment: Alignment.bottomCenter,
            child: IntrinsicHeight(
              child: Container(
                padding: EdgeInsets.all(5.0),
                color: widget.textBackgroundColor,
                child: getBannerTextInfoWidget(),
              ),
            ),
          )
        ],
      ),
    );
  }

  void onPageChanged(index) {
    selectedIndex = index % widget.data.length;
    setState(() {});
  }

  ///return banners
  Widget getPageView() {
    return PageView.builder(
        itemCount: widget.data.length > 0 ? MAX_COUNT : 0,
        controller: _pageController,
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                if (widget.onBannerItemClick != null) {
                  widget.onBannerItemClick(
                      selectedIndex, widget.data[selectedIndex]);
                }
              },
              child: widget.build == null
                  ? FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: widget.data[index % widget.data.length].imgPath,
                      fit: BoxFit.cover)
                  : widget.build(
                      index, widget.data[index % widget.data.length]));
        });
  }

  Widget getBannerTextInfoWidget() {
    if (widget.textInfoDirect == InfoDirect.VERTICAL) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            getCurrentTextInfoWidget(),
            IntrinsicWidth(child: Row(children: indicator()))
          ]);
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(flex: 1, child: getCurrentTextInfoWidget()),
          Expanded(
              flex: 0,
              child: Row(
                  mainAxisSize: MainAxisSize.min, children: indicator()))
        ],
      );
    }
  }

  List<Widget> indicator() {
    List<Widget> indicator = [];
    for (int i = 0; i < widget.data.length; i++) {
      indicator.add(
        Container(
            margin: EdgeInsets.all(3.0),
            width: widget.indicatorStyle == IndicatorStyle.CIRCLE
                ? widget.circleRadius
                : widget.ellipticalWidth,
            height: widget.indicatorStyle == IndicatorStyle.CIRCLE
                ? widget.circleRadius
                : widget.ellipticalHeight,
            decoration: BoxDecoration(
                borderRadius: widget.indicatorStyle == IndicatorStyle.CIRCLE
                    ? null
                    : BorderRadius.all(Radius.elliptical(
                        widget.cornerRadius, widget.cornerRadius)),
                shape: widget.indicatorStyle == IndicatorStyle.CIRCLE
                    ? BoxShape.circle
                    : BoxShape.rectangle,
                color: i == selectedIndex
                    ? widget.selectedColor
                    : widget.unSelectedColor)),
      );
    }
    return indicator;
  }

  Widget getCurrentTextInfoWidget() {
    return widget.data.length > 0 && selectedIndex < widget.data.length
        ? widget.data[selectedIndex].textInfoWidget
        : Text('$selectedIndex');
  }

  @override
  void didUpdateWidget(BannerWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  void start() {
    stop();
    _timer = Timer.periodic(Duration(milliseconds: widget.duration), (timer) {
      if (widget.data.length > 0 &&
          _pageController != null &&
          _pageController.page != null) {
        _pageController.animateToPage(_pageController.page.toInt() + 1,
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    stop();
    super.dispose();
  }
}

class BannerItem {
  String imgPath;
  Widget textInfoWidget;

  static BannerItem defaultBannerItem(String image, String text,
      [maxLines = 1,
      style = const TextStyle(
          color: Colors.white,
          fontSize: 12.0,
          decoration: TextDecoration.none)]) {
    BannerItem item = new BannerItem();
    item.imgPath = image;
    Text textWidget = new Text(
      text,
      softWrap: true,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: style,
    );

    item.textInfoWidget = textWidget;

    return item;
  }
}
