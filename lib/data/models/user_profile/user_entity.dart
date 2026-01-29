import 'package:json_annotation/json_annotation.dart';
part 'user_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserEntity {
  final String? uid;
  final String? email;
  final String? name;
  final String? avatarUrl;
  final bool? isOnline;
  final DateTime? lastSeen;
  final String? fcmToken;
  final DateTime? createdAt;



  UserEntity({
    this.uid,
    this.email,
    this.name,
    this.avatarUrl,
    this.isOnline = true,
    this.lastSeen,
    this.fcmToken,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();


  factory UserEntity.fromJson(Map<String, dynamic> json) => _$ProfileEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileEntityToJson(this);



}