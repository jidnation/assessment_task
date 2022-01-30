import 'package:assessment_task/app/modules/Auth/controllers/auth_controller.dart';
import 'package:assessment_task/app/modules/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('HomeView'),
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
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          Get.toNamed('/map');
        },
        child: Text(' Get your Location'),
      )),
    );
  }
}
