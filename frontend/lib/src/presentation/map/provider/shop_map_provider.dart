import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/utils/utils.dart';
import 'package:latlong2/latlong.dart';
import 'package:logging/logging.dart';

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
}
