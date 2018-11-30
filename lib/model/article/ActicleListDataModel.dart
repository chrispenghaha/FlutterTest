import 'package:flutter_app/model/article/ArticleItemModel.dart';

class ArticleListDataModel {
  int curpage;
  List<ArticleItemModel> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  ArticleListDataModel(this.curpage, this.datas, this.offset, this.over,
      this.pageCount, this.size, this.total);

  ArticleListDataModel.fromJson(Map<String, dynamic> json)
      : curpage = json['curpage'],
        datas = json['datas'],
        over = json['over'],
        pageCount = json['pageCount'],
        size = json['size'],
        total = json['total'],
        offset = json['offset'];
}
