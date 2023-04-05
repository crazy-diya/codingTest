import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/item_model.dart';
import '../../utils/app_colors.dart';

class MapView extends StatefulWidget {
  const MapView({required this.itemData});

  final ItemDataBean itemData;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.satellite;
  bool traffic = false;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    _markers.clear();
    _markers.add(
      Marker(
        icon: BitmapDescriptor.defaultMarker,
        markerId: MarkerId(
          widget.itemData.id.toString(),
        ),
        position: LatLng(
          double.parse(widget.itemData.latitude!),
          double.parse(widget.itemData.longitude!),
        ),
        infoWindow: InfoWindow(
          title: widget.itemData.title,
          snippet: widget.itemData.description,
          onTap: () {},
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Map",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
        backgroundColor: AppColors.secondaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            padding: const EdgeInsets.only(
              top: 40.0,
            ),
            trafficEnabled: traffic,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            mapToolbarEnabled: true,
            compassEnabled: true,
            liteModeEnabled: false,
            buildingsEnabled: true,
            indoorViewEnabled: true,
            tiltGesturesEnabled: true,
            mapType: mapType,
            markers: _markers,
            onMapCreated: (mapController) {
              _controller.complete(mapController);
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(
                double.parse(widget.itemData.latitude!),
                double.parse(
                  widget.itemData.longitude!,
                ),
              ),
              zoom: 8,
            ),
            onTap: (latLon) async {},
          ),
          Positioned(
            left: 8,
            bottom: 14,
            child: Wrap(
              direction: Axis.vertical,
              verticalDirection: VerticalDirection.up,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.satellite,
                    color: Colors.green,
                    semanticLabel: "satellite",
                  ),
                  tooltip: "satellite",
                  onPressed: () {
                    setState(() {
                      mapType = MapType.satellite;
                    });
                  },
                ),
                IconButton(
                  tooltip: "terrain",
                  icon: const Icon(
                    Icons.terrain,
                    color: Colors.grey,
                    semanticLabel: "terrain",
                  ),
                  onPressed: () {
                    setState(() {
                      mapType = MapType.terrain;
                    });
                  },
                ),
                IconButton(
                  tooltip: "hybrid",
                  icon: const Icon(
                    Icons.panorama,
                    color: Colors.blueGrey,
                    semanticLabel: "hybrid",
                  ),
                  onPressed: () {
                    setState(() {
                      mapType = MapType.hybrid;
                    });
                  },
                ),
                IconButton(
                  tooltip: "traffic",
                  icon: Icon(
                    Icons.traffic,
                    color: traffic == true ? Colors.red : Colors.blueGrey,
                    semanticLabel: "traffic",
                  ),
                  onPressed: () {
                    setState(() {
                      traffic = !traffic;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
