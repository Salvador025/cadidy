import 'package:cadidy/widgets/details_order_drawer.dart';
import 'package:flutter/material.dart';

class DetailsOrder extends StatelessWidget {
  const DetailsOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        backgroundColor: Colors.grey[350],
        toolbarHeight: 100,
      ),
      body: Center(
        child: DetailsOrderDrawer()
      ),
    );
  }
}