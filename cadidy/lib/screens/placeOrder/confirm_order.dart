import 'package:cadidy/screens/payment/payment.dart';
import 'package:flutter/material.dart';

class ConfirmOrder extends StatefulWidget {
  const ConfirmOrder({super.key, required this.orderId, required this.category, required this.description, required this.price, required this.address});
  final String orderId;
  final String category;
  final String description;
  final double price;
  final String address;

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Service Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container (
        padding: const EdgeInsets.all(15),
        child: Column(
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
                  title: Text(widget.address),
                  leading: Icon(Icons.location_on_rounded),
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text(widget.description),
                  leading: Icon(Icons.text_snippet_outlined),
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text('Price: ${widget.price.toStringAsFixed(2)}'),
                  leading: Icon(Icons.monetization_on_outlined),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentScreen(),
                          ),
                        );
                      },
                      child: const Text('Confirm'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ],
            )
        )
      );
  }
}