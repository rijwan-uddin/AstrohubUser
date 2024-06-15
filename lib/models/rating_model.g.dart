// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RatingModelImpl _$$RatingModelImplFromJson(Map<String, dynamic> json) =>
    _$RatingModelImpl(
      appUser: AppUser.fromJson(json['appUser'] as Map<String, dynamic>),
      rating: json['rating'] as num,
    );

Map<String, dynamic> _$$RatingModelImplToJson(_$RatingModelImpl instance) =>
    <String, dynamic>{
      'appUser': instance.appUser.toJson(),
      'rating': instance.rating,
    };
