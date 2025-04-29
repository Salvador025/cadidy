import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderProvider with ChangeNotifier {
  List<Map<String, dynamic>> _orders = [];

  List<Map<String, dynamic>> get orders => _orders;

  Future<void> fetchOrders() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: uid)
        .get();

    _orders = snapshot.docs.map((doc) {
      return {
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>,
      };
    }).toList();

    notifyListeners();
  }
}
