import 'package:cadidy/screens/dashboard/home.dart';
import 'package:flutter/material.dart';

class CompleteProfileInfo extends StatelessWidget {
  const CompleteProfileInfo({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Complete your profile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text(email, style: TextStyle(fontSize: 20)))
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: Text('Confirm'),
            )
          ],
        )
      )
    );
  }
}