
import 'package:json_annotation/json_annotation.dart';
part 'profile_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProfileEntity {
  final String? uid;
  final String? email;
  final String? name;
  final String? avatarUrl;

  ProfileEntity({
   this.uid,
   this.email,
   this.name,
   this.avatarUrl,
});
  factory ProfileEntity.fromJson(Map<String, dynamic> json) => _$ProfileEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileEntityToJson(this);



}