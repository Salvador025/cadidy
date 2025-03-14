import 'package:cadidy/widgets/menu_drawer.dart';
import 'package:cadidy/widgets/service_button.dart';
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
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/Icon.png',
              width: 170,
              height: 170,
            ),
            Text(
                'Cadidy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto Flex',
                  fontSize: 22
                ),
              ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 204, 253, 4),
        toolbarHeight: 198,
      ),
      endDrawer: Drawer(
        child: Column(
            children: [
              DrawerHeader(
                margin: EdgeInsets.only(top: 10),
                child: ListTile(
                  leading: Text(
                    'Cadidy',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto Flex',
                      fontSize: 30
                    )
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    }, 
                    icon: Icon(Icons.close_sharp)
                  ),
                )
              ),
              MenuDrawer(),
            ],
          ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Services', style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                )),
              ],
            ),
            Expanded(
              child: GridView.count(
                  crossAxisCount: 2,
                  children: [ 
                    ServiceButton(
                      imageURL: servicesImages[0],
                      labelService: 'Cleaning',
                    ),
                    ServiceButton(
                      imageURL: servicesImages[1],
                      labelService: 'Gardening',
                    ),
                    ServiceButton(
                      imageURL: servicesImages[2],
                      labelService: 'Electrician',
                    ),
                    ServiceButton(
                      imageURL: servicesImages[3],
                      labelService: 'Carpenter',
                    ),
                    ServiceButton(
                      imageURL: servicesImages[4],
                      labelService: 'Barbering',
                    ),
                    ServiceButton(
                      imageURL: servicesImages[5],
                      labelService: 'Makeup',
                    ),
                    ServiceButton(
                      imageURL: servicesImages[6],
                      labelService: 'Dog Walk',
                    ),
                    ServiceButton(
                      imageURL: servicesImages[7],
                      labelService: 'Veterinarian',
                    ),
                  ]
                ),
            ),
          ],
        ),
      ),
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
            label: 'Notifications'
          )
        ]),
    );
  }
}