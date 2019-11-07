import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_reader/common/ColorsUtil.dart';
import 'package:flutter_reader/common/DbProvider.dart';
import 'package:flutter_reader/pages/BookStore.dart';
import 'package:flutter_reader/pages/MyInfoPage.dart';
import 'package:flutter_reader/pages/DrawerPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MyAppState();
  }
}

// TickerProviderStateMixin 动画相关
class MyAppState extends State<MyApp> with TickerProviderStateMixin {
  // 设置需要展示的tab序列号
  int selectedIndex = 0;
  TabController controller;

  final tabTextStyleNormal =
      new TextStyle(color: Color(ColorsUtil.TYPEFACE_BLACK));
  final tabTextStyleSelected =
      new TextStyle(color: Color(ColorsUtil.THEME_BLACK));

  // image 数组
  var tabImages;
  var bodyStack;

  // appBar 的标题数组
  var appBarTitles = ['首页', '我的'];

  Image getTabImage(path) {
    return new Image.asset(path, width: 20.0, height: 20.0);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 2, vsync: this);
    controller.addListener(() {
      setState(() {
        selectedIndex = controller.index;
      });
    });
  }

  void initData() {
    DbProvider commentProvider = new DbProvider();
    // 当tabImages 为空的时候初始化tabImages
    if (tabImages == null) {
      tabImages = [
        [
          getTabImage('images/icon_home.png'),
          getTabImage('images/icon_home_default.png')
        ],
        [
          getTabImage('images/icon_my.png'),
          getTabImage('images/icon_my_default.png')
        ]
      ];
    }
    bodyStack = new IndexedStack(
      children: <Widget>[new BookStore(), new MyInfoPage()],
      index: selectedIndex,
    );
    print("main.dart initData  ");
  }

  TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == selectedIndex) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }

  Image getTabIcon(int curIndex) {
    if (curIndex == selectedIndex) {
      return tabImages[curIndex][0];
    }
    return tabImages[curIndex][1];
  }

  Text getTabTitle(int curIndex) {
    return new Text(
      appBarTitles[curIndex],
      style: getTabTextStyle(curIndex),
    );
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return new MaterialApp(
      theme: new ThemeData(primaryColor: Colors.black),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(
            appBarTitles[selectedIndex],
            style: new TextStyle(color: Colors.white),
          ),
          iconTheme: new IconThemeData(color: Colors.white),
        ),
        // body stack
        body: TabBarView(
          controller: controller,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[new BookStore(), new MyInfoPage()],
        ),
        bottomNavigationBar: new CupertinoTabBar(
            backgroundColor: const Color(0xFFEAE9E7),
            items: <BottomNavigationBarItem>[
              new BottomNavigationBarItem(icon: getTabIcon(0), title: getTabTitle(0)),
              new BottomNavigationBarItem(icon: getTabIcon(1), title: getTabTitle(1))
            ],
            // 当前选中的序列
            currentIndex: selectedIndex,
            onTap: (index){
              // 必须调用setState 方法, 否则界面不会更新
              setState(() {
                   controller.index = index;
                   selectedIndex = index;
              });
            },
        ),
        // 这里是这设置侧边栏的地方
        drawer: new DrawerPage()
      ),
    );
  }
}
