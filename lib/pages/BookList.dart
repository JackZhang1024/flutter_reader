import 'package:flutter/material.dart';
import 'package:flutter_reader/api/Api.dart';
import 'package:flutter_reader/api/NetUtils.dart';
import 'dart:io';
import 'dart:convert';

// 图书列表界面
class BookList extends StatefulWidget {
  final String bookType;

  BookList({Key key, this.bookType}) : super(key: key); // 书籍类型

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new BookListState(bookType);
  }
}

class BookListState extends State<BookList> with AutomaticKeepAliveClientMixin {
  List listData = new List();
  var curPage = 1;
  var pageSize = 20;
  var listTotalSize = 0;
  bool isRun = false;
  ScrollController controller = new ScrollController();

  // 书籍类型
  String bookType;

  BookListState(String bookType) {
    this.bookType = bookType;
    controller.addListener(() {
      var maxScroll = controller.position.maxScrollExtent;
      var pixels = controller.position.pixels;
      if (!isRun && pixels == maxScroll && (listData.length < listTotalSize)) {
        isRun = true;
        print('NEWS_LIST: load more ...$curPage');
        curPage++;
        getBookList(true);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 首次初始化
    if (listData.length > 0) {
    } else {
      getBookList(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (listData.length == 0) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return new RefreshIndicator(
          child: createGridView(context), onRefresh: pullToRefresh);
    }
  }

  void getBookList(bool isLoadMore) {
    String url = Api.BOOK_LIST;
    //url += '?q=$bookType&curPage=$curPage&pageSize=$pageSize';
    url += '&q=$bookType&page=$curPage&page_size=$pageSize';
    print('news_list: $url');
    NetUtils.get(url).then((data) {
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        if (map['code'] == 0) {
          isRun = true;
          List tempData = map['data'];
          setState(() {
            if (!isLoadMore) {
              listData.clear();
              listData = tempData;
            } else {
              listData.addAll(tempData);
              if (listData.length == listTotalSize) {}
            }
          });
        }
      }
    }, onError: (e) {
      print(e);
    });
  }

  // 下拉刷新数据
  Future<Null> pullToRefresh() async {
    print('NEWS_LIST: _pullToRefrsh');
    curPage = 1;
    getBookList(false);
    return null;
  }

  Widget createGridView(BuildContext context) {
    var lg = listData.length;
    return Container(
      padding: EdgeInsets.all(8.0),
      child: new GridView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          controller: controller,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1 / 2,
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0),
          itemCount: listData.length,
          itemBuilder: (context, i) {
            return bookRow(i);
          }),
    );
  }

  // 构建每一本书籍Item的Widget
  Widget bookRow(i) {
    var itemData = listData[i];
    return GestureDetector(
      onTap: () {},
      child: Container(
        child: Column(children: <Widget>[
          Expanded(
              child: Card(
                  elevation: 8.0,
                  child: AspectRatio(
                    aspectRatio: 3 / 4,
                    child: Hero(
                      tag: itemData['image'],
                      child: FadeInImage(
                          fit: BoxFit.fill,
                          placeholder:
                              AssetImage('assets/images/placeholder.png'),
                          image: NetworkImage(itemData['image'])),
                    ),
                  ))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              itemData['name'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.body2,
            ),
          )
        ]),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
