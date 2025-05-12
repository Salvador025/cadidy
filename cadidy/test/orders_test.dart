import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:cadidy/service/orders_service.dart';

void main() {
  group('OrdersService', () {
    late OrdersService ordersService;
    late FakeFirebaseFirestore fakeFirestore;
    late MockFirebaseAuth mockAuth;

    setUp(() async {
      fakeFirestore = FakeFirebaseFirestore();
      mockAuth = MockFirebaseAuth(mockUser: MockUser(uid: '123'));
      await mockAuth.signInWithEmailAndPassword(
          email: 'test@test.com', password: '123456');
      ordersService = OrdersService(
        firestore: fakeFirestore,
        auth: mockAuth,
      );
    });

    test('addOrder should store a new order in Firestore', () async {
      await ordersService.addOrder('123', 'limpieza', 'Limpieza de cocina',
          'Av. Siempre Viva 123', 200.0);

      final snapshot = await fakeFirestore.collection('orders').get();
      expect(snapshot.docs.length, 1);
      expect(snapshot.docs.first['category'], 'limpieza');
    });

    test('getOrders should return user orders ordered by category', () async {
      await fakeFirestore.collection('orders').add({
        'userId': '123',
        'category': 'albañilería',
        'description': 'Reparar muro',
        'address': 'Zona centro',
        'price': 500.0
      });

      final orders = await ordersService.getOrders('123');
      expect(orders.length, 1);
      expect(orders.first['category'], 'albañilería');
    });

    test('getOrder should return order by ID', () async {
      final docRef = await fakeFirestore.collection('orders').add({
        'userId': '123',
        'category': 'plomería',
        'description': 'Reparar fuga',
        'address': 'Col. Industrial',
        'price': 300.0
      });

      final order = await ordersService.getOrder(docRef.id);
      expect(order, isNotNull);
      expect(order!['description'], 'Reparar fuga');
    });

    test('getOrdersByCategory should exclude current user', () async {
      await fakeFirestore.collection('orders').add({
        'userId': '456',
        'category': 'electricidad',
        'description': 'Instalar foco',
        'address': 'Calle Luna',
        'price': 120.0
      });

      final orders = await ordersService.getOrdersByCategory('electricidad');
      expect(orders.length, 1);
      expect(orders.first['userId'], isNot('123'));
    });

    test('updateOrder should modify order fields', () async {
      final docRef = await fakeFirestore.collection('orders').add({
        'userId': '123',
        'category': 'original',
        'description': 'Desc',
        'address': 'Old Address',
        'price': 50.0
      });

      await ordersService.updateOrder(
          docRef.id, 'actualizado', 'Nueva desc', 'Nueva direccion', 999.0);

      final snapshot =
          await fakeFirestore.collection('orders').doc(docRef.id).get();
      expect(snapshot['category'], 'actualizado');
      expect(snapshot['price'], 999.0);
    });

    test('deleteOrder should remove the order', () async {
      final docRef = await fakeFirestore.collection('orders').add({
        'userId': '123',
        'category': 'temporal',
        'description': 'Eliminar esto',
        'address': 'N/A',
        'price': 0.0
      });

      await ordersService.deleteOrder(docRef.id);

      final snapshot = await fakeFirestore.collection('orders').get();
      expect(snapshot.docs.length, 0);
    });
  });
}
