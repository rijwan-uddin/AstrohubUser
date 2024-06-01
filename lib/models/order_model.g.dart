// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderModelImpl _$$OrderModelImplFromJson(Map<String, dynamic> json) =>
    _$OrderModelImpl(
      orderId: json['orderId'] as String,
      appUser: AppUser.fromJson(json['appUser'] as Map<String, dynamic>),
      orderStatus: json['orderStatus'] as String,
      paymentMethod: json['paymentMethod'] as String,
      totalAmount: json['totalAmount'] as num,
      orderDate: _$JsonConverterFromJson<Timestamp, Timestamp>(
          json['orderDate'], const TimestampConverter().fromJson),
      itemDetails: (json['itemDetails'] as List<dynamic>)
          .map((e) => CartModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$OrderModelImplToJson(_$OrderModelImpl instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'appUser': instance.appUser.toJson(),
      'orderStatus': instance.orderStatus,
      'paymentMethod': instance.paymentMethod,
      'totalAmount': instance.totalAmount,
      'orderDate': _$JsonConverterToJson<Timestamp, Timestamp>(
          instance.orderDate, const TimestampConverter().toJson),
      'itemDetails': instance.itemDetails.map((e) => e.toJson()).toList(),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
