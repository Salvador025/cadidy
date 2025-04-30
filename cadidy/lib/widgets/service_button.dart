import 'package:cadidy/screens/hireService/hiring_service.dart';
import 'package:cadidy/screens/placeOrder/place_order.dart';
import 'package:flutter/material.dart';

class ServiceButton extends StatefulWidget {
  const ServiceButton({super.key, required this.imageURL, required this.labelService, this.isHiringFlow = false});
  final String imageURL;
  final String labelService;
  final bool isHiringFlow;

  @override
  State<ServiceButton> createState() => _ServiceButtonState();
}

class _ServiceButtonState extends State<ServiceButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      width: 125,
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
          onPressed: () {
            if (widget.isHiringFlow) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Hiringservice(
                    labelService: widget.labelService,
                    nameImage: widget.imageURL,
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlaceOrder(
                        labelService: widget.labelService,
                        nameImage: widget.imageURL
                  )
                )
              );
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.imageURL,
                color: Colors.white,
                colorBlendMode: BlendMode.darken,
              ),
              Text(
                widget.labelService,
                style: TextStyle(color: Colors.black, fontSize: 13),
              )
            ],
          )),
    );
  }
}
