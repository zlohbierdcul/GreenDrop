import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:greendrop/src/presentation/common_widgets/app_drawer.dart';
import 'package:greendrop/src/presentation/order/provider/order_provider.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:greendrop/src/presentation/map/provider/shop_map_provider.dart';

class TrackingMap extends StatelessWidget {
  const TrackingMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDrawer.buildGreendropsAppBar(context),
      body: Consumer2<ShopMapProvider, OrderProvider>(
        builder: (context, shopMapProvider, orderProvider, child) {
          return FutureBuilder<List<LatLng>>(
            future: shopMapProvider.fetchRoute(shop: orderProvider.order!.shop),
            builder: (context, snapshot) {
              List<LatLng> polylinePoints = snapshot.data ?? [];

              return FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(
                    (shopMapProvider.latitudePerson +
                        orderProvider.order!.shop.latitude) /
                        2,
                    (shopMapProvider.longitudePerson +
                        orderProvider.order!.shop.longitude) /
                        2,
                  ),
                  initialZoom: 14,
                  onTap: (_, __) => shopMapProvider.setIsZoomedIn(false),
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(
                    markers: _buildMarkers(shopMapProvider),
                  ),
                  if (polylinePoints.isNotEmpty)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: polylinePoints,
                          strokeWidth: 4.0,
                          color: Colors.green,
                        ),
                      ],
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  List<Marker> _buildMarkers(ShopMapProvider shopMapProvider) {
    List<Marker> markers = [];
    print("ich bin in build Marker");
    // Marker für den Benutzer
    markers.add(
      Marker(
        point: LatLng(
          shopMapProvider.latitudePerson,
          shopMapProvider.longitudePerson,
        ),
        child: const Icon(
          Icons.my_location,
          color: Colors.red,
          size: 30,
        ),
      ),
    );

    // Marker für die Geschäfte
    for (var shop in shopMapProvider.shops) {
      markers.add(
        Marker(
          point: LatLng(shop.latitude, shop.longitude),
          child: GestureDetector(
            onTap: () => shopMapProvider.handleShopTap(shop),
            child: const Icon(
              Icons.store,
              color: Colors.green,
              size: 30,
            ),
          ),
        ),
      );
    }

    return markers;
  }
}
