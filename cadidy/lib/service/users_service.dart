import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsersService {
  static String? uid;
  static String? email;

  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  UsersService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : firestore = firestore ?? FirebaseFirestore.instance,
        auth = auth ?? FirebaseAuth.instance;

  Future<void> saveUserData({
    required String uid,
    required String email,
    required String displayName,
    required String lastName,
    required String address,
    required String profilePicture,
    required String phone,
    required String username,
  }) async {
    await firestore.collection('users').doc(uid).set({
      'uid': uid,
      'email': email,
      'name': displayName,
      'lastName': lastName,
      'registryDate': DateTime.now(),
      'adress': address,
      'profilePicture': profilePicture,
      'phone': phone,
      'username': username,
    });
  }

  Future<bool> doesUIDExist(String uid) async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get();
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error al buscar el UID: $e');
      return false;
    }
  }

  Future<void> updateUserField(String field, dynamic value) async {
    final uid = auth.currentUser?.uid;
    if (uid == null) return;
    try {
      await firestore.collection('users').doc(uid).update({
        field: value,
      });
    } catch (e) {
      print('Error updating user field: $e');
    }
  }
}
