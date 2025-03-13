import 'package:flutter/material.dart';

void main() => runApp(const Boton1());

class Boton1 extends StatelessWidget {
  const Boton1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(8.0),
      child:
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text("Get Started", style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.center)
              )
    );
  }
}