import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

import '../constants.dart';
import '../models/add_page_sheet_model.dart';

class AddPageSheetServices{

  Future<List<String>> fetchUsers() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/User?limit_page_length=99',
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
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch users");
        return [];
      }
    } on DioException catch (e) {
      Logger().i(e.response?.data["exception"]);
      Fluttertoast.showToast(msg: e.response?.data["exception"]);
    }
    return [];
  }
   Future<bool> addPageSheet(AddPageSheetModel pageSheet) async {
    var data = json.encode({
      "data": pageSheet,
    });

    try {
      var dio = Dio();
      var response = await dio.request(
         '$baseurl/api/resource/Page Sheet',
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Page Sheet Added Successfully");
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO Page Sheet!");
        return false;
      }
     } on DioException catch (e) {
      Logger().i(e.response?.data["exception"]);
      Fluttertoast.showToast(msg: e.response?.data["exception"]);
    }
    return false;
  }

  Future<bool> updatePageSheet(AddPageSheetModel pageSheets) async {
    var data = json.encode({
      "data": pageSheets,
    });

    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Page Sheet/${pageSheets.name.toString()}',
        options: Options(
          method: 'PUT',
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Sheet updated Successfully");
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO update Team Member!");
        return false;
      }
     } on DioException catch (e) {
      Logger().i(e.response?.data["exception"]);
      Fluttertoast.showToast(msg: e.response?.data["exception"]);
    }
    return false;
  }

  Future<AddPageSheetModel?> getmember(String id) async {
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Page Sheet/$id',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        Logger().i(response.data["data"]);
        return AddPageSheetModel.fromJson(response.data["data"]);
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

}