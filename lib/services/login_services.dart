import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginServices {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> login(String url,String username, String password) async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var data = {'usr': username, 'pwd': password};
    var dio = Dio();

    try {
      var response = await dio.request(
        '$url/api/method/lead_chain.mobile.main.login',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        final SharedPreferences prefs = await _prefs;
        Logger().i(response.data.toString());
        prefs.setString("url", url);
        prefs.setString("api_secret",
            response.data["key_details"]["api_secret"].toString());
        prefs.setString(
            "api_key", response.data["key_details"]["api_key"].toString());
        prefs.setString("user", response.data["user"].toString());
        Logger().i(prefs.getString('api_secret'));
         Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Logged in successfully',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color.fromARGB(255, 26, 186, 82),);
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: '${e.response?.data["message"].toString()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e.response?.data.toString());
      return false;
    }

  }
}
