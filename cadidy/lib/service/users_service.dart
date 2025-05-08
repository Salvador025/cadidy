import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsersService {
  static String? uid;
  static String? email; // Nueva variable para guardar el correo electrónico

  static Future<void> saveUserData({
    required String uid,
    required String email,
    required String displayName,
    required String lastName,
    required String address,
    required String profilePicture,
    required String phone,
    required String username,
  }) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
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

  static Future<bool> doesUIDExist(String uid) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get();

      // Si hay documentos en el snapshot, el UID existe
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      // Manejo de errores (opcional)
      print('Error al buscar el UID: $e');
      return false;
    }
  }

  static Future<void> updateUserField(String field, dynamic value) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        field: value,
      });
    } catch (e) {
      print('Error updating user field: $e');
    }
  }
}
