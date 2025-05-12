import 'package:cadidy/Providers/address_provider.dart';
import 'package:cadidy/service/orders_service.dart';
import 'package:cadidy/service/users_service.dart';
import 'package:cadidy/widgets/address_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaceOrder extends StatefulWidget {
  const PlaceOrder(
      {super.key, required this.labelService, required this.nameImage});
  final String labelService;
  final String nameImage;

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  final OrdersService ordersService = OrdersService();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<AddressProvider>().reset());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place Order',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        backgroundColor: Colors.grey[350],
        toolbarHeight: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.labelService,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(widget.nameImage, height: 100, width: 100),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Address',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ],
          ),
          const AddressDrawer(),
          Consumer<AddressProvider>(builder: (context, value, child) {
            return ElevatedButton(
              key: const Key('place_order_button'),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: value.isFormValid
                  ? () {
                      ordersService.addOrder(
                          UsersService.uid!,
                          widget.labelService,
                          value.details,
                          value.address,
                          value.price);
                      context.read<AddressProvider>().reset();
                      Navigator.pop(context);
                    }
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please fill in the all address fields'),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 5),
                      ));
                    },
              child: const Text('Place Order'),
            );
          })
        ]),
      ),
    );
  }
}
