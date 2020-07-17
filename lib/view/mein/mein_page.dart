import 'package:flutter/material.dart';
import 'package:numerology/view/style/theme.dart';
import 'package:numerology/view/widgets/avatar.dart';
import 'package:numerology/view/widgets/search_app_bar.dart';

class MeinPage extends StatefulWidget {
  MeinPage({Key key}) : super(key: key);

  @override
  _MeinPageState createState() => _MeinPageState();
}

class _MeinPageState extends State<MeinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.backgroundB,
      appBar: AppBar(
        backgroundColor: Themes.backgroundH,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Avatar('', size: 80),
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '立即登录',
                      style: TextStyle(color: Themes.mainText),
                    ),
                  ),
                  onTap: () {},
                ),
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '注册登录享有更多权限',
                      style: TextStyle(color: Themes.mainText),
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Card(
            color: Themes.backgroundH,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text('asd'),
            ),
          ),
        ],
      ),
    );
  }
}

/// ----------------------------------------------
// for (var i = 0; i < 20; i++) {
//   canvas.drawArc(
//     Rect.fromCenter(
//       center: Offset(
//         width / 2 - (width / 4 * cos(PI / 10 * i)),
//         height / 2 - (height / 4 * sin(PI / 10 * i)),
//       ),
//       width: 5,
//       height: 5,
//     ),
//     0, // 起始角度 0度
//     2 * PI, // 扇面 180度
//     true, // 居中
//     Paint()
//       ..color = Colors.black
//       ..style = PaintingStyle.fill,
//   );

//   canvas.drawArc(
//     Rect.fromCenter(
//       center: Offset(
//         width / 2 - (width / 4 * cos(PI / 10 * i)),
//         width / 2 - (height / 4 * sin(PI / 10 * i)),
//       ),
//       width: 5,
//       height: 5,
//     ),
//     0, // 起始角度 0度
//     2 * PI, // 扇�� 180度
//     true, // 居中
//     Paint()
//       ..color = Colors.black
//       ..style = PaintingStyle.fill,
//   );
// }

// 中心点
// canvas.drawArc(
//   Rect.fromCenter(
//     center: center,
//     width: 5,
//     height: 5,
//   ),
//   0, // 起始角度 0度
//   2 * PI, // 扇面 180度
//   true, // 居中
//   Paint()
//     ..color = Colors.black
//     ..style = PaintingStyle.fill,
// );

// canvas.drawArc(
//   Rect.fromCenter(
//     center: c1,
//     width: 5,
//     height: 5,
//   ),
//   0, // 起始角度 0度
//   2 * PI, // 扇面 180度
//   true, // 居中
//   Paint()
//     ..color = Colors.black
//     ..style = PaintingStyle.fill,
// );

// canvas.drawArc(
//   Rect.fromCenter(
//     center: c2,
//     width: 5,
//     height: 5,
//   ),
//   0, // 起始角度 0度
//   2 * PI, // 扇面 180度
//   true, // 居中
//   Paint()
//     ..color = Colors.black
//     ..style = PaintingStyle.fill,
// );
