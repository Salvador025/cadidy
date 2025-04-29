import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersService {
  final CollectionReference orders = FirebaseFirestore.instance.collection('orders');

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

  Future<void> addOrder(String uid, String category, String description, String address, double price) {
    return orders.add({
      'userId': uid,
      'category': category,
      'description': description,
      'address': address,
      'price': price
    })
    .then((value) => print("Order added successfully!"))
    .catchError((error) => print("Failed to add order: $error"));
  }

  Future<void> updateOrder(String orderId, String category, String description, String address, double price) {
    return orders.doc(orderId).update({
      'category': category,
      'description': description,
      'address': address,
      'price': price,
    })
    .then((value) => print("Order updated successfully!"))
    .catchError((error) => print("Failed to update order: $error"));
  }

  Future<void> deleteOrder(String productId) {
    return orders.doc(productId).delete()
    .then((value) => print("Order deleted successfully!"))
    .catchError((error) => print("Failed to delete order: $error"));
  }
}
