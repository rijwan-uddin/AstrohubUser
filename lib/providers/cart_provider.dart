import 'package:astrohub_user/auth/auth_service.dart';
import 'package:astrohub_user/db/db_helper.dart';
import 'package:astrohub_user/models/cart_model.dart';
import 'package:astrohub_user/models/telescope.dart';
import 'package:astrohub_user/utils/helper_functions.dart';
import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> cartList = [];

 int get totalItemsInCart => cartList.length;

  getAllCartItems() {
    DbHelper.getAllCartItems( AuthService.currentUser!.uid).listen((snapshot) {
      cartList = List.generate(snapshot.docs.length,
              (index) => CartModel.fromJson(snapshot.docs[index].data()));
      notifyListeners();
    });
  }


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
  void  increaseQuantity(CartModel model) {
    model.quantity += 1;
    DbHelper.updateCartQuantity(AuthService.currentUser!.uid,model);
  }
  void  decreaseQuantity(CartModel model) {
    if(model.quantity > 1){
      model.quantity -= 1;
      DbHelper.updateCartQuantity(AuthService.currentUser!.uid,model);
    }

  }
  num priceWithQuantity(CartModel model) => model.price * model.quantity;

  num getCartSubTotal(){
    num total = 0;
    for (final model in cartList){
      total += priceWithQuantity(model);
    }
    return total;
  }
Future<void> clearCart() => DbHelper.clearCart(AuthService.currentUser!.uid,
cartList);
}
