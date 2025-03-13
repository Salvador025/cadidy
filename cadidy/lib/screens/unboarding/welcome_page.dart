import 'package:flutter/material.dart';
import 'package:cadidy/widgets/button.dart';

void main() => runApp(const WelcomePage());

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadidy',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cadidy'),
        ),
        body: Padding(padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Best Helping", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 33)),
                      Text("Hands for you", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 33)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text("With Our On-Demand Services App, ", style: TextStyle(fontSize: 18)),
                      Text("We Give Better Services To You.", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset("assets/images/WorkerWP.jpeg.webp", width: 350, height: 350),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 190),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Boton1(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}