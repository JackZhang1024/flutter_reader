import 'package:flutter/material.dart';
import 'package:flutter_reader/common/ColorsUtil.dart';
import 'package:flutter_reader/common/DialogUtils.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SettingPageState();
  }
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('_SettingPageState...');
    return MaterialApp(
      theme: new ThemeData(
        primaryColor: Color(ColorsUtil.THEME_BLACK),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('设置', style: TextStyle(color: Colors.white, fontSize: 16),),
          leading: IconButton(
              icon: BackButtonIcon(),
              onPressed: (){
                Navigator.pop(context);
              }),
        ),
        body: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 50.0,
                margin: EdgeInsets.only(top: 40.0),
                child: RaisedButton(
                  onPressed: (){
                    DialogUtils.show(context, '提示', '这是送给程序员的爱心书单');
                  },
                  color: Color(ColorsUtil.THEME_BLACK),
                  child: Text('关于', style: TextStyle(color: Colors.white),),

                ),
              ),
              Container(
                height: 50.0,
                margin: EdgeInsets.only(top: 50.0),
                child: RaisedButton(
                    onPressed: (){
                      DialogUtils.show(context, '提示',  '版本 1.0');
                    },
                    color: Color(ColorsUtil.THEME_BLACK),
                    child: Text(
                      '版本号',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                ),
              ),
              Container(
                height: 50.0,
                margin: EdgeInsets.only(top: 40.0),
                child: RaisedButton(
                  onPressed: (){
                      DialogUtils.quit(context);
                  },
                  color: Color(ColorsUtil.THEME_BLACK),
                  child: Text(
                    '退出登录',
                     style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
