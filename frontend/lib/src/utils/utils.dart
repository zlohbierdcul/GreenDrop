import 'dart:math';

import 'package:geocode/geocode.dart' as geocode;
import 'package:greendrop/src/domain/models/address.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:logging/logging.dart';

Logger logger = Logger("utils");

int sortAddresses(Address a, Address b) {
  final aPrimary = a.isPrimary ?? false;
  final bPrimary = b.isPrimary ?? false;
  if (bPrimary && !aPrimary) return 1;
  if (aPrimary && !bPrimary) return -1;
  return 0;
}

Future<bool> checkInRange(Address a, Shop s) async {
  double distance;
  try {
    geocode.Coordinates aCoordinates =
        await getCoordinatesOfAddress(a.toString());

    distance = calculateDistance(
        aCoordinates.latitude, aCoordinates.longitude, s.latitude, s.longitude);
  } catch (_) {
    return false;
  }

  return distance <= s.radius;
}

Future<geocode.Coordinates> getCoordinatesOfAddress(String address) async {
  geocode.GeoCode geoCode = geocode.GeoCode();
  try {
    geocode.Coordinates coordinates =
        await geoCode.forwardGeocoding(address: address.toString());
    return coordinates;
  } catch (_) {
    logger.warning("getCoordinatesOfAddress - geocoding failed!");
  }
  return geocode.Coordinates(latitude: 0, longitude: 0);
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}
