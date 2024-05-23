import 'package:astrohub_user/db/db_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/app_user.dart';

class UserProvider extends ChangeNotifier {
  Future<void> addUser({required User user, String? name, String? phone}) {
    final appUser = AppUser(
      uid: user.uid,
      email: user.email!,
      userName: name,
      phone: phone,
      userCreationTime: Timestamp.fromDate(user.metadata.creationTime!),
    );
    return DbHelper.addUser(appUser);
  }
}
