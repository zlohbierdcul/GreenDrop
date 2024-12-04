import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:greendrop/src/features/shops/data/shop.dart';
import 'package:latlong2/latlong.dart';

class ShopsMap extends StatefulWidget {
  final Map<String, Shop> shopMap;

  const ShopsMap({super.key, required this.shopMap});

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

  @override
  void didUpdateWidget(covariant ShopsMap oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if shopMap has changed
    if (oldWidget.shopMap != widget.shopMap) {
      _initializeMap(); // Reinitialize the markers
    }
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
    List<Shop> shops = widget.shopMap.values.toList();
    double radius = 10.0;
    print(shops);

    List<Marker> markers = [
      // Nutzerposition hinzufügen
      Marker(
        point: LatLng(latitudePerson, longitudePerson),
        width: 40.0,
        height: 40.0,
        child: const Icon(
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
