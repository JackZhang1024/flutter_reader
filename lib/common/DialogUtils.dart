import 'package:flutter/material.dart';

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

}
