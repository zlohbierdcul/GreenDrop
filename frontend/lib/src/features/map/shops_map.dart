import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

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

  double calculateDistance(double lat2, double lon2) {
    const double radius = 6371;
    double dLat = _degreesToRadians(lat2 - latitude);
    double dLon = _degreesToRadians(lon2 - longitude);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(latitude)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return radius * c;
  }

  static double _degreesToRadians(double degree) {
    return degree * pi / 180;
  }

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
  double latitudePerson = 49.492654; // Standardposition
  double longitudePerson = 8.471250;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    // Prüfe Standortberechtigungen
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Standortberechtigungen abgelehnt.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Standortberechtigungen permanent abgelehnt.');
      return;
    }

    // Hole die aktuelle Position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      latitudePerson = position.latitude;
      longitudePerson = position.longitude;
    });

    // Initialisiere die Shops und Marker
    await _initializeMap();
  }

  Future<void> _initializeMap() async {
    String response = await rootBundle.loadString('assets/data/mock-shops.json');
    List<Shop> shops = await Shop.parseShops(response);
    double radius = 10.0;

    List<Marker> markers = [
      // Nutzerposition hinzufügen
      Marker(
        point: LatLng(latitudePerson, longitudePerson),
        width: 40.0,
        height: 40.0,
        child: Icon(
          Icons.person_pin,
          size: 40.0,
          color: Colors.red,
        ),
      ),
    ];

    for (var shop in shops) {
      double distance = shop.calculateDistance(latitudePerson, longitudePerson);
      if (distance <= radius) {
        markers.add(
          Marker(
            point: LatLng(shop.latitude, shop.longitude),
            width: 40.0,
            height: 40.0,
            child: Icon(
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
      body: latitudePerson == 49.492654 && longitudePerson == 8.471250
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