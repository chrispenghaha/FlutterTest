import 'package:flutter_app/model/article/ActicleListDataModel.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_app/model/BaseModel.dart';

part 'ArticleListModel.g.dart';

@JsonSerializable()
class ArticleListModel extends BaseModel<ArticleListDataModel> {
  ArticleListModel(ArticleListDataModel data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory ArticleListModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleListModelFromJson(json);
}