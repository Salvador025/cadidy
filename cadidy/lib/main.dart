import 'package:cadidy/Providers/address_provider.dart';
import 'package:cadidy/Providers/notification_provider.dart';
import 'package:cadidy/Providers/order_provider.dart';
import 'package:cadidy/firebase_options.dart';
import 'package:cadidy/screens/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Configuración de Stripe
  Stripe.publishableKey =
      'pk_test_51RMP5n2euRDOKVU1lvUSxYLzmH6EzleqhfplFYoDqjR9DTWPZmoy16HvPORXldBq99favFfghnJm2v3CSokRpyWs00V9miQATt';
  await Stripe.instance.applySettings();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => AddressProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Cadidy', home: AuthGate());
  }
}
