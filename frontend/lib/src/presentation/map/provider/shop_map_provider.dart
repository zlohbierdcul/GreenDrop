import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/utils/utils.dart';
import 'package:latlong2/latlong.dart';
import 'package:logging/logging.dart';
import 'package:http/http.dart' as http;


class ShopMapProvider extends ChangeNotifier {
  Logger log = Logger("ShopMapProvider");

  bool _isZoomedIn = false;

  Shop? _focusedShop;

  final MapController _mapController = MapController();

  List<Shop> _shops = [];

  double _latitudePerson = 49.492654; // Standardposition
  double _longitudePerson = 8.471250;

  double _previousZoomLevel = 14;
  LatLng _previousCenter = const LatLng(0, 0);

  List<LatLng> _currentRoute = [];

  List<LatLng> get currentRoute => _currentRoute;

  Future<void> loadRouteForShop(Shop shop) async {
    _currentRoute = await fetchRoute(shop: shop);
    notifyListeners();
  }

  MapController get mapController => _mapController;
  double get latitudePerson => _latitudePerson;
  double get longitudePerson => _longitudePerson;
  List<Shop> get shops => _shops;
  bool get isZoomedIn => _isZoomedIn;
  Shop? get focusedShop => _focusedShop;
  bool isLoading = true;

  void setIsZoomedIn(bool v) {
    _isZoomedIn = v;
  }

  void initializeMap(List<Shop> shops, BuildContext context) async {
    _shops = [];
    await _createUserMarker(context);
    _createMapListeners();
    _createShopMarker(shops, context);
  }

  void _createMapListeners() {
    _mapController.mapEventStream.listen(_onMapEvent);
  }

  void _onMapEvent(MapEvent event) {
    double currentZoomLevel = _mapController.camera.zoom;
    LatLng currentCenter = _mapController.camera.center;

    if (currentZoomLevel < _previousZoomLevel ||
        currentCenter != _previousCenter) {
      _onZoomOut();
    }
    _previousCenter = currentCenter;
    _previousZoomLevel = currentZoomLevel;
  }

  void handleShopTap(Shop shop) {
    setIsZoomedIn(true);
    _mapController.move(LatLng(shop.latitude, shop.longitude), 16);
    _previousCenter = _mapController.camera.center;
    _focusedShop = shop;
    notifyListeners();
  }

  void _onZoomOut() {
    _isZoomedIn = false;
    _focusedShop = null;
    notifyListeners();
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

    notifyListeners();
    log.info("Finished creating user marker");
    if (!kIsWeb) FlutterNativeSplash.remove();
  }

  Future<void> _createShopMarker(List<Shop> shops, BuildContext context) async {
    log.info("Creating shop markers.");
    List<Marker> shopMarker = [];
    if (shops.isEmpty) {
      isLoading = false;
    }
    for (var shop in shops) {
      final radius = shop.radius;

      if (shop.latitude == 0 && shop.longitude == 0) {
        Coordinates coordinates =
            await getCoordinatesOfAddress(shop.address.toString());
        shop.latitude = coordinates.latitude ?? 0;
        shop.longitude = coordinates.longitude ?? 0;
      }

      double distance = calculateDistance(
          latitudePerson, shop.latitude, longitudePerson, shop.longitude);
      log.fine("Distance: $distance");
      if (distance <= radius) {
        _shops.add(shop);
        log.info("Created shop marker.");
        notifyListeners();
      }
    }

    log.fine("Shopmarker length: ${shopMarker.length}");
    log.info("Finished creating shop markers.");
  }

  resetZoom() {
    _mapController.move(LatLng(_latitudePerson, _longitudePerson), 14);
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
  // getting the route from shop to user location
  Future<List<LatLng>> fetchRoute({required Shop shop}) async {
    LatLng start = LatLng(_latitudePerson, _longitudePerson);
    LatLng end = LatLng(shop.latitude, shop.longitude);
    final url =
        'http://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?overview=full&geometries=polyline';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final geometry = data['routes'][0]['geometry'];
      final List<LatLng> route = decodePolyline(geometry);
      return route;
    } else {
      throw Exception('Failed to load route');
    }
  }
  // the line from shop to user location
  List<LatLng> decodePolyline(String encodedPolyline) {
    List<LatLng> polyline = [];
    int index = 0;
    int len = encodedPolyline.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int shift = 0;
      int result = 0;
      int byte;
      do {
        byte = encodedPolyline.codeUnitAt(index) - 63;
        result |= (byte & 0x1f) << shift;
        shift += 5;
        index++;
      } while (byte >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        byte = encodedPolyline.codeUnitAt(index) - 63;
        result |= (byte & 0x1f) << shift;
        shift += 5;
        index++;
      } while (byte >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      polyline.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return polyline;
  }
}
