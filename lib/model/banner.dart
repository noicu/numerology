import 'package:numerology/view/widgets/banner.dart';

class BannerEval extends Object with BannerWithEval {
  final String imgUrl;
  BannerEval(this.imgUrl);
  @override
  get bannerUrl => imgUrl;
}
