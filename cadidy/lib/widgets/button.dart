import 'package:flutter/material.dart';

void main() => runApp(const Boton1());

class Boton1 extends StatelessWidget {
  final ButtonStyle? style;
  final VoidCallback? onPressed;
  final String text;

  const Boton1({
    super.key,
    this.style,
    this.onPressed,
    this.text = "Get Started",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(8.0),
      child:
              ElevatedButton(
                onPressed: () {},
                
                child: Text("Get Started", style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.center)
              )
    );
  }
}