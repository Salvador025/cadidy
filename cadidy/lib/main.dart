import 'package:cadidy/Providers/address_provider.dart';
import 'package:cadidy/Providers/notification_provider.dart';
import 'package:cadidy/Providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:cadidy/screens/dashboard/home.dart';
import 'package:provider/provider.dart';

void main() {
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
    return MaterialApp(
      title: 'Cadidy',
      home: Home()
      );
  }
}