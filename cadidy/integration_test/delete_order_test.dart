// import 'package:cadidy/screens/dashboard/orders.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:provider/provider.dart';
// import 'package:cadidy/Providers/order_provider.dart';

// class FakeOrderProvider extends ChangeNotifier implements OrderProvider {
//   final List<Map<String, dynamic>> _orders = [
//     {
//       'id': 'order1',
//       'category': 'Limpieza',
//       'description': 'Limpieza profunda de cocina',
//       'price': 250.0,
//       'address': 'Calle Falsa 123',
//     }
//   ];

//   @override
//   List<Map<String, dynamic>> get orders => _orders;

//   @override
//   Future<void> fetchOrders() async {
//     await Future.delayed(const Duration(milliseconds: 100));
//     notifyListeners();
//   }

//   @override
//   Future<void> deleteOrder(String id) async {
//     _orders.removeWhere((order) => order['id'] == id);
//     notifyListeners();
//   }
// }

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   testWidgets('eliminar una orden actualiza la lista',
//       (WidgetTester tester) async {
//     await tester.pumpWidget(
//       ChangeNotifierProvider<OrderProvider>(
//         create: (_) => FakeOrderProvider(),
//         child: const MaterialApp(home: Orders()),
//       ),
//     );

//     await tester.pumpAndSettle();

//     // Verifica que la orden aparece en pantalla
//     expect(find.text('Limpieza'), findsOneWidget);

//     // Encuentra el botón de eliminar
//     final deleteButton = find.byIcon(Icons.delete).first;
//     expect(deleteButton, findsOneWidget);

//     // Toca el botón de eliminar
//     await tester.tap(deleteButton);
//     await tester.pumpAndSettle();

//     // Verifica que ya no aparece la orden
//     expect(find.text('Limpieza'), findsNothing);
//   });
// }
