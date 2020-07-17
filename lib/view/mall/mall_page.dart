import 'package:flutter/material.dart';
import 'package:numerology/view/mall/mall_banner.dart';
import 'package:numerology/view/style/theme.dart';
import 'package:numerology/view/widgets/chassis.dart';
import 'package:numerology/view/widgets/search_app_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MallPage extends StatefulWidget {
  MallPage({Key key}) : super(key: key);

  @override
  _MallPageState createState() => _MallPageState();
}

class _MallPageState extends State<MallPage> {
  List item = [
    MallBanner(),
    Card(
      color: Themes.backgroundH,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text('asd'),
      ),
    ),
    Chassis(
      leading: Text(
        '转运好物',
        style: TextStyle(color: Themes.mainText),
      ),
    ),
    Card(
      color: Themes.backgroundH,
      child: Image.network('https://g-search3.alicdn.com/img/bao/uploaded/i4/i1/2200783101665/O1CN01WnvB621OAc32N48wn_!!0-item_pic.jpg_250x250.jpg'),
    ),
    Card(
      color: Themes.backgroundH,
      child: Image.network('https://g-search1.alicdn.com/img/bao/uploaded/i4/i2/682282233/O1CN01LJegzn1SMl1LsuRKH_!!0-item_pic.jpg_250x250.jpg'),
    ),
    Card(
      color: Themes.backgroundH,
      child: Image.network('https://g-search3.alicdn.com/img/bao/uploaded/i4/i1/281941722/O1CN01X90zZ81Oaib9MsWxG_!!0-item_pic.jpg_250x250.jpg'),
    ),
    Card(
      color: Themes.backgroundH,
      child: Image.network('https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/2211461433/O1CN01JEX0hC1MSMAhuGiQD_!!0-item_pic.jpg_250x250.jpg'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBarWidget(
        backgroundColor: Themes.backgroundH,
        color: Themes.mainText,
      ),
      backgroundColor: Themes.backgroundB,
      body: StaggeredGridView.countBuilder(
        physics: BouncingScrollPhysics(),
        crossAxisCount: 4,
        itemCount: item.length,
        itemBuilder: (BuildContext context, int index) => new Container(
          // color: Themes.backgroundH,
          child: item[index],
        ),
        staggeredTileBuilder: (int index) {
          switch (index) {
            case 0:
              return new StaggeredTile.count(4, 2);
            case 1:
              return new StaggeredTile.count(4, 1);
            case 2:
              return new StaggeredTile.count(4, 0.5);
            default:
              return new StaggeredTile.count(2, 2);
          }
        },
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
      // body: ListView(
      //   children: <Widget>[
      //     MallBanner()
      //   ],
      // ),
      floatingActionButton: Container(
        child: Image.asset('assets/tool_icon/g.png', width: 60, height: 60),
      ),
    );
  }
}
