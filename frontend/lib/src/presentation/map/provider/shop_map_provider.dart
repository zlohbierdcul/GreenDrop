import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/presentation/products/pages/product_page.dart';
import 'package:latlong2/latlong.dart';
import 'package:logging/logging.dart';

class ShopMapProvider extends ChangeNotifier {
  Logger log = Logger("ShopMapProvider");

  List<Marker> _markers = [];
  double _latitudePerson = 49.492654; // Standardposition
  double _longitudePerson = 8.471250;

  double get latitudePerson => _latitudePerson;
  double get longitudePerson => _longitudePerson;
  List<Marker> get markers => _markers;

  void initializeMap(List<Shop> shops, BuildContext context) async {
    _markers = [];
    _createUserMarker(context);
    _createShopMarker(shops, context);
  }

  Future<void> _createUserMarker(BuildContext context) async {
    log.info("Creating user marker.");
    // Prüfe Standortberechtigungen
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log.info('Standortberechtigungen abgelehnt.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      log.info('Standortberechtigungen permanent abgelehnt.');
      return;
    }

    // Hole die aktuelle Position
    Position position = await Geolocator.getCurrentPosition();

    _latitudePerson = position.latitude;
    _longitudePerson = position.longitude;

    _markers = [
      ..._markers,
      Marker(
        point: LatLng(_latitudePerson, _longitudePerson),
        width: 30.0,
        height: 30.0,
        child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.location_pin,
                color: Theme.of(context).colorScheme.onPrimary)),
      ),
    ];

    notifyListeners();
    log.info("Finished creating user marker");
  }

  double _calculateDistance(
      double lat1, double lat2, double lon1, double lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<void> _createShopMarker(List<Shop> shops, BuildContext context) async {
    log.info("Creating shop markers.");
    List<Marker> shopMarker = [];

    for (var shop in shops) {
      final radius = shop.radius;

      if (shop.latitude == 0 && shop.longitude == 0) {
        Coordinates coordinates =
            await _getCoordinatesOfAddress(shop.address.toString());
        shop.latitude = coordinates.latitude ?? 0;
        shop.longitude = coordinates.longitude ?? 0;
      }

      double distance = _calculateDistance(
          latitudePerson, shop.latitude, longitudePerson, shop.longitude);
      log.fine("Distance: $distance");
      if (distance <= radius) {
        _markers.add(
          Marker(
              point: LatLng(shop.latitude, shop.longitude),
              width: 40.0,
              height: 40.0,
              child: GestureDetector(
                onTap: () {
                  log.fine("Marker clicked on shop with id ${shop.id}");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopPage(shop: shop)));
                },
                child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(20)),
                    child: Icon(Icons.storefront_rounded,
                        color: Theme.of(context).colorScheme.onSecondary)),
              )),
        );
        log.info("Created shop marker.");
        notifyListeners();
      }
    }

    log.fine("Shopmarker length: ${shopMarker.length}");
    log.info("Finished creating shop markers.");
  }

  Future<Coordinates> _getCoordinatesOfAddress(String address) async {
    GeoCode geoCode = GeoCode();
    try {
      Coordinates coordinates =
          await geoCode.forwardGeocoding(address: address);
      return coordinates;
    } catch (e) {
      log.warning('Warning: Geocoding-Fehler für $address: $e');
    }
    return Coordinates(latitude: 0, longitude: 0);
  }
}
