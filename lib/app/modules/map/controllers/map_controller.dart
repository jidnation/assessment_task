import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  /// Determine the current position of the device.
  ///
  /// I maked some variable static so that they will visible from other pages

  final Rx<LatLng> location = LatLng(0, 0).obs;
  final Rx<Position> userPosition = Position(
          longitude: 0,
          latitude: 0,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0)
      .obs;
  // final Rx<CameraPosition> userLocation =
  //     CameraPosition(target: location.value).obs;

  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.

  Future<Position> getPosition() async {
    bool isServiceEnabled;
    LocationPermission permission;

    /*    TESTING MAYBE THE SERVICE IS ENABLED     */
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      ///CHECKING CURRENT STATUS
      Get.snackbar('NOTICE', 'Enable your gprs location to use this feature',
          colorText: Colors.amber);
    }

/*    REQUESTING THE USER ACCESS    */
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again
        Get.snackbar('NOTICE', 'Permission denied!. ', colorText: Colors.red);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      Get.snackbar(
          'NOTICE',
          'Location permissions are permanently denied, we cannot request permissions\n'
              'Enable app to use this feature',
          colorText: Colors.amber);
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  updateValue() async {
    print('printing 1: ${userPosition.value}, location: ${location.value}');
    userPosition.value = await getPosition();
    location.value =
        LatLng(userPosition.value.latitude, userPosition.value.longitude);
    print('printing 2: ${userPosition.value}, location: ${location.value}');
    update();
  }

  @override
  void onInit() {
    updateValue();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
