// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_stripe/flutter_stripe.dart';

// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({super.key});

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final _cardNumberController = TextEditingController();
//   final _expiryDateController = TextEditingController();
//   final _cvvController = TextEditingController();
//   final _cardholderNameController = TextEditingController();

//   @override
//   void dispose() {
//     _cardNumberController.dispose();
//     _expiryDateController.dispose();
//     _cvvController.dispose();
//     _cardholderNameController.dispose();
//     super.dispose();
//   }

//   Widget _buildTextField({
//     required String label,
//     required TextEditingController controller,
//     required TextInputType inputType,
//     bool obscure = false,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: inputType,
//         obscureText: obscure,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//           filled: true,
//           fillColor: Colors.grey[100],
//         ),
//         validator: (value) =>
//             value == null || value.isEmpty ? 'Este campo es requerido' : null,
//       ),
//     );
//   }

//   Future<void> _makeTestPayment() async {
//     try {
//       final url = Uri.parse(
//           'http://10.0.2.2:5001/cadidy-ac7b1/us-central1/createPaymentIntent');

//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'amount': 1000}), // $10.00 MXN
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Error al crear el PaymentIntent: ${response.body}');
//       }

//       final clientSecret = jsonDecode(response.body)['clientSecret'];

//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: clientSecret,
//           merchantDisplayName: 'Cadidy',
//         ),
//       );

//       await Stripe.instance.presentPaymentSheet();

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('¡Pago realizado con éxito!')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(
//           child: Text('Payment',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
//         ),
//         automaticallyImplyLeading: false,
//       ),
//       backgroundColor: const Color.fromARGB(255, 63, 59, 55),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               _buildTextField(
//                 label: 'Nombre del Titular',
//                 controller: _cardholderNameController,
//                 inputType: TextInputType.name,
//               ),
//               _buildTextField(
//                 label: 'Número de Tarjeta',
//                 controller: _cardNumberController,
//                 inputType: TextInputType.number,
//               ),
//               _buildTextField(
//                 label: 'Fecha de Expiración (MM/AA)',
//                 controller: _expiryDateController,
//                 inputType: TextInputType.datetime,
//               ),
//               _buildTextField(
//                 label: 'CVV',
//                 controller: _cvvController,
//                 inputType: TextInputType.number,
//               ),
//               const SizedBox(height: 30),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       await _makeTestPayment();
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     textStyle: const TextStyle(fontSize: 18),
//                   ),
//                   child: const Text('Pagar'),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('Cancelar'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
