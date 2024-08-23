import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import '../constants.dart';
import '../models/list_member_model.dart';

class ListMemberServices {
  Future<List<MemberList>> fetchmemberlist() async {
      baseurl =  await geturl();
      var url= apilistmember;
      Logger().i(apilistmember);
    try {
      var dio = Dio();
      var response = await dio.request(
       url,
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<MemberList> caneList = List.from(jsonData['data'])
            .map<MemberList>((data) => MemberList.fromJson(data))
            .toList();
            
        return caneList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch Members");
        return [];
      }
    } on DioException catch (e) {
      Logger().e(e);
      Fluttertoast.showToast(msg: e.response?.data['exception']);
      return [];
    }
  }
   Future<bool> deleteMember(String id) async {
    baseurl =  await geturl();
    var url= '$baseurl/api/resource/Employee Master/$id';
    Logger().i(url);
    try {
      var dio = Dio();
      var response = await dio.request(
       url,
        options: Options(
          method: 'DELETE',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Member Deleted successfully");
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO update Lead!");
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString().split(":").elementAt(1).trim()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e.response!.data["exception"].toString());
    }
    return false;
  }
}
