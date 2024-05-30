import 'package:astrohub_user/models/app_user.dart';
import 'package:astrohub_user/models/brand.dart';
import 'package:astrohub_user/models/cart_model.dart';
import 'package:astrohub_user/models/telescope.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbHelper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String collectionUser = 'Users';
  static const String collectionTelescope = 'Telescopes';
  static const String collectionBrand = 'Brands';
  static const String collectionCart = 'MyCartItems';

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

  static Future<void> addTelescope(Telescope telescope) {
    final doc = _db.collection(collectionTelescope).doc();
    telescope.id = doc.id;
    return doc.set(telescope.toJson());
  }

  Future<void> updateTelescopeField(id, Map<String, dynamic> map) {
    return _db.collection(collectionTelescope).doc(id).update(map);
  }
}
