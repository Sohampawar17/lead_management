import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

import '../constants.dart';
import '../models/add_lead_model.dart';
import '../models/lead_master_model.dart';

class UpdateLeadServices{
    Future<List<Notes>> getnotes(String leadname) async {
    baseurl =  await geturl();
    var data = {'doc_name': leadname};
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/lead_chain.mobile.main.get_data_from_notes',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<Notes> caneList = List.from(jsonData['message'])
            .map<Notes>((data) => Notes.fromJson(data))
            .toList();
        return caneList;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO get notes!");
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response?.data["message"].toString()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e.response!.data["message"].toString());
    }
    return [];
  }


  
    Future<bool> deletenotes(String leadname,int index) async {
    baseurl =  await geturl();
    var data = {'doc_name': leadname,'row_id':index.toString()};

    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/lead_chain.mobile.main.delete_note_in_lead',
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
   
   Logger().i(response.data["data"].toString());
   Fluttertoast.showToast(msg: response.data["message"].toString());
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO delete notes!");
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["message"].toString().split(":").elementAt(1).trim()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return false;
  }

  
    Future<bool> addnotes(String? leadname,dynamic note,String? activityType) async {
    baseurl =  await geturl();
    var data = {'doc_name': leadname,'note':note,"activity":activityType};
Logger().i(data);
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/lead_chain.mobile.main.add_note_in_lead',
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
    Logger().i(response.data["message"]);
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO add notes!");
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response?.data["message"].toString().split(":").elementAt(1).trim()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e.response?.data);
    }
    return false;
  }

   Future<bool> update(AddLeadModel model) async {
    baseurl =  await geturl();
    Logger().i(model.toJson());
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Lead/${model.name}',
        options: Options(
          method: 'PUT',
          headers: {'Authorization': await getTocken()},
        ),
        data: model.toJson(),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO change status!");
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["message"].toString()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e.response?.data);
    }
    return false;
  }


 Future<bool> assign(List<Users> users, String? name) async {
  String baseUrl = await geturl();
  try {
    var dio = Dio();
    // Convert the list of users to a formatted string
    String userListString = users.map((user) => '"${user.name}"').join(',');
    
    Logger().i(userListString);
    var url = '$baseUrl/api/method/lead_chain.mobile.main.assignTo?name=$name&assign_list=[$userListString]';
    Logger().i(url);
    
    var response = await dio.request(
      url,
      options: Options(
        method: 'POST',
        headers: {'Authorization': await getTocken()},
      ),
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: response.data['message']);
      return true;
    } else {
      Fluttertoast.showToast(msg: "UNABLE TO change status!");
      return false;
    }
  } on DioException catch (e) {
    Fluttertoast.showToast(
      gravity: ToastGravity.BOTTOM,
      msg: 'Error: ${e.response!.data["message"].toString()}',
      textColor: const Color(0xFFFFFFFF),
      backgroundColor: const Color(0xFFBA1A1A),
    );
    Logger().e(e.response?.data);
    return false;
  }
}

 Future<LeadMasters?> getleadMaster(String? id) async {
    baseurl =  await geturl();
    var url= '$baseurl/api/method/lead_chain.mobile.main.get_lead_masters?name=$id';
    Logger().i(url);
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
        Logger().i(AddLeadModel.fromJson(response.data["data"]));
        return LeadMasters.fromJson(response.data["data"]);
      } else {
        
        return null;
      }
    }  on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString().split(":").elementAt(1).trim()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return null;
  }



  Future<bool> deleteLead(String id) async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Lead/$id',
        options: Options(
          method: 'DELETE',
          headers: {'Authorization': await getTocken()},
        ),
       
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Lead Updated successfully");
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO update Lead!");
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString().split(":").elementAt(1).trim()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return false;
  }

  Future<bool> createTemplate(String templateName,String templateMessage) async {
    baseurl =  await geturl();
    var data=json.encode({
"template_name":templateName,
"message":templateMessage
    });
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/whatsapp message',
        options: Options(
          method: 'POST',
          headers: {'Authorization': await getTocken()},
        ),
       data: data
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Template Added Successfully");
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO create template!");
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(gravity:ToastGravity.BOTTOM,msg: 'Error: ${e.response!.data["exception"].toString().split(":").elementAt(1).trim()} ',textColor:const Color(0xFFFFFFFF),backgroundColor: const Color(0xFFBA1A1A),);
      Logger().e(e);
    }
    return false;
  }
}