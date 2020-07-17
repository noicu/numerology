import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:numerology/model/banner.dart';
import 'package:numerology/view/widgets/banner.dart';

class MallBanner extends StatefulWidget {
  MallBanner({Key key}) : super(key: key);

  @override
  _MallBannerState createState() => _MallBannerState();
}

class _MallBannerState extends State<MallBanner> {
  List<BannerWithEval> _bannerList = [];
  int _reload = 0;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 10; i++) {
      _bannerList.add(
        BannerEval(
            'https://img.alicdn.com/imgextra/i4/19840516/O1CN01vJIgGx1FgMveXNdhb_!!0-saturn_solar.jpg_270x270.jpg'),
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
