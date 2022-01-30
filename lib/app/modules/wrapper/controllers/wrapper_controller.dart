import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WrapperController extends GetxController {
  //To store the value of currentUser,
  // to save the user from subsequent authentication requirement
  final RxString currentUser = ''.obs;
  late final SharedPreferences _prefs;

  @override
  void onInit() async {
    super.onInit();
    _prefs = await SharedPreferences.getInstance();
    getCurrentUser();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  //This is use to retrieve previous user value,
  // This will return either null/string  based on the previous event
  // (i.e maybe the user log-out or not)
  getCurrentUser() async {
    var _user = _prefs.getString('user');
    currentUser.value = _user.toString();
    print(currentUser.value);
  }

  //Storing the Authorized user value
  setUser(String userValue) async {
    _prefs.setString('user', userValue);
    currentUser.value = userValue;
    print(currentUser.value);
  }
}
