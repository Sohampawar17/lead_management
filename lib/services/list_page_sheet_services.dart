import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

import '../constants.dart';
import '../models/page_sheet_model.dart';

class ListPageSheetServices{


   Future<List<PageList>> fetchlistPageSheet() async {
    baseurl =  await geturl();
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/resource/Page Sheet?fields=["name","page_name","company"]',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<PageList> caneList = List.from(jsonData['data'])
            .map<PageList>((data) => PageList.fromJson(data))
            .toList();
        return caneList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch Lead");
        return [];
      }
    } catch (e) {
      Logger().i(e);
      Fluttertoast.showToast(msg: "Unauthorized Orders!");
      return [];
    }
  }



Future<PageMasters?> getmasters() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        '$baseurl/api/method/lead_chain.mobile.main.get_page',
        options: Options(
          method: 'GET',
          headers: {'Authorization': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        Logger().i(response.data["data"]);
        return PageMasters.fromJson(response.data["data"]);
      } else {
        // print(response.statusMessage);
        return null;
      }
    } on DioException catch (e) {
      Logger().i(e.response?.data["message"]);
      Fluttertoast.showToast(msg: "Error while fetching masters");
    }
    return null;
  }
}