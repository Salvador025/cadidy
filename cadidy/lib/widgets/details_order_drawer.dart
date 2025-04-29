import 'package:cadidy/Providers/address_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsOrderDrawer extends StatefulWidget {
  const DetailsOrderDrawer({super.key});

  @override
  State<DetailsOrderDrawer> createState() => _DetailsOrderDrawerState();
}

class _DetailsOrderDrawerState extends State<DetailsOrderDrawer> {
  TextEditingController detailsFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    detailsFieldController.text = context.read<AddressProvider>().details;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Consumer<AddressProvider>(
        builder: (context, orderProvider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: detailsFieldController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Details',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.deepPurple, width: 1),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read<AddressProvider>().setDetails(detailsFieldController.text);
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Save', style: TextStyle(color: Colors.white)),
              )
            ]
          );
        }
      ),
    );
  }
}