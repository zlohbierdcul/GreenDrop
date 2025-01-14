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
      appBar: AppDrawer.buildGreendropsAppBar(context, automaticallyImplayLeading: false),
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
                  MarkerLayer(
                    markers: _buildMarkers(context, shopMapProvider, orderProvider),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(10),
                              elevation: 5),
                          onPressed: () => shopMapProvider.resetZoom(),
                          child: const Icon(Icons.near_me)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, "/home"),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            "Zurück zur Startseite",
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  List<Marker> _buildMarkers(BuildContext context, ShopMapProvider shopMapProvider, OrderProvider orderProvider) {
    List<Marker> markers = [];
    // Marker für den Benutzer
    markers.add(
      Marker(
        point: LatLng(
          shopMapProvider.latitudePerson,
          shopMapProvider.longitudePerson,
        ),
        child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.location_pin,
            color: Theme.of(context).colorScheme.onSecondary),
      ),
    ));

    // Marker für die Geschäfte
      markers.add(
        Marker(
          point: LatLng(orderProvider.order!.shop.latitude, orderProvider.order!.shop.longitude),
          child: GestureDetector(
            onTap: () => shopMapProvider.handleShopTap(orderProvider.order!.shop),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(20)),
              child: Icon(Icons.storefront_rounded,
                color:
                Theme.of(context).colorScheme.onSecondary),
          ),
        ),
      ));
    return markers;
  }
}
