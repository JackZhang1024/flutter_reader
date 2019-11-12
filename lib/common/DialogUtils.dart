import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DialogUtils{

  static show(BuildContext context, String title, String content){
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return new AlertDialog(
            title: new Text(title),
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  new Text(content)
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(onPressed: (){
                Navigator.of(context).pop();
              },
                  child: new Text('确定'))
            ],
          );
        }
    );
  }

  static quit(BuildContext context){
    showDialog<Null>(
       context: context,
       barrierDismissible: false,
       builder: (BuildContext context){
         return new AlertDialog(
           title: Text('退出'),
           content: new SingleChildScrollView(
             child: new ListBody(
               children: <Widget>[
                 new Text('是否确定退出'),
               ],
             ),
           ),
           actions: <Widget>[
             new FlatButton(
                 onPressed: () async{
                   // 获取实例
                   var prefes = await SharedPreferences.getInstance();
                   await prefes.setBool('isLogin', false);
                   Navigator.of(context).pop();
                 },
                 child: new Text('确定'),
             ),
             new FlatButton(
               onPressed: () async{
                 Navigator.of(context).pop();
               },
               child: new Text('取消'),
             ),
           ],
         );
       }
    );
  }

}
