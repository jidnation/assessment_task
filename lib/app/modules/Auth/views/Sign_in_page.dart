import 'package:assessment_task/app/modules/Auth/controllers/auth_controller.dart';
import 'package:assessment_task/app/modules/Auth/views/reset_password.dart';
import 'package:assessment_task/app/modules/Auth/views/sign_up_page.dart';
import 'package:assessment_task/app/modules/constants.dart';
import 'package:assessment_task/app/modules/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

late GlobalKey<FormState> _formKey;

class _SignInPageState extends State<SignInPage> {
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
                height: getProportionateScreenHeight(600),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(flex: 3),
                        InputField(hint: 'Email'),
                        const SizedBox(height: 20),
                        InputField(hint: 'Password', obscure: true),
                        const Spacer(flex: 2),
                        GetBuilder<AuthController>(builder: (_auth) {
                          return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _auth.signInWithEmailAndPassword(
                                    _auth.email.value, _auth.password.value);
                              }
                            },
                            child: Text('Log In',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25)),
                            style: TextButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                                minimumSize:
                                    Size(getProportionateScreenWidth(310), 45),
                                elevation: 0),
                          );
                        }),
                        const Spacer(),
                        Row(children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              width: SizeConfig.screenWidth * 0.20,
                              height: 1,
                              color: Colors.grey,
                            ),
                          ),
                          Text('Or login with',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400)),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 8),
                              width: SizeConfig.screenWidth * 0.20,
                              height: 1,
                              color: Colors.grey,
                            ),
                          ),
                        ]),
                        const Spacer(),
                        GetBuilder<AuthController>(builder: (_auth) {
                          return InkWell(
                            onTap: () {
                              _auth.gmailSignIn();
                            },
                            child: Buttons(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/Logo.png'),
                                    const SizedBox(width: 10),
                                    Text('Login with Google',
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22))
                                  ]),
                              borderColor: kPrimaryColor,
                            ),
                          );
                        }),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Get.to(() => ResetPage());
                            },
                            child: Column(children: [
                              Text('Forget your password?',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      letterSpacing: 0.2,
                                      fontWeight: FontWeight.w700)),
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                height: 1.5,
                                color: Colors.grey.shade300,
                                width: 132,
                              )
                            ])),
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
          ),
        )));
  }
}
