// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) {
  return UserInfoModel(
      (json['chapterTops'] as List)?.map((e) => e as String)?.toList(),
      (json['collectIds'] as List)?.map((e) => e as int)?.toList(),
      json['email'] as String,
      json['icon'] as String,
      json['id'] as int,
      json['password'] as String,
      json['token'] as String,
      json['type'] as int,
      json['username'] as String);
}

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'chapterTops': instance.chapterTops,
      'collectIds': instance.collectIds,
      'email': instance.email,
      'icon': instance.icon,
      'id': instance.id,
      'password': instance.password,
      'token': instance.token,
      'type': instance.type,
      'username': instance.username
    };
