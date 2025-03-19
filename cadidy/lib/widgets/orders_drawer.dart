import 'package:flutter/material.dart';

class OrdersDrawer extends StatefulWidget {
  const OrdersDrawer({super.key});

  @override
  State<OrdersDrawer> createState() => _OrdersDrawerState();
}

class _OrdersDrawerState extends State<OrdersDrawer> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('Order 1'),
          subtitle: Text('This is the first order'),
          leading: Icon(Icons.receipt),
        )
      ],
    );
  }
}