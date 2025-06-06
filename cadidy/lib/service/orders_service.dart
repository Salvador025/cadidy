import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrdersService {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  OrdersService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : firestore = firestore ?? FirebaseFirestore.instance,
        auth = auth ?? FirebaseAuth.instance;

  CollectionReference get orders => firestore.collection('orders');

  Future<List<dynamic>> getOrders(String uid) async {
    QuerySnapshot snapshot = await orders
        .where('userId', isEqualTo: uid)
        .orderBy('category', descending: false)
        .get();

    return snapshot.docs.map((doc) {
      return {
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>,
      };
    }).toList();
  }

  Future<Map<String, dynamic>?> getOrder(String orderId) async {
    DocumentSnapshot snapshot = await orders.doc(orderId).get();
    if (snapshot.exists) {
      return {
        'id': snapshot.id,
        ...snapshot.data() as Map<String, dynamic>,
      };
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getOrdersByCategory(
      String category) async {
    final currentUserId = auth.currentUser!.uid;

    QuerySnapshot snapshot = await orders
        .where('category', isEqualTo: category)
        .where('userId', isNotEqualTo: currentUserId)
        .get();

    return snapshot.docs.map((doc) {
      return {
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>,
      };
    }).toList();
  }

  Future<void> addOrder(String uid, String category, String description,
      String address, double price) {
    return orders
        .add({
          'userId': uid,
          'category': category,
          'description': description,
          'address': address,
          'price': price,
        })
        .then((value) => print("Order added successfully!"))
        .catchError((error) => print("Failed to add order: $error"));
  }

  Future<void> updateOrder(String orderId, String category, String description,
      String address, double price) {
    return orders
        .doc(orderId)
        .update({
          'category': category,
          'description': description,
          'address': address,
          'price': price,
        })
        .then((value) => print("Order updated successfully!"))
        .catchError((error) => print("Failed to update order: $error"));
  }

  Future<void> deleteOrder(String orderId) {
    return orders
        .doc(orderId)
        .delete()
        .then((value) => print("Order deleted successfully!"))
        .catchError((error) => print("Failed to delete order: $error"));
  }

  Future<List<Map<String, dynamic>>> getAllOrders() async {
    QuerySnapshot snapshot = await orders.get();

    return snapshot.docs.map((doc) {
      return {
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>,
      };
    }).toList();
  }
}
