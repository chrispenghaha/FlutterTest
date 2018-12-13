import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_app/model/BaseModel.dart';
import 'package:flutter_app/model/user/UserInfoModel.dart';

part 'UserModel.g.dart';

@JsonSerializable()
class UserModel extends BaseModel<UserInfoModel>{
  UserModel(UserInfoModel data, int errorCode, String errorMsg) : super(data, errorCode, errorMsg);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  toJson() => _$UserModelToJson(this);
}