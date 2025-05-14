import 'package:cadidy/Providers/address_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapDrawer extends StatefulWidget {
  const MapDrawer({super.key});

  @override
  State<MapDrawer> createState() => _MapDrawerState();
}

class _MapDrawerState extends State<MapDrawer> {
  LatLng? tappedLocation; // Variable para guardar la ubicación del clic
  final MapController _mapController = MapController();

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.text = context.read<AddressProvider>().address;
  }

  void fillTextField(String address) {
    searchController.text = address;
  }

  Future<String> getAddressFromCoordinates(
      double latitude, double longitude) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$latitude&lon=$longitude',
    );

    final response = await http.get(url, headers: {
      'User-Agent': 'FlutterApp', // Es obligatorio poner un user-agent
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['display_name'] ?? 'Dirección no encontrada';
    } else {
      throw Exception('Error al obtener la dirección');
    }
  }

  Future<LatLng?> getCoordinatesFromAddress(String address) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=${Uri.encodeComponent(address)}&format=json&limit=1',
    );

    final response = await http.get(url, headers: {
      'User-Agent': 'FlutterApp',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data.isNotEmpty) {
        final firstResult = data[0];
        final double lat = double.parse(firstResult['lat']);
        final double lon = double.parse(firstResult['lon']);
        return LatLng(lat, lon);
      } else {
        return null;
      }
    } else {
      throw Exception('Error buscando coordenadas');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(builder: (context, value, child) {
      return Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: LatLng(value.latitude, value.longitude),
              initialZoom: 17.5,
              onTap: (tapPosition, point) async {
                setState(() {
                  tappedLocation = point;
                });
                _mapController.move(point, _mapController.camera.zoom);
                value.setlatitude(tappedLocation!.latitude);
                value.setlongitude(tappedLocation!.longitude);
                try {
                  String address = await getAddressFromCoordinates(
                    tappedLocation!.latitude,
                    tappedLocation!.longitude,
                  );
                  fillTextField(address);
                  value.setAddress(address);
                } catch (e) {
                  print('Error obteniendo la dirección: $e');
                }
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
                    onTap: () => launchUrl(
                        Uri.parse('https://openstreetmap.org/copyright')),
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
                      child:
                          Icon(Icons.location_pin, color: Colors.red, size: 40),
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
              onSubmitted: (valueText) async {
                if (valueText.isNotEmpty) {
                  try {
                    LatLng? newLocation =
                        await getCoordinatesFromAddress(valueText);
                    if (newLocation != null) {
                      setState(() {
                        tappedLocation = newLocation;
                      });
                      _mapController.move(
                          newLocation, _mapController.camera.zoom);
                      value.setlatitude(newLocation.latitude);
                      value.setlongitude(newLocation.longitude);
                      value.setAddress(valueText);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Dirección no encontrada'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  } catch (e) {}
                }
              },
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
                  )),
            ),
          ),
          if (tappedLocation != null)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20, // <-- Asegura que ocupe el ancho completo con margen
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ubicación:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      value.address,
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 170, 126, 74),
                        ),
                        child: Text("Confirmar",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      );
    });
  }
}
