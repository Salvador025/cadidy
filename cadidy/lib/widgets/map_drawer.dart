import 'package:cadidy/Providers/address_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class MapDrawer extends StatefulWidget {
  const MapDrawer({super.key});

  @override
  State<MapDrawer> createState() => _MapDrawerState();
}

class _MapDrawerState extends State<MapDrawer> {
  LatLng? tappedLocation; // Variable para guardar la ubicación del clic

  TextEditingController searchController = TextEditingController();

  void fillTextField(String address) {
    searchController.text = address;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(
        builder: (context, value, child) {
          return Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(value.latitude, value.longitude),
                  initialZoom: 17.5,
                  onTap: (tapPosition, point) { // Captura el punto donde se hace clic
                    setState(() {
                      tappedLocation = point; // Guarda la ubicación
                      value.setlatitude(tappedLocation!.latitude);
                      value.setlongitude(tappedLocation!.longitude);
                      fillTextField('address');
                    });
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  RichAttributionWidget(
                    attributions: [
                      TextSourceAttribution(
                        'OpenStreetMap contributors',
                        onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                      ),
                    ],
                  ),
                  if (tappedLocation != null) 
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: tappedLocation!,
                          width: 40,
                          height: 40,
                          child: Icon(Icons.location_pin, color: Colors.red, size: 40),
                        ),
                      ],
                    ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: GestureDetector(
                      onTap: () {
                        value.setAddress(searchController.text);
                        value.setlatitude(tappedLocation!.latitude);
                        value.setlongitude(tappedLocation!.longitude);
                      },
                      child: Icon(Icons.location_pin),
                    ),
                    labelText: 'Search Location',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        searchController.clear();
                        value.reset();
                        setState(() {
                          tappedLocation = null;
                        });
                      },
                      child: Icon(Icons.clear),
                    )
                  ),
                ),
            ),
            if (tappedLocation != null)
              Positioned(
                bottom: 20,
                left: 20,
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Text(
                    "Ubicación:\n ${value.latitude}\n ${value.longitude}",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
          ],
        );
      }
    );
  }
}