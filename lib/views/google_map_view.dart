import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/item_model.dart';
import '../utils/app_colors.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({required this.itemData});

  final ItemBean itemData;

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  GoogleMapController? mapController;
  BitmapDescriptor? customMarker;
  final List<Marker> _markers = [];
  final Completer<GoogleMapController> _mapController = Completer();

  @override
  void initState() {
    super.initState();
    createMarkers();
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
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: GoogleMap(
          myLocationEnabled: true,
          mapType: MapType.normal,
          compassEnabled: false,
          zoomControlsEnabled: false,
          zoomGesturesEnabled: true,
          scrollGesturesEnabled: true,
          rotateGesturesEnabled: true,
          onMapCreated: _onMapCreated,
          markers: Set.from(_markers),
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            Factory<OneSequenceGestureRecognizer>(
              () => EagerGestureRecognizer(),
            ),
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(double.parse(widget.itemData.latitude!),
                double.parse(widget.itemData.longitude!)),
            zoom: 7.9,
          ),
        ));
  }

  createMarkers() async {
    customMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
        devicePixelRatio: 50,
      ),
      'assets/images/ic_marker.png',
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    _mapController.complete(controller);
    setState(() {
      _markers.add(Marker(
          draggable: false,
          markerId: MarkerId(widget.itemData.id.toString()),
          position: LatLng(double.parse(widget.itemData.latitude!),
              double.parse(widget.itemData.longitude!)),
          icon: customMarker!,
          infoWindow: InfoWindow(
            title: widget.itemData.title,
            snippet: widget.itemData.address,
          ),
          onTap: () async {
            final GoogleMapController controller = await _mapController.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                bearing: 0,
                target: LatLng(double.parse(widget.itemData.latitude!),
                    double.parse(widget.itemData.longitude!)),
                zoom: 15,
              ),
            ));
          }));
    });
  }
}
