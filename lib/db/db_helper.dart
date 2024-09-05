import 'package:astrohub_user/models/app_user.dart';
import 'package:astrohub_user/models/brand.dart';
import 'package:astrohub_user/models/cart_model.dart';
import 'package:astrohub_user/models/order_model.dart';
import 'package:astrohub_user/models/rating_model.dart';
import 'package:astrohub_user/models/telescope.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbHelper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String collectionUser = 'Users';
  static const String collectionTelescope = 'Telescopes';
  static const String collectionBrand = 'Brands';
  static const String collectionCart = 'MyCartItems';
  static const String collectionOrder = 'Orders';
  static const String collectionRating = 'Ratings';

  static Future<void> addUser(AppUser appUser) {
    return _db
        .collection(collectionUser)
        .doc(appUser.uid)
        .set(appUser.toJson());
  }

  static Future<void> addToCart(CartModel cartModel, String uid) {
    return _db
        .collection(collectionUser)
        .doc(uid)
        .collection(collectionCart)
        .doc(cartModel.telescopeId)
        .set(cartModel.toJson());
  }

  static Future<void> removeFromCart(String telId, String uid) {
    return _db
        .collection(collectionUser)
        .doc(uid)
        .collection(collectionCart)
        .doc(telId)
        .delete();
  }

  static Future<bool> doesUserExist(String uid) async {
    final snapshot = await _db.collection(collectionUser).doc(uid).get();
    return snapshot.exists;
  }

  static Future<void> addBrand(Brand brand) {
    final doc = _db.collection(collectionBrand).doc();
    brand.id = doc.id;
    return doc.set(brand.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllBrands() =>
      _db.collection(collectionBrand).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllTelescopes() =>
      _db.collection(collectionTelescope).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllOrdersByUser(String uid) =>
      _db.collection(collectionOrder)
          .where('appUser.uid', isEqualTo: uid)
          .snapshots();

  static Future<QuerySnapshot<Map<String, dynamic>>> getAllRatings(String id) =>
      _db.collection(collectionTelescope).doc(id).collection(collectionRating).get();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCartItems(
          String uid) =>
      _db
          .collection(collectionUser)
          .doc(uid)
          .collection(collectionCart)
          .snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfo(
          String uid) =>
      _db.collection(collectionUser).doc(uid).snapshots();

  static Future<void> addTelescope(Telescope telescope) {
    final doc = _db.collection(collectionTelescope).doc();
    telescope.id = doc.id;
    return doc.set(telescope.toJson());
  }

  Future<void> updateTelescopeField(id, Map<String, dynamic> map) {
    return _db.collection(collectionTelescope).doc(id).update(map);
  }

  static Future<void> updateCartQuantity(String uid, CartModel model) {
    return _db
        .collection(collectionUser)
        .doc(uid)
        .collection(collectionCart)
        .doc(model.telescopeId)
        .set(model.toJson());
  }

  static Future<void> saveOrder(OrderModel order) async {
   final wb = _db.batch();
   final orderDoc = _db.collection(collectionOrder).doc(order.orderId);
   wb.set(orderDoc, order.toJson());
   for(final cartModel in order.itemDetails) {
     final telSnap = await _db.collection(collectionTelescope).doc(cartModel.telescopeId).get();
     final prevStock = telSnap.data()!['stock'];
     final telDoc = _db.collection(collectionTelescope).doc(cartModel.telescopeId);
     wb.update(telDoc, {'stock' : prevStock -  cartModel.quantity});
   }
   final userDoc = _db.collection(collectionUser).doc(order.appUser.uid);
   wb.set(userDoc, order.appUser.toJson());
   return wb.commit();
  }

  static Future<void> clearCart(String uid, List<CartModel> cartList) {
    final wb = _db.batch();
    for (final model in cartList) {
      final doc = _db
          .collection(collectionUser)
          .doc(uid)
          .collection(collectionCart)
          .doc(model.telescopeId);
      wb.delete(doc);
    }
    return wb.commit();
  }

  static Future<void>  addRating( String id , RatingModel ratingModel) {
return  _db.collection(collectionTelescope).doc(id).collection(collectionRating).doc(ratingModel.appUser.uid)
    .set(ratingModel.toJson());

  }
  static Future<void> updateUserProfile(String uid, Map<String, String> map) {
    return _db.collection(collectionUser)
        .doc(uid)
        .update(map);
  }
}
