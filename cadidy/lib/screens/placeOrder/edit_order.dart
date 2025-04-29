import 'package:cadidy/Providers/address_provider.dart';
import 'package:cadidy/screens/placeOrder/details_order.dart';
import 'package:cadidy/screens/placeOrder/map.dart';
import 'package:cadidy/service/orders_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditOrder extends StatefulWidget {
  const EditOrder({super.key, required this.orderId, required this.category, required this.description, required this.price, required this.address});
  final String orderId;
  final String category;
  final String description;
  final double price;
  final String address;

  @override
  State<EditOrder> createState() => _EditOrderState();
}

class _EditOrderState extends State<EditOrder> {
  TextEditingController priceFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    priceFieldController = TextEditingController(
      text: widget.price.toStringAsFixed(2)
    );
    context.read<AddressProvider>().setAddress(widget.address);
    context.read<AddressProvider>().setDetails(widget.description);
    context.read<AddressProvider>().setPrice(widget.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Edit Order', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Consumer<AddressProvider>(
          builder: (context, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  widget.category,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text(value.address),
                  leading: Icon(Icons.location_on_rounded),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MapScreen()));
                  },
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text(value.details),
                  leading: Icon(Icons.text_snippet_outlined),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsOrder()));
                  },
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text('Price: ${priceFieldController.text}'),
                  leading: Icon(Icons.monetization_on_outlined),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Enter Price'),
                          content: TextField(
                            controller: priceFieldController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(hintText: 'Price'),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                value.setPrice(double.parse(priceFieldController.text));
                                priceFieldController.text = value.price.toStringAsFixed(2);
                                Navigator.pop(context);
                              },
                              child: Text('Save')
                            )
                          ],
                        );
                      }
                    );
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final provider = context.read<AddressProvider>();
                    OrdersService().updateOrder(
                      widget.orderId,
                      widget.category,
                      provider.details,
                      provider.address,
                      provider.price,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Update Order'),
                ),
              ],
            );
          }
        )
      ),
    );
  }
}