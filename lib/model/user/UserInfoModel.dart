import 'package:json_annotation/json_annotation.dart';

part 'UserInfoModel.g.dart';

@JsonSerializable()
class UserInfoModel  {

  List<String> chapterTops;
  List<int> collectIds;
  String email;
  String icon;
  int id;
  String password;
  String token;
  int type;

  String username;

  UserInfoModel(this.chapterTops,this.collectIds,this.email,this.icon,this.id,this.password,this.token,this.type,this.username,);

  factory UserInfoModel.fromJson(Map<String, dynamic> srcJson) =>
      _$UserInfoModelFromJson(srcJson);

}