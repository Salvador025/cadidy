import 'package:cadidy/Providers/order_provider.dart';
import 'package:cadidy/screens/placeOrder/edit_order.dart';
import 'package:cadidy/service/orders_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 400), () async {
      await context.read<OrderProvider>().fetchOrders();
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        final orders = orderProvider.orders;

        return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text('Orders',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            ),
            backgroundColor: Colors.grey[350],
            toolbarHeight: 100,
          ),
          body: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () async {
                    await context.read<OrderProvider>().fetchOrders();
                  },
                  child: orders.isNotEmpty
                      ? ListView.builder(
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            final order = orders[index];
                            return ListTile(
                              leading: const Icon(Icons.receipt_long),
                              title: Text(order['category']),
                              subtitle: Text(order['description']),
                              trailing: SizedBox(
                                width: 150,
                                height: 50,
                                child: Row(
                                  children: [
                                    Text(
                                        "\$${order['price']?.toStringAsFixed(2)}"),
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditOrder(
                                              orderId: order['id'],
                                              category: order['category'],
                                              description: order['description'],
                                              price: order['price'],
                                              address: order['address'],
                                            ),
                                          ),
                                        ).then((_) {
                                          context
                                              .read<OrderProvider>()
                                              .fetchOrders();
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        OrdersService()
                                            .deleteOrder(order['id'])
                                            .then((_) {
                                          context
                                              .read<OrderProvider>()
                                              .fetchOrders();
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : ListView(
                          children: const [
                            SizedBox(height: 100),
                            Icon(Icons.receipt, size: 100, color: Colors.grey),
                            SizedBox(height: 20),
                            Center(
                              child: Text(
                                'No Orders Yet',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  'You have no active order right now.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
        );
      },
    );
  }
}
