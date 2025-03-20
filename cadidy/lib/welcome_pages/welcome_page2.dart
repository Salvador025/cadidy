import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PageController();

    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/welcome1.jpeg", width: 350, height: 350),
                    ],
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Choose a service", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text("Find the right service for your needs", style: TextStyle(fontSize: 16)),
                          Text("easily, with a variety of options"),
                          Text("available at your fingertips.", style: TextStyle(fontSize: 16)),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          controller.previousPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text("Skip"),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text("Next"),
                      ),
                    ],
                  )
                ],
              ),
              SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: WormEffect(
                  dotWidth: 10.0,
                  dotHeight: 10.0,
                  spacing: 16.0,
                  dotColor: Colors.grey,
                  activeDotColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}