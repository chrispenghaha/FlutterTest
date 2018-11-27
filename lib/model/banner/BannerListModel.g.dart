// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BannerListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerListModel _$BannerListModelFromJson(Map<String, dynamic> json) {
  return BannerListModel(
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : BannerItemModel.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['errorCode'] as int,
      json['errorMsg'] as String);
}

Map<String, dynamic> _$BannerListModelToJson(BannerListModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };
