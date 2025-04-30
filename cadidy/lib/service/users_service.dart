import 'package:cloud_firestore/cloud_firestore.dart';

class UsersService {
  static String? uid;

  static Future<void> saveUserData({
    required String uid,
    required String email,
    required String displayName,
  }) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'uid': uid,
      'email': email,
      'name': displayName,
      'lastname': '',
      'registryDate': DateTime.now(),
      'address': '',
      'profilePicture': '',
    });
  }
}