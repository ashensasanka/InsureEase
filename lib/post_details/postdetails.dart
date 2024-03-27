import 'package:json_annotation/json_annotation.dart';
part 'postdetails.g.dart';

@JsonSerializable()
class PostDetails {
  @JsonKey(name:"id")
  String? id;

  @JsonKey(name:"image")
  String? image;

  @JsonKey(name:"achive_name")
  String? achive_name;

  @JsonKey(name:"filetype")
  String? filetype;


  PostDetails({
    this.id,
    this.image,
    this.achive_name,
    this.filetype
  });

  factory PostDetails.fromJson(Map<String, dynamic> json) => _$PostDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$PostDetailsToJson(this);

}