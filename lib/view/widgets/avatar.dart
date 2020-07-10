import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numerology/utils/string.dart';

// 用户头像
class Avatar extends StatelessWidget {
  Avatar(
    this.url, {
    Key key,
    this.size = 40.0,
    this.borderRadius,
    this.badge,
  })  : assert(size > 4.0),
        super(key: key);
  final double size;
  final String url;
  final BorderRadius borderRadius;
  final int badge;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Align(
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: CupertinoDynamicColor.resolve(
                    CupertinoColors.systemBackground, context),
                border: Border.all(
                  color: CupertinoDynamicColor.resolve(
                      CupertinoColors.quaternaryLabel, context),
                ),
                borderRadius: borderRadius ?? BorderRadius.circular(size / 2),
              ),
              child: ClipRRect(
                borderRadius: borderRadius ?? BorderRadius.circular(size / 2),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: "${UtilString.isHttpsUrl(url)}",
                  placeholder: (context, url) {
                    return Image.asset(
                      'assets/default/avatar.jpg',
                      width: size,
                      height: size,
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Image.asset(
                      'assets/default/avatar.jpg',
                      width: size,
                      height: size,
                    );
                  },
                ),
              ),
            ),
          ),
          if (badge != null && badge > 0)
            Positioned(
              left: size - 10,
              top: -5,
              child: Container(
                child: Container(
                  width: 24,
                  padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: CupertinoDynamicColor.resolve(
                        CupertinoColors.systemRed, context),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    '${badge > 99 ? '99+' : badge}',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
