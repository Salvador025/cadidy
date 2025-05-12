import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:cadidy/screens/placeOrder/place_order.dart';
import 'package:cadidy/Providers/address_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cadidy/firebase_options.dart';
import 'package:cadidy/service/users_service.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('flujo de ordenamiento válido e inválido',
      (WidgetTester tester) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Configura el entorno con AddressProvider
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AddressProvider()),
        ],
        child: MaterialApp(
          home: PlaceOrder(
              labelService: 'Electricidad',
              nameImage: 'assets/images/cleaning_service.png'),
        ),
      ),
    );

    UsersService.uid = 'test-user-id';
    await tester.pumpAndSettle();

    // Verifica que se muestra el nombre del servicio
    expect(find.text('Electricidad'), findsOneWidget);

    // Intenta hacer tap en el botón sin llenar los datos (debe mostrar SnackBar)
    await tester.tap(find.byKey(Key('place_order_button')));

    await tester.pump(); // Esperar animación SnackBar

    expect(find.text('Please fill in the all address fields'), findsOneWidget);

    // Llenar datos manualmente en el AddressProvider
    final context = tester.element(find.byType(PlaceOrder));
    final addressProvider = context.read<AddressProvider>();

    addressProvider.setAddress('Calle 123');
    addressProvider.setDetails('Detalle del servicio');
    addressProvider.setPrice(150.0);

    await tester.pump(); // Refrescar estado

    // Toca el botón de nuevo (ahora válido)
    await tester.tap(find.byKey(Key('place_order_button')));

    await tester.pumpAndSettle(); // Esperar Navigator.pop

    // Podrías verificar que se hizo pop si usas una `NavigatorObserver` mock (más avanzado)
  });
}
