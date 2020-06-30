import 'package:flutter/material.dart';
import 'dart:async';

abstract class BannerWithEval {
  get bannerUrl;
}

class BannerWidget extends StatefulWidget {
  final List<BannerWithEval> data;
  final int height, delayTime, duration;
  final Curve curve;
  final ItemBuild build;
  final IndicatorBuild indicator;
  final OnClick onClick;
  final int reload;

  BannerWidget({
    Key key,
    @required this.data,
    this.curve = Curves.linear,
    this.reload,
    this.indicator,
    this.build,
    this.onClick,
    this.height = 160,
    this.delayTime = 3500,
    this.duration = 1500,
  }) : super(key: key);

  createState() => BannerState();
}

class BannerState extends State<BannerWidget> {
  Timer timer;
  PageController controller;
  int position, currentPage;
  final List<BannerWithEval> _bannerList = [];
  bool isRoll = true;
  int reload;

  @override
  void initState() {
    super.initState();
    position = 0;
    currentPage = -1;
    controller = PageController(initialPage: getRealCount());
    reload = widget.reload;
    _restData();
    _restTime();
  }

  _restData() {
    if (getRealCount() == 0) return;
    if (_bannerList.length > 0) _bannerList.clear();
    int endPosition = getRealCount() - 1;
    _bannerList.add(widget.data[endPosition]);
    _bannerList.addAll(widget.data);
    _bannerList.add(widget.data[0]);
  }

  //setState(() => reload = _reload > 0 ? 0 : 1); 通过更换reload字段的值,达到更新数据目的

  @override
  Widget build(BuildContext context) {
    if (widget.reload != reload) {
      _restData();
      reload = widget.reload;
    }
    return Container(
        height: widget.height.toDouble(),
        color: Colors.grey,
        child: Stack(
          children: <Widget>[
            _pageView(),
            _indicator(),
          ],
        ));
  }

  Widget _pageView() => Listener(
        onPointerMove: (event) => isRoll = false,
        onPointerDown: (event) => isRoll = false,
        onPointerUp: (event) => isRoll = true,
        onPointerCancel: (event) => isRoll = true,
        child: NotificationListener(
          onNotification: (scrollNotification) {
            if (currentPage == -1) {
              isRoll = true;
            } else if (scrollNotification is ScrollEndNotification ||
                scrollNotification is UserScrollNotification) {
              if (currentPage == 0) {
                currentPage = getRealCount();
                controller.jumpToPage(currentPage);
              } else if (currentPage == getRealCount() + 1) {
                currentPage = 1;
                controller.jumpToPage(currentPage);
              }
              isRoll = true;
            } else {
              isRoll = false;
            }
          },
          child: PageView.custom(
            controller: controller,
            onPageChanged: (index) {
              currentPage = index;
              position = index % getRealCount();
              setState(() {});
            },
            physics: const BouncingScrollPhysics(),
            childrenDelegate: SliverChildBuilderDelegate(
              (context, index) {
                int current = index % getRealCount();
                BannerWithEval bannerWithEval = _bannerList[current];
                return GestureDetector(
                  onTap: () => widget.onClick(current, bannerWithEval),
                  child: widget.build(bannerWithEval, current),
                );
              },
              childCount: _bannerList.length,
            ),
          ),
        ),
      );

  Widget _indicator() => widget.indicator == null
      ? Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 20.0,
            padding: EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _circularPoint(getRealCount()),
            ),
          ))
      : widget.indicator(position, getRealCount());

  List<Widget> _circularPoint(int count) {
    List<Widget> children = [];
    for (var i = 0; i < count; i++) {
      children.add(Container(
        width: 10.0,
        height: 6.0,
        margin: EdgeInsets.only(left: 2.0, top: 0.0, right: 2.0, bottom: 0.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: position == i ? Colors.black38 : Colors.white,
        ),
      ));
    }
    return children;
  }

  _restTime() {
    if (timer == null) {
      timer = Timer.periodic(Duration(milliseconds: widget.delayTime), (timer) {
        if (isRoll) {
          if (currentPage == -1) {
            currentPage = 0;
            controller.jumpToPage(currentPage);
            return;
          }
          currentPage++;
          controller.nextPage(
              duration: Duration(milliseconds: widget.duration),
              curve: widget.curve);
        }
      });
    }
  }

  _cancelTime() {
    timer?.cancel();
    timer = null;
  }

  int getRealCount() => widget.data.length;

  @override
  void dispose() {
    _cancelTime();
    controller.dispose();
    controller = null;
    _bannerList.clear();
    super.dispose();
  }
}

typedef Widget ItemBuild(BannerWithEval bannerWithEval, int position);

typedef Widget IndicatorBuild(int position, int count);

typedef void OnClick(int position, BannerWithEval bannerWithEval);
