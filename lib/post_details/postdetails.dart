import 'package:json_annotation/json_annotation.dart';
part 'postdetails.g.dart';

@JsonSerializable()
class PostDetails {

  @JsonKey(name:"image")
  String? imageUrl;

  @JsonKey(name:"filetype")
  String? filetype;


  PostDetails({
    this.imageUrl,
    this.filetype
  });

  factory PostDetails.fromJson(Map<String, dynamic> json) => _$PostDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$PostDetailsToJson(this);

}