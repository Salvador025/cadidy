import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

class ConfirmOrder extends StatefulWidget {
  const ConfirmOrder({
    super.key,
    required this.orderId,
    required this.category,
    required this.description,
    required this.price,
    required this.address,
  });

  final String orderId;
  final String category;
  final String description;
  final double price;
  final String address;

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  bool _isProcessing = false;

  Future<void> _makePayment() async {
    setState(() => _isProcessing = true);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Center(child: CircularProgressIndicator()),
      ),
    );

    try {
      final url = Uri.parse(
        'http://10.0.2.2:5001/cadidy-ac7b1/us-central1/createPaymentIntent',
      );

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'amount': (widget.price * 100).toInt()}),
      );

      if (response.statusCode != 200) {
        throw Exception('Error al crear el PaymentIntent: ${response.body}');
      }

      final clientSecret = jsonDecode(response.body)['clientSecret'];

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Cadidy',
        ),
      );

      Navigator.of(context).pop(); // Cierra el loader
      setState(() => _isProcessing = false);

      await Stripe.instance.presentPaymentSheet();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Pago realizado con éxito!')),
      );

      Navigator.pop(context);
    } catch (e) {
      Navigator.of(context).pop(); // Cierra el loader
      setState(() => _isProcessing = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al pagar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Service Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              widget.category,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: Text(widget.address),
              leading: const Icon(Icons.location_on_rounded),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: Text(widget.description),
              leading: const Icon(Icons.text_snippet_outlined),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: Text('Price: \$${widget.price.toStringAsFixed(2)}'),
              leading: const Icon(Icons.monetization_on_outlined),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isProcessing ? null : _makePayment,
                  child: const Text('Confirm and pay'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
