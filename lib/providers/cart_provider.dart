import 'package:astrohub_user/models/cart_model.dart';
import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> cartList = [];

  bool isTelescopeInCart(String id) {
    bool tag = false;
    for (final cartModel in cartList) {
      if (cartModel.telescopeId == id) {
        tag = true;
        break;
      }
    }
    return tag;
  }
}
