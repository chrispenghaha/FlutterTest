import 'package:json_annotation/json_annotation.dart';
import 'BannerItemModel.dart';
import 'package:flutter_app/model/BaseModel.dart';

part 'BannerListModel.g.dart';

@JsonSerializable()
class BannerListModel extends BaseModel<List<BannerItemModel>> {
  BannerListModel(List<BannerItemModel> data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory BannerListModel.fromJson(Map<String, dynamic> json) =>
      _$BannerListModelFromJson(json);

  toJson() => _$BannerListModelToJson(this);
}
