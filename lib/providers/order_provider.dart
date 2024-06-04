import 'package:astrohub_user/db/db_helper.dart';
import 'package:flutter/material.dart';
import '../models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderModel> orderList = [];

 Future <void> saveOrder(OrderModel order) {

   return DbHelper.saveOrder(order);
 }
}