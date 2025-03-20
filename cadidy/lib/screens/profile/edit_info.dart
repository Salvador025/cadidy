import 'package:flutter/material.dart';

class EditInfoPage extends StatelessWidget {
  final String title;
  final String info;

  const EditInfoPage({
    super.key,
    required this.title,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              info,
              style: const TextStyle(fontSize: 18),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'New value',
              ),
            ),
          ],
        ),
      ),
    );
  }
}