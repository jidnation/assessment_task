import 'dart:async';

import 'package:assessment_task/app/modules/Auth/controllers/auth_controller.dart';
import 'package:assessment_task/app/modules/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/map_controller.dart';

late GoogleMapController userController;

class MapView extends GetView<MapController> {
  void _onMapCreated(GoogleMapController controller) {
    userController = controller;
  }

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('User\'s  Location'),
          centerTitle: true,
          actions: [
            Center(
              child: GetBuilder<AuthController>(
                  init: AuthController(),
                  builder: (_auth) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: InkWell(
                          onTap: () {
                            _auth.signOut();
                          },
                          child: FaIcon(
                            FontAwesomeIcons.signOutAlt,
                            color: Colors.white,
                          )),
                    );
                  }),
            )
          ],
        ),
        body: Column(children: [
          Expanded(child: GetBuilder<MapController>(builder: (mapping) {
            var lat = mapping.lat.value;
            var lng = mapping.lng.value;
            final CameraPosition userPosition =
                CameraPosition(target: LatLng(lat, lng), zoom: 11.5);
            return GoogleMap(
              initialCameraPosition: userPosition,
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
            );
          }))
        ]));
  }
}
