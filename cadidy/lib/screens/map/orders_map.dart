import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cadidy/service/orders_service.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class OrdersMapScreen extends StatefulWidget {
  const OrdersMapScreen({super.key});

  @override
  State<OrdersMapScreen> createState() => _OrdersMapScreenState();
}

class _OrdersMapScreenState extends State<OrdersMapScreen> {
  final MapController _mapController = MapController();
  List<Marker> _markers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadOrderLocations();
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
        final double lat = double.parse(data[0]['lat']);
        final double lon = double.parse(data[0]['lon']);
        return LatLng(lat, lon);
      }
    }
    return null;
  }

  Future<void> _loadOrderLocations() async {
    final orders = await OrdersService().getAllOrders();
    final List<Marker> loadedMarkers = [];

    for (var order in orders) {
      final LatLng? coord = await getCoordinatesFromAddress(order['address']);
      if (coord != null) {
        loadedMarkers.add(
          Marker(
            point: coord,
            width: 40,
            height: 40,
            child: Tooltip(
              message: order['category'],
              child:
                  const Icon(Icons.location_pin, color: Colors.red, size: 40),
            ),
          ),
        );
      }
    }

    setState(() {
      _markers = loadedMarkers;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders Map"),
        backgroundColor: const Color.fromARGB(255, 170, 126, 74),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _markers.isNotEmpty
                    ? _markers.first.point
                    : LatLng(20.608229, -103.417031),
                initialZoom: 13,
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
                MarkerLayer(markers: _markers),
              ],
            ),
    );
  }
}
