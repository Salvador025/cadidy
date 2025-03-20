import 'package:cadidy/Providers/order_provider.dart';
import 'package:cadidy/widgets/orders_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    bool hasOrders;
    return Consumer<OrderProvider>(
      builder: (context, value, child) {
        hasOrders = value.order;
        if (hasOrders) {
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text('Orders', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              ),
              backgroundColor: Colors.grey[350],
              toolbarHeight: 100,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: OrdersDrawer()),
                  ElevatedButton(
                    onPressed: () {
                      context.read<OrderProvider>().setOrder(false);
                    },
                    child: Icon(Icons.turned_in, color: Colors.black),
                  )
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text('Orders', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              ),
              backgroundColor: Colors.grey[350],
              toolbarHeight: 100,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt, size: 100),
                  Text('No Orders Yet', 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text('You have no active order right now.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<OrderProvider>().setOrder(true);
                    },
                    child: Icon(Icons.turned_in, color: Colors.black),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}