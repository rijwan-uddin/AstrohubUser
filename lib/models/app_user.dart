import 'package:astrohub_user/model_converters/timestamp_converter.dart';
import 'package:astrohub_user/models/user_address.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'app_user.freezed.dart';
part 'app_user.g.dart';

@unfreezed
class AppUser with _$AppUser{
  @JsonSerializable(explicitToJson: true)
  factory AppUser({
    required String uid,
    required String email,
    UserAddress ? userAddress,
    String ? userName,
    String? phone,
    @TimestampConverter() Timestamp? userCreationTime,

}) = _AppUser;
  factory AppUser.fromJson(Map<String, dynamic> json) =>
_$AppUserFromJson(json);
}