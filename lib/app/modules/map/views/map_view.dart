import 'dart:async';

import 'package:assessment_task/app/modules/map/controllers/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  @override
  State<MapView> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller = Completer();

  static final LatLng userCurrentPosition =
      Get.find<MapController>().location.value;
  final CameraPosition _kGooglePlex = CameraPosition(
    target: userCurrentPosition,
    zoom: 17.546,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //This widget render the google map to the screen
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
      ),
    );
  }
}
