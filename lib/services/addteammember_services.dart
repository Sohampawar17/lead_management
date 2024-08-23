import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

import '../constants.dart';
import '../models/team_member_model.dart';

class AddMemberServices {
  Future<bool> addMember(Team_member member) async {
    var data = json.encode({
      "data": member,
    });

    try {
      var dio = Dio();
      var response = await dio.request(
        apimember,
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Team Member Added Successfully");
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO Employee Master!");
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error accoured $e ");
      Logger().e(e);
    }
    return false;
  }

  Future<bool> updateMember(Team_member member) async {
    var data = json.encode({
      "data": member,
    });

    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Employee Master/${member.name.toString()}',
        options: Options(
          method: 'PUT',
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Team Member updated Successfully");
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO update Team Member!");
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error accoured $e ");
      Logger().e(e);
    }
    return false;
  }

  Future<Team_member?> getmember(String id) async {
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Employee Master/$id',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        Logger().i(response.data["data"]);
        return Team_member.fromJson(response.data["data"]);
      } else {
        // print(response.statusMessage);
        return null;
      }
    } on DioException catch (e) {
      Logger().i(e.response?.data["exception"]);
      Fluttertoast.showToast(msg: "Error while fetching member");
    }
    return null;
  }

  Future<List<String>> fetchrole() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        apiroleprofile,
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = json.encode(response.data);
        Map<String, dynamic> jsonDataMap = json.decode(jsonData);
        List<dynamic> dataList = jsonDataMap["data"];
        Logger().i(dataList);
        List<String> namesList =
            dataList.map((item) => item["name"].toString()).toList();
        return namesList;
      }

      if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: "Unauthorized Access!");
        return ["401"];
      } else {
        Fluttertoast.showToast(msg: "Unable to Designations");
        return [];
      }
    } on DioException catch (e) {
      Logger().e(e.response?.data['exception']);
      Fluttertoast.showToast(msg: "Unauthorized Access!");
      return [];
    }
  }
}
