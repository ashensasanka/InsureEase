// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postdetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDetails _$PostDetailsFromJson(Map<String, dynamic> json) => PostDetails(
      id: json['id'] as String?,
      image: json['image'] as String?,
      achive_name: json['achive_name'] as String?,
      filetype: json['filetype'] as String?,
    );

Map<String, dynamic> _$PostDetailsToJson(PostDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'achive_name': instance.achive_name,
      'filetype': instance.filetype,
    };
