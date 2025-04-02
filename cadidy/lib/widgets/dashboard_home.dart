import 'package:flutter/material.dart';
import 'package:cadidy/widgets/service_button.dart';
import 'package:cadidy/widgets/menu_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardHome extends StatefulWidget {
  const DashboardHome({super.key});

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  var servicesImages = [
    'assets/images/service_icons/cleaning.jpg',
    'assets/images/service_icons/garden.jpg',
    'assets/images/service_icons/electrician.jpg',
    'assets/images/service_icons/carpenter.jpg',
    'assets/images/service_icons/barber.jpg',
    'assets/images/service_icons/makeup.jpg',
    'assets/images/service_icons/dog.jpg',
    'assets/images/service_icons/veterinarian.jpg',
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
              Text(
                'Cadidy',
                style: GoogleFonts.bebasNeue(fontSize: 30),
              ),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 170, 126, 74),
          toolbarHeight: 85,
          iconTheme: IconThemeData(
            color: Colors.white, // Color del ícono del drawer
            size: 32, // Tamaño del ícono
          ),
        ),
        endDrawer: Drawer(
          backgroundColor: Color.fromARGB(255, 63, 59, 55),
          child: Column(
            children: [
              Container(
                color: Color.fromARGB(255, 170, 126, 74),
                height: 120,
                child: DrawerHeader(
                    margin: EdgeInsets.only(top: 10),
                    child: ListTile(
                      leading: Text('Cadidy',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 30, color: Colors.black)),
                      trailing: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close_sharp,
                          )),
                    )),
              ),
              MenuDrawer(),
            ],
          ),
        ),
        body: Container(
          color: Color.fromARGB(255, 63, 59, 55),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Services',
                      style: GoogleFonts.bebasNeue(
                          color: Color.fromARGB(255, 170, 126, 74),
                          fontSize: 30)),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search services...',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  // Aquí puedes implementar la lógica de filtrado si deseas
                },
              ),
              SizedBox(height: 10),
              Expanded(
                child: GridView.count(crossAxisCount: 2, children: [
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
                ]),
              ),
            ],
          ),
        ));
  }
}
