import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_reader/common/DbProvider.dart';
import 'package:flutter_reader/common/DialogUtils.dart';
import 'package:flutter_reader/pages/LoginPage.dart';


class MyInfoPage extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MyInfoState();
  }

}

class MyInfoState extends State<MyInfoPage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(child: Text('个人信息'));
  }
}