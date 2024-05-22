import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_address.freezed.dart';
part 'user_address.g.dart';

@unfreezed
class UserAddress with _$UserAddress{
  factory UserAddress({
    required String streetAddress,
    required String city,
    required String postCode,

}) = _UserAddress;
  factory UserAddress.fromJson(Map<String , dynamic> json) =>
      _$UserAddressFromJson(json);
}