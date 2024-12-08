import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:greendrop/src/domain/models/shop.dart';
import 'package:greendrop/src/presentation/map/provider/shop_map_provider.dart';
import 'package:greendrop/src/presentation/map/widgets/shop_map_details.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class ShopMap extends StatelessWidget {
  final List<Shop> shops;
  const ShopMap({super.key, required this.shops});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ShopMapProvider>(context, listen: false)
          .initializeMap(shops, context);
    });
    return Consumer<ShopMapProvider>(
      builder: (context, shopMapProvider, child) => Scaffold(
        body: shopMapProvider.shops.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : FlutterMap(
                mapController: shopMapProvider.mapController,
                options: MapOptions(
                  initialCenter: LatLng(shopMapProvider.latitudePerson,
                      shopMapProvider.longitudePerson),
                  initialZoom: 14,
                  interactionOptions: const InteractionOptions(
                      flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag | InteractiveFlag.doubleTapZoom),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(
                      markers: _createMarkerList(shopMapProvider, context)),
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
                ],
              ),
      ),
    );
  }

  List<Marker> _createMarkerList(shopMapProvider, BuildContext context) {
    return [
      Marker(
        point: LatLng(
            shopMapProvider.latitudePerson, shopMapProvider.longitudePerson),
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
      ...shops.map((Shop shop) {
        final focused = shop == shopMapProvider.focusedShop;
        return Marker(
            point: LatLng(shop.latitude, shop.longitude),
            width: focused ? 400 : 40,
            height: focused ? 300 : 40,
            child: GestureDetector(
                onTap: () {
                  shopMapProvider.handleShopTap(shop);
                },
                child: shopMapProvider.isZoomedIn
                    ? ShopMapDetails(shop: shop)
                    : Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(20)),
                        child: Icon(Icons.storefront_rounded,
                            color:
                                Theme.of(context).colorScheme.onSecondary))));
      })
    ];
  }
}
