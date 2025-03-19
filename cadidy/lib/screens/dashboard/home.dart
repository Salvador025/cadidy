import 'package:cadidy/screens/dashboard/notifications.dart';
import 'package:cadidy/screens/dashboard/orders.dart';
import 'package:cadidy/widgets/dashboard_home.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var currentPage = 0;

  var servicesImages = [
    'assets/images/cleaning_service.png',
    'assets/images/gardening_service.png',
    'assets/images/electrician_service.png',
    'assets/images/carpenter_service.png',
    'assets/images/barbering_service.png',
    'assets/images/makeup_service.png',
    'assets/images/dogWalk_service.png',
    'assets/images/veterinarian_service.png',
    'assets/images/more.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        DashboardHome(),
        Orders(),
        Notifications(),
      ][currentPage],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPage,
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_outlined),
            label: 'Orders'
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            label: 'Notifications',
          )
        ]),
    );
  }
}