import 'package:astrohub_user/auth/auth_service.dart';
import 'package:astrohub_user/db/db_helper.dart';
import 'package:astrohub_user/models/cart_model.dart';
import 'package:astrohub_user/models/telescope.dart';
import 'package:astrohub_user/utils/helper_functions.dart';
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
  Future<void> addToCart(Telescope telescope){
    final cartModel = CartModel(
        telescopeId: telescope.id!,
        telescopeModel: telescope.model,
        price: priceAfterDiscount(telescope.price, telescope.discount),
        imageUrl: telescope.thumbnail.downloadUrl,
    );
    return DbHelper.addToCart(cartModel, AuthService.currentUser!.uid);
  }
  Future<void> removeFromCart(String id){
    return DbHelper.removeFromCart(id, AuthService.currentUser!.uid);
  }
}
