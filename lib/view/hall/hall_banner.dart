import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:numerology/model/banner.dart';
import 'package:numerology/view/widgets/banner.dart';

class HallBanner extends StatefulWidget {
  HallBanner({Key key}) : super(key: key);

  @override
  _HallBannerState createState() => _HallBannerState();
}

class _HallBannerState extends State<HallBanner> {
  List<BannerWithEval> _bannerList = [];
  int _reload = 0;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 10; i++) {
      _bannerList.add(
        BannerEval(
            'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=792078633,360268424&fm=15&gp=0.jpg'),
      );
    }
    if (_bannerList.length > 0) _reload = _reload > 0 ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {
    return BannerWidget(
      data: _bannerList,
      reload: _reload,
      build: (bannerWithEval, position) => CachedNetworkImage(
        placeholder: (context, url) => Center(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: CircularProgressIndicator(),
        ),
        imageUrl: bannerWithEval.bannerUrl,
        fit: BoxFit.cover,
      ),
      onClick: (position, bannerWithEval) {
        print(position.toString());
      },
    );
  }
}
