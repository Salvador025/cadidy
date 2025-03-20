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
                      Image.asset("assets/images/welcome3.jpeg", width: 350, height: 350),
                    ],
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Work done", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text("Sit back and relax while experts", style: TextStyle(fontSize: 16)),
                          Text("efficiently take care of your tasks,", style: TextStyle(fontSize: 16)),
                          Text("ensuring a job well done.", style: TextStyle(fontSize: 16)),
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
                        child: Text("Finish"),
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