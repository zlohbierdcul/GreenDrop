import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/presentation/map/provider/shop_map_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class ShopMap extends StatelessWidget {
  final List<Shop> shops;
  const ShopMap({super.key, required this.shops});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ShopMapProvider>(context, listen: false).initializeMap(shops, context);
    });
    return Consumer<ShopMapProvider>(
      builder: (context, shopMapProvider, child) => Scaffold(
        body: shopMapProvider.markers.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(shopMapProvider.latitudePerson, shopMapProvider.longitudePerson),
                  initialZoom: 14,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(markers: shopMapProvider.markers),
                ],
              ),
      ),
    );
  }
}
