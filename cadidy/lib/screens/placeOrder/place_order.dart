import 'package:cadidy/Providers/address_provider.dart';
import 'package:cadidy/service/orders_service.dart';
import 'package:cadidy/service/users_service.dart';
import 'package:cadidy/widgets/address_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaceOrder extends StatelessWidget {
  PlaceOrder({super.key, required this.labelService, required this.nameImage});
  final String labelService;
  final String nameImage;
  final OrdersService ordersService = OrdersService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Order', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        backgroundColor: Colors.grey[350],
        toolbarHeight: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  labelService,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(nameImage, height: 100, width: 100),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ],
            ),
            AddressDrawer(),
            Consumer<AddressProvider>(
              builder: (context, value, child) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  onPressed: value.isFormValid ? () {
                    ordersService.addOrder(
                      UsersService.uid!, 
                      labelService, 
                      value.details, 
                      value.address, 
                      value.price
                    );
                    context.read<AddressProvider>().reset();
                    Navigator.pop(context);
                  } : () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill in the all address fields'),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 5),
                      )
                    );
                  }, 
                  child: Text('Place Order'),
                );
              }
            )
          ]
        ),
      ),
    );
  }
}