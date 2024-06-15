import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_user.dart';

part 'rating_model.freezed.dart';
part 'rating_model.g.dart';

@unfreezed
class RatingModel with _$RatingModel{
  @JsonSerializable(explicitToJson: true)
  factory RatingModel({
    required AppUser appUser,
    required num rating ,
}) = _RatingModel;

  factory RatingModel.fromJson(Map<String , dynamic> json) => _$RatingModelFromJson(json);
}