import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_reader/common/DialogUtils.dart';
import 'package:flutter_reader/api/Api.dart';
import 'package:flutter_reader/api/NetUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

//
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _LoginState();
  }
}

class _LoginState extends State<LoginPage> {
  // 所填账户信息字符串
  var _str_account = '';
  var _str_pass = '';
  TextEditingController accountController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      theme: ThemeData(primaryColor: Colors.black),
      home: Scaffold(
        appBar: AppBar(
          title: new Text('登录'),
          leading: IconButton(
              icon: BackButtonIcon(),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Container(
            margin: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
            child: new Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Text('您好', style: TextStyle(fontSize: 30)),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '欢迎来到登录页面',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  // 添加 controller, 监听TextField内容变化
                  child: TextField(
                    controller: accountController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: '请输入11位手机号码'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: TextField(
                    controller: passController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: '请输入6位密码'),
                  ),
                ),
                // 监听Text的点击事件
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    alignment: Alignment.topLeft,
                    child: Text(
                      '没有账号，注册一个吧～',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: MaterialButton(
                    onPressed: () {
                      _str_account = accountController.text;
                      _str_pass = passController.text;
                      // 登录逻辑处理
                      login(_str_account, _str_pass);
                    },
                    child: Image.asset('', width: 180.0, height: 50.0),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void login(String account, String pass) async {
    if (account.trim() == '') {
      DialogUtils.show(context, '提示', '账号不能为空');
      return;
    }
    if (pass.trim() == '') {
      DialogUtils.show(context, '提示', '密码不能为空');
      return;
    }
    String url = Api.LOGIN;
    var map = {'username': account, 'password': pass};
    NetUtils.post(url, params: map).then((data) {
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        if (map['code'] == 1000) {
          var msg = map['data'];
          DialogUtils.show(context, '提示', '登录成功');
        } else {
          DialogUtils.show(context, '提示', '登录失败');
        }
        setState(() {});
      }
    });
  }

  void localLogin(String account, String pass) async {
    if (account.trim() == '') {
      DialogUtils.show(context, '提示', '账号不能为空');
      return;
    }
    if (pass.trim() == '') {
      DialogUtils.show(context, '提示', '密码不能为空');
      return;
    }
    String url = Api.LOGIN;
    var map = {'username': account, 'password': pass};
    // 获取实力
    var prefs = await SharedPreferences.getInstance();
    // 获取存储数据
    var _account = prefs.getString('account') ?? '';
    var _pass = prefs.getString('pass') ?? '';
    if (_account == account && _pass == pass) {
       Navigator.of(context).pop();
    } else {
       DialogUtils.show(context, '提示', '登录失败');
    }
  }


}
