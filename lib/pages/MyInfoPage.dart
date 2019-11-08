import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_reader/common/DbProvider.dart';
import 'package:flutter_reader/common/DialogUtils.dart';
import 'package:flutter_reader/pages/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _MyInfoState();
  }
}

class _MyInfoState extends State<MyInfoPage> {
  String nick = '';
  String des = '点击登录查看更多信息';
  File imageHeader;
  bool isLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
        margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
        child: ListView(
          children: <Widget>[
            loginTop(),
            cardView(),
            Container(
              height: 10.0,
              color: const Color(0x559DA0A5),
            ),
            itemWant(),
            Container(
              height: 20.0,
              color: const Color(0x559DA0A5),
            ),
            Container(
              height: 20.0,
              color: const Color(0x559DA0A5),
            ),
            ItemFabulous(),
            Container(
              height: 50.0,
              color: const Color(0x559DA0A5),
            ),
            setting(),
            Container(
              height: 0.5,
              color: const Color(0x559A0A5),
            )
          ],
        ));
  }

  void getUserInfo() async {
    // 获取实例
    var prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool('isogin') ?? false;
    nick = prefs.getString('nick') ?? '';
    String _userPath = prefs.getString('userimage') ?? '';
    if (isLogin) {
      imageHeader = new File(_userPath);
    } else {
      des = '点击登录查看更多信息';
    }
    setState(() {});
  }

  Widget loginTop() {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 5.0),
            child: Text(
              nick,
              style: TextStyle(fontSize: 20.0),
            ),
            alignment: Alignment.center,
          ),
          Container(
              margin: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 5.0),
              child: (isLogin == false || imageHeader == null)
                  ? CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: new AssetImage('images/user.png'),
                      radius: 40.0,
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: new FileImage(imageHeader),
                      radius: 40.0,
                    ))
        ],
      ),
    );
  }

  Widget cardView() {
    return Container(
      margin: EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 0.0),
      child: Stack(
        children: <Widget>[
          Image.asset(
            'images/img_card.png',
            height: 150.0,
            width: 400.0,
          ),
          Container(
            height: 150.0,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 5.0),
                          child: Text(
                            '强力推荐',
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 5.0),
                          child: Text(
                            '最给力的书单就在这里',
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  margin: EdgeInsets.only(right: 20.0),
                  child: Text(
                    '立即领取',
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget itemWant() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(25.0),
            child: Image.asset(
              'images/icon_love.png',
              width: 20.0,
              height: 20.0,
            ),
          ),
          Expanded(
            child: Text(
              '我想要的书籍',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            child: Text(
              '0本',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget ItemFabulous() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(25.0),
            child: Image.asset(
              'images/icon_praise.png',
              width: 20.0,
              height: 20.0,
            ),
          ),
          Expanded(
            child: Text(
              '我点赞的书籍',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            child: Text(
              '0本',
              style: TextStyle(fontSize: 16.0),
            ),
          )
        ],
      ),
    );
  }

  Widget setting() {
    return Container(
      child: GestureDetector(
        onTap: () {
          print('setting onTap+++++');
        },
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20.0),
              child: Image.asset(
                'images/icon_setting.png',
                width: 20.0,
                height: 20.0,
              ),
            ),
            Expanded(
              child: Text('设置'),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: Image.asset(
                'images/icon_arrow_right.png',
                width: 20.0,
                height: 20.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
