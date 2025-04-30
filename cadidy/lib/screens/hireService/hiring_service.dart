import 'package:cadidy/widgets/service_list_widget.dart';
import 'package:flutter/material.dart';

class Hiringservice extends StatelessWidget {
  const Hiringservice({super.key, required this.labelService, required this.nameImage});
  final String labelService;
  final String nameImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hire a Service', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
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
                Text('Available Services', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ],
            ),
            ServiceListWidget(category: labelService)
          ]
        ),
      ),
    );
  }
}