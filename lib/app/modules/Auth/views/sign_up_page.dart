import 'package:assessment_task/app/modules/Auth/controllers/auth_controller.dart';
import 'package:assessment_task/app/modules/Auth/views/Sign_in_page.dart';
import 'package:assessment_task/app/modules/constants.dart';
import 'package:assessment_task/app/modules/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

late GlobalKey<FormState> _formKey;

class _SignUpPageState extends State<SignUpPage> {
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                height: getProportionateScreenHeight(500),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(children: [
                  const Spacer(),
                  Form(
                    key: _formKey,
                    child: Column(children: [
                      InputField(hint: 'Email'),
                      const SizedBox(height: 20),
                      InputField(hint: 'Password', obscure: true)
                    ]),
                  ),
                  const Spacer(),
                  GetBuilder<AuthController>(builder: (_auth) {
                    return InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _auth.registerWithEmailAndPassword(
                              _auth.email.value, _auth.password.value);
                        }
                      },
                      child: Buttons(
                        fillColor: kPrimaryColor,
                        child: Center(
                            child: Text('Register Account',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25))),
                      ),
                    );
                  }),
                  const Spacer(flex: 3),
                  Buttons(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/Logo.png'),
                          const SizedBox(width: 10),
                          Text('Register with Gmail',
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22))
                        ]),
                    borderColor: kPrimaryColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an Account? ',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),
                      TextButton(
                        onPressed: () {
                          Get.to(() => SignInPage());
                        },
                        child: Text('Login in',
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 18,
                                fontWeight: FontWeight.w800)),
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
