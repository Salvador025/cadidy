import 'package:cadidy/Providers/address_provider.dart';
import 'package:cadidy/screens/placeOrder/details_order.dart';
import 'package:cadidy/screens/placeOrder/map.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressDrawer extends StatefulWidget {
  const AddressDrawer({super.key});

  @override
  State<AddressDrawer> createState() => _AddressDrawerState();
}

class _AddressDrawerState extends State<AddressDrawer> {
  TextEditingController priceFieldController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    priceFieldController.text = context.read<AddressProvider>().price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<AddressProvider>(
        builder: (context, value, child) {
        return Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: ListTile(
                  title: Text(value.address),
                  leading: Icon(Icons.location_on_rounded),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MapScreen()));
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: ListTile(
                  title: Text(value.details),
                  leading: Icon(Icons.text_snippet_outlined),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsOrder()));
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: ListTile(
                  title: Text('Price: ${value.price}'),
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
              )
            ],
          );
        }
      ),
    );
  }
}