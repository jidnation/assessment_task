import 'package:assessment_task/app/modules/Auth/views/Sign_in_page.dart';
import 'package:assessment_task/app/modules/constants.dart';
import 'package:assessment_task/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/wrapper_controller.dart';

class WrapperView extends GetView<WrapperController> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    //This is the initial page, that navigate based on the stored user value
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: GetX<WrapperController>(
          init: WrapperController(),
          builder: (_wrapper) {
            final _userId = _wrapper.currentUser.value;
            print('userId: $_userId');
            if (_userId == '') {
              return SignInPage();
            } else {
              return HomeView();
            }
          },
        ));
  }
}
