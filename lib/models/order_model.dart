import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../model_converters/timestamp_converter.dart';
import 'app_user.dart';
import 'cart_model.dart';
part 'order_model.freezed.dart';
part 'order_model.g.dart';

@unfreezed
class OrderModel with _$OrderModel {
  @JsonSerializable(explicitToJson: true)
  factory OrderModel ({
    required String orderId,
    required AppUser appUser,
    required String orderStatus,
    required String paymentMethod,
    required num  totalAmount,
    @TimestampConverter() required Timestamp orderDate,
    required List<CartModel> itemDetails,
}) =_OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}