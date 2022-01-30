import 'package:assessment_task/app/modules/map/controllers/map_controller.dart';
import 'package:assessment_task/app/modules/wrapper/controllers/wrapper_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  //Initializing the firebase Authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxString email = ''.obs;
  final RxString password = ''.obs;

  /*    REGISTERING USERS WITH EMAIL AND PASSWORD    */
  Future registerWithEmailAndPassword(
      String emailValue, String passwordValue) async {
    try {
      UserCredential response = await _auth.createUserWithEmailAndPassword(
          email: emailValue, password: passwordValue);
      User? _user = response.user;
      Get.snackbar(
          'SignUp Status', 'Registration Successful.\nYou can now login In',
          colorText: Colors.green, duration: Duration(seconds: 7));
      Get.find<WrapperController>().setUser(_user!.uid);
      update();
    } catch (e) {
      Get.snackbar('SignUp Status', 'Registration Failed',
          colorText: Color(0xfff74e35));
      update();
      return null;
    }
  }

  /*     SIGN IN USER WITH EMAIL AND PASSWORD   */
  Future signInWithEmailAndPassword(
      String emailValue, String passwordValue) async {
    try {
      UserCredential response = await _auth.signInWithEmailAndPassword(
          email: emailValue, password: passwordValue);
      User? _user = response.user;
      Get.snackbar('Login Status', 'Login Successful', colorText: Colors.green);
      Get.find<WrapperController>().setUser(_user!.uid);
      Get.put(MapController()).getPosition;
      print(' from signin: ${Get.find<MapController>().currentPosition}');
      update();
    } catch (e) {
      Get.snackbar('Login Status', 'Login Failed', colorText: Colors.red);
      update();
      return null;
    }
  }

  /*      USER SIGNING OUT    */
  Future signOut() async {
    try {
      Get.snackbar('status', 'SignOut Successful',
          snackPosition: SnackPosition.BOTTOM);
      await _auth.signOut();
      Get.put(WrapperController()).setUser('');
      Get.toNamed('./wrapper');
    } catch (e) {
      Get.snackbar('Status', 'Signing Out Failed',
          snackPosition: SnackPosition.BOTTOM);
      update();
    }
  }

  /*              TO RESET A PASSWORD USING EMAIL       */
  passwordReset() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.sendPasswordResetEmail(email: email.value);
      Get.snackbar('Message', 'Email sent');
      Get.toNamed('./home');
    } catch (e) {
      Get.snackbar('Message', e.toString());
    }
  }

/*              TO SIGN IN  USING GMAIL  ACCOUNT      */
  gmailSignIn() async {
    final google = GoogleSignIn();
    GoogleSignInAccount? user;

    try {
      final googleMethod = await google.signIn();
      user = googleMethod;
      final auth = await googleMethod!.authentication;
      final cred = GoogleAuthProvider.credential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(cred).whenComplete(() {
        Get.find<WrapperController>().setUser(user!.displayName.toString());
        Get.put(MapController()).getPosition;
        Get.offAndToNamed('./map');
        print(user.email.toString());
        print(user.displayName.toString());
        print(user.photoUrl.toString());
      });
      Get.snackbar('Login Status', 'Login Successful', colorText: Colors.green);
      Get.offAndToNamed('./map');
    } catch (e) {
      print(e.toString());
    }
  }

  /*    VALIDATING USERS INPUT    */
  String? emailValidator(String? val) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@+[a-zA-Z0-9]+\.[a-zA-Z]")
        .hasMatch(email.value.toString());
    return (!emailValid) ? "Invalid Email" : null;
  }

  String? passwordValidator(String? value) {
    if (password.value.isEmpty || password.value == '') {
      return 'Provide a valid password';
    } else {
      if (password.value.length < 8) {
        return 'password too weak.';
      }
      return null;
    }
  }
}
