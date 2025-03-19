import 'package:flutter/material.dart';

class AddressDrawer extends StatefulWidget {
  const AddressDrawer({super.key});

  @override
  State<AddressDrawer> createState() => _AddressDrawerState();
}

class _AddressDrawerState extends State<AddressDrawer> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(20)
            ),
            child: ListTile(
              title: Text('Add Address'),
              leading: Icon(Icons.location_on_rounded),
              onTap: () {
                
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
              title: Text('Add details'),
              leading: Icon(Icons.text_snippet_outlined),
              onTap: () {

              },
            ),
          )
        ],
      );
  }
}