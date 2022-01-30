import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// late GoogleMapController userController;
//
// class MapView extends GetView<MapController> {
//   void _onMapCreated(GoogleMapController controller) {
//     userController = controller;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Completer<GoogleMapController> _controller = Completer();
//
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: kPrimaryColor,
//           title: Text('User\'s  Location'),
//           centerTitle: true,
//           actions: [
//             Center(
//               child: GetBuilder<AuthController>(
//                   init: AuthController(),
//                   builder: (_auth) {
//                     return Padding(
//                       padding: const EdgeInsets.only(right: 15),
//                       child: InkWell(
//                           onTap: () {
//                             _auth.signOut();
//                           },
//                           child: FaIcon(
//                             FontAwesomeIcons.signOutAlt,
//                             color: Colors.white,
//                           )),
//                     );
//                   }),
//             )
//           ],
//         ),
//         body: Column(children: [
//           Expanded(child: GetBuilder<MapController>(builder: (mapping) {
//             var lat = mapping.lat.value;
//             var lng = mapping.lng.value;
//             final CameraPosition userPosition =
//                 CameraPosition(target: LatLng(lat, lng), zoom: 11.5);
//             return GoogleMap(
//               initialCameraPosition: userPosition,
//               mapType: MapType.normal,
//               onMapCreated: _onMapCreated,
//             );
//           }))
//         ]));
//   }
// }
class MapView extends StatefulWidget {
  @override
  State<MapView> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller = Completer();
  static var position = Get.arguments;
  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(position.latitude, position.longitude),
    zoom: 16.4746,
  );
  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    print('from argument: ${position.latitude}');
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: Text('To the lake!'),
      //   icon: Icon(Icons.directions_boat),
      // ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}
