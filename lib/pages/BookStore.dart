import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_reader/api/Api.dart';
import 'package:flutter_reader/api/NetUtils.dart';
import 'package:flutter_reader/common/ColorsUtil.dart';
import 'package:flutter_reader/models/Constants.dart';
import 'package:flutter_reader/models/BookTab.dart';
import 'package:flutter_reader/pages/BookList.dart';


class BookStore extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return new BookStoreState();
  }

}


class BookStoreState extends State<BookStore> with TickerProviderStateMixin{

  TabController tabController;
  List<BookTab> myTabs = new List();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blue,
        title: new TabBar(
            labelColor: Colors.yellow,
            unselectedLabelColor: Colors.white,
            indicatorWeight: 2.0,
            controller: tabController,
            tabs: myTabs.map((item){
              return new Tab(text: item.text);
            }).toList(),
            // 使用Tab类型的数组呈现Tab标签
            indicatorColor: Colors.yellow,
            isScrollable: true,
        ),
      ),
      body: new TabBarView(
          controller: tabController,
          children: myTabs.map((item){
            return item.bookList;
          }).toList()
      ),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("BookStore initState ");
    tabController = new TabController( vsync: this, length: myTabs.length);
    print("getTabList+++++++++++++");
    getTabList();
    print("getTabListEnd++++++++");
    setState(() {

    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }

  // 网络异步请求获取Tab的数组信息
  void getTabList() async{
    String url = Api.BOOK_TAB;
    NetUtils.get(url).then((data){
        print("getTabList "+data);
        if (data!=null){
            Map<String, dynamic> map = json.decode(data);
            print("map $map");
            if (map['code']== 0){
                List _listData = map['data'];
                for  (int i =0; i< _listData.length; i++){
                     String str = _listData[i]['name'];
                     print("str $str");
                     myTabs.add(new BookTab(str,
                         new BookList(bookType: str)));
                }
            }
        }
        tabController = new TabController(vsync: this, length: myTabs.length);
        setState(() {});
    }, onError: (e){
         print(e);
    });


  }

}