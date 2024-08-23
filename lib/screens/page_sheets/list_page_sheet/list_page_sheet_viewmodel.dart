import 'dart:io';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/page_sheet_model.dart';
import '../../../router.router.dart';
import '../../../services/list_page_sheet_services.dart';

class ListPageSheetViewmodel extends BaseViewModel{
PageMasters masters=PageMasters();
 List<PageList> pageSheetList=[];
 List<PageList> filterPageSheetList=[];

  void initialise(BuildContext context) async {
    setBusy(true);
    masters=await ListPageSheetServices().getmasters() ?? PageMasters();
    pageSheetList = await ListPageSheetServices().fetchlistPageSheet();
    filterPageSheetList=pageSheetList;
    setBusy(false);
  }


  void onRowClick(BuildContext context,String name) {
    Navigator.pushNamed(context, Routes.addPageSheetScreen,
        arguments: AddPageSheetScreenArguments(pageSheetId:name));
    
  }

  Future<void> refreshList() async {
    filterPageSheetList = await ListPageSheetServices().fetchlistPageSheet();
    notifyListeners();
  }
   whatsapp(String? contact,String? message) async {
    //var contact = "+917888187242";
    var androidUrl =
        "whatsapp://send?phone=$contact&text=$message";
    var iosUrl =
        "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      const Text('WhatsApp is not installed.');
    }
  }


}