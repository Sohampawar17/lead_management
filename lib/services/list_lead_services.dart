import 'dart:convert';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import '../constants.dart';
import '../models/follow_up_list.dart';
import '../models/list_lead_model.dart';


class ListLeadServices{
   Future<List<ListLeadModel>> fetchleadlist() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/lead_chain.mobile.main.cur_current_lead',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<ListLeadModel> caneList = List.from(jsonData['data'])
            .map<ListLeadModel>((data) => ListLeadModel.fromJson(data))
            .toList();
        return caneList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch Lead");
        return [];
      }
    } on DioException catch (e) {
       Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response?.data["message"].toString()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
       Logger().e(e.response?.statusCode.toString());
       return [];
     }
  }



Future<FollowUpListLeadModel?> getfolloeupleadMaster() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var url='$baseurl/api/method/lead_chain.mobile.main.leadList';
      var response = await dio.request(
        url,
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        Logger().i(FollowUpListLeadModel.fromJson(response.data["data"]));
        return FollowUpListLeadModel.fromJson(response.data["data"]);
      } else {
        
        return null;
      }
    }  on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString().split(":").elementAt(1).trim()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return null;
  }

Future<bool> deleteleads(List<String> leaddetails) async {
    baseurl =  await geturl();
      var data =json.encode( {'leads': leaddetails,});
    try {
      var url=  '$baseurl/api/method/lead_chain.mobile.main.deleteBulkLead';
      Logger().i(url);
      var dio = Dio();
      var response = await dio.request(
        url,
        options: Options(
          method: 'DELETE',
          headers: {'Authorization': await getTocken()},
        ),
       data: data
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: response.data['message'].toString());
        return true;
      } else {
       
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["message"].toString()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e.response!.data["message"].toString());
    }
    return false;
  }

  
Future<bool> changeFollowUp(List<String> leaddetails,String? followUpStatus,String? followUpTime) async {
    baseurl =  await geturl();
      var data =json.encode( {'leads': leaddetails,"followUpStatus":followUpStatus,"followUpTime":followUpTime});
    try {
      var url=  '$baseurl/api/method/lead_chain.mobile.main.followUpStatusBulkLead';
      Logger().i(url);
      var dio = Dio();
      var response = await dio.request(
        url,
        options: Options(
          method: 'DELETE',
          headers: {'Authorization': await getTocken()},
        ),
       data: data
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: response.data['message'].toString());
        return true;
      } else {
       
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["message"].toString()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e.response!.data["message"].toString());
    }
    return false;
  }
}