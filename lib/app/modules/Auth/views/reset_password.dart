import 'package:assessment_task/app/modules/Auth/controllers/auth_controller.dart';
import 'package:assessment_task/app/modules/Auth/views/sign_up_page.dart';
import 'package:assessment_task/app/modules/constants.dart';
import 'package:assessment_task/app/modules/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final signinKey = GlobalKey<FormState>();

class ResetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: SafeArea(
            child: SingleChildScrollView(
          child: SizedBox(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                width: getProportionateScreenWidth(340),
                height: getProportionateScreenHeight(350),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(children: [
                  const Spacer(),
                  Form(
                    key: signinKey,
                    child: InputField(hint: 'Email'),
                  ),
                  const Spacer(flex: 2),
                  GetBuilder<AuthController>(builder: (_auth) {
                    return InkWell(
                        onTap: () {
                          if (signinKey.currentState!.validate()) {
                            _auth.passwordReset();
                          }
                        },
                        child: Buttons(
                            fillColor: kPrimaryColor,
                            child: Center(
                                child: Text('Reset Password',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25)))));
                  }),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Don\'t have account?',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),
                      TextButton(
                        onPressed: () {
                          Get.to(() => SignUpPage());
                        },
                        child: Text('Sign Up',
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                  const Spacer()
                ]),
              ),
            ),
          ),
        )));
  }
}
