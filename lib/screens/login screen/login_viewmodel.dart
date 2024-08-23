import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

import '../../constants.dart';
import '../../router.router.dart';
import '../../services/login_services.dart';

class LoginViewmodel extends BaseViewModel{
 final formGlobalKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController urlController = TextEditingController()..text="https://erp.leadconekt.com";
  TextEditingController passwordController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  bool obscurePassword = true;
  bool isLoading = false;
  bool isDemoLoading = false;
  initialise() {}

  void loginwithUsernamePassword(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    baseurl=urlController.text;
    String username = usernameController.text;
    String password = passwordController.text;
    bool res = await LoginServices().login(baseurl,username, password);
    isLoading = false;
    notifyListeners();
    if (res) {
      if (context.mounted) {
        Navigator.popAndPushNamed(context, Routes.bottomNavigationScreen);
      }
    } else {
      Logger().i('invalid credential');
    //   Fluttertoast.showToast(
    //       msg: "Invalid Credentials",
    //       toastLength: Toast.LENGTH_LONG,
    //       backgroundColor: Colors.white,
    //       textColor: Colors.black,
    //       fontSize: 16.0);
    }
  }
   String? validateUsername(username) {
    if (username.toString().isEmpty) {
      return "Enter a valid username";
    }
    return null;
  }

  String? validatePassword(password) {
    if (password.toString().isEmpty) {
      return "Enter a Password";
    }
    return null;
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}
