import 'package:flutter/material.dart';


// 图书列表界面
class BookList extends StatefulWidget {
  final String bookType;
  BookList({Key key, this.bookType}): super(key:key); // 书籍类型


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new BookListState(bookType);
  }
}

class BookListState extends State<BookList> with AutomaticKeepAliveClientMixin{

  List listData = new List();
  var curPage = 1;
  var pageSize = 20;
  var listTotalSize = 0;
  bool isRun = false;
  ScrollController mScrollController = new ScrollController();
  // 书籍类型
  String bookType;

  BookListState(String bookType){
    this.bookType = bookType;
//    mScrollController.addListener((){
//         var maxScroll = mScrollController.position.maxScrollExtent;
//         var pixels = mScrollController.position.pixels;
//         if (!isRun && pixels==maxScroll && (listData.length< listTotalSize)){
//             isRun = true;
//             print('NEWS_LIST: load more ...$curPage');
//             curPage++;
//
//         }
//    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(child: Text('bookList'));
  }

  @override
  bool get wantKeepAlive {
     return true;
  }


}
