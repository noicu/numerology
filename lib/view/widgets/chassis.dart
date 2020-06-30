import 'package:flutter/material.dart';
import 'package:numerology/view/style/theme.dart';

class Chassis extends StatelessWidget {
  final Widget leading;
  final Widget suffix;
  final Widget child;

  const Chassis({
    Key key,
    this.leading,
    this.suffix,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Themes.border), // 边色与边宽度
            color: Themes.backgroundH,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (leading != null) leading,
              Text(''),
              if (suffix != null) suffix,
            ],
          ),
        ),
        if (child != null)
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            color: Themes.backgroundB,
            child: child,
          )
      ],
    );
  }
}
