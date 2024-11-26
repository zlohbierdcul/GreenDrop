import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class Shop {
  final String id;
  final String name;
  final double latitude;
  final double longitude;

  Shop({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  // Methode zum Berechnen der Entfernung in Kilometern
  double calculateDistance(double lat2, double lon2) {
    const double radius = 6371; // Erdradius in km
    double dLat = _degreesToRadians(lat2 - latitude);
    double dLon = _degreesToRadians(lon2 - longitude);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(latitude)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return radius * c; // Entfernung in km
  }

  static double _degreesToRadians(double degree) {
    return degree * pi / 180;
  }

  // Shop-Daten aus der JSON einlesen und Geocoding durchführen
  static Future<List<Shop>> parseShops(String response) async {
    Map<String, dynamic> data = jsonDecode(response);
    List<Shop> shops = [];

    for (var key in data.keys) {
      final shopData = data[key];
      final address = "${shopData['street']} ${shopData['streetNumber']}, ${shopData['zipCode']} ${shopData['city']}";

      try {
        final locations = await locationFromAddress(address);
        if (locations.isNotEmpty) {
          final location = locations.first;
          shops.add(Shop(
            id: key,
            name: shopData['name'],
            latitude: location.latitude,
            longitude: location.longitude,
          ));
        }
      } catch (e) {
        print('Geocoding-Fehler für $address: $e');
      }
    }

    return shops;
  }
}

class ShopsMap extends StatefulWidget {
  const ShopsMap({Key? key}) : super(key: key);

  @override
  State<ShopsMap> createState() => _ShopsMapState();
}

class _ShopsMapState extends State<ShopsMap> {
  List<Marker> _markers = [];
  double latitudePerson = 49.492654; // Beispielstartposition
  double longitudePerson = 8.471250;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    // Lade die JSON-Datei
    String response = await rootBundle.loadString('assets/data/mock-shops.json');

    // Parse die Shops und berechne Marker
    List<Shop> shops = await Shop.parseShops(response);
    double radius = 10.0; // Radius in km

    List<Marker> markers = [];
    for (var shop in shops) {
      double distance = shop.calculateDistance(latitudePerson, longitudePerson);
      if (distance <= radius) {
        markers.add(
          Marker(
            point: LatLng(shop.latitude, shop.longitude),
            child: const Icon(
              Icons.location_on,
              size: 40.0,
              color: Colors.blue,
            ),
          ),
        );
      }
    }

    setState(() {
      _markers = markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: latitudePerson != 49.492654 && longitudePerson != 8.471250
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(latitudePerson, longitudePerson),
          initialZoom: 14,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(markers: _markers),
        ],
      ),
    );
  }
}
