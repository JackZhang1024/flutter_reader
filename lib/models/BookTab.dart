import 'package:flutter_reader/pages/BookList.dart';

/** 定义TAB对象 针对每个tab 也给不同的对象   */

class BookTab {
  String text;
  BookList bookList;

  BookTab(this.text, this.bookList);
}
