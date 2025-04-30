import 'package:cadidy/screens/placeOrder/confirm_order.dart';
import 'package:cadidy/service/orders_service.dart';
import 'package:flutter/material.dart';

class ServiceListWidget extends StatefulWidget {
  const ServiceListWidget({super.key, required this.category});
  final String category;

  @override
  State<ServiceListWidget> createState() => _ServiceListWidgetState();
}

class _ServiceListWidgetState extends State<ServiceListWidget> {

  Future<List<dynamic>>? _servicesList;

  void _loadServices() {
    setState(() {
      _servicesList = OrdersService().getOrdersByCategory(widget.category);
    });
  }

  void _refreshServices() {
    setState(() {
      _servicesList = null;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  Widget _buildServiceList() {
    return FutureBuilder<List<dynamic>>(
      future: _servicesList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No services available'));
        } else {
          final services = snapshot.data!;
          return ListView.builder(
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return ListTile(
                leading: Icon(Icons.check_circle),
                title: Text('Barber Service'),
                subtitle: Text('Price: \$${service['price']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmOrder(
                        orderId: service['id'],
                        category: widget.category,
                        description: service['description'],
                        price: service['price'],
                        address: service['address'],
                      ),
                    ),
                  ).then((_) {
                    _refreshServices(); // Refresh the list after returning from details
                  });
                },
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _buildServiceList(),
      );
  }
}