import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/add_lead_model.dart';
import '../../../models/lead_master_model.dart';
import '../../../models/list_lead_model.dart';
import '../../../services/add_lead_services.dart';
import '../../../services/call_services.dart';
import '../../../services/list_lead_services.dart';
import '../../../services/update_lead_services.dart';

class UpdateLeadModel extends BaseViewModel {
  final CallsAndMessagesService service = CallsAndMessagesService();
  String? note;
    Map<String, dynamic> jsonData={};
  TextEditingController controller = TextEditingController();
LeadMasters masters=LeadMasters();
  List<Users> users = [];
  List<Users> selectedUsers=[];
  List<String> assigneUsers=[]; 
String? assignTo;
  List<String> activity = [""];
  List<WhatsappSms> whatsSms = [];
  AddLeadModel leaddata = AddLeadModel();
  bool res = false;
  List<Notes> notes = [];
  List<ListLeadModel> leadlist=[];
  initialise(BuildContext context, String leadId) async {
    setBusy(true);
    if (leadId != "") {
      leaddata = await AddLeadServices().getlead(leadId) ?? AddLeadModel();
      Logger().i(leaddata.toJson());
      if(leaddata.customSeenLead==0){
        leaddata.customSeenLead=1;
      await UpdateLeadServices().update(leaddata);
      }
      
masters=await UpdateLeadServices().getleadMaster(leadId) ?? LeadMasters();
Logger().i(masters.toJson());
     jsonData = json.decode(leaddata.leadsData ?? "");
     activity=masters.activityLead ?? [];
    assignTo=masters.assignTo ?? "";
     users=masters.users ?? [];
      notes = masters.notes ?? [];
      whatsSms=masters.whatsappSms ?? [];

    }
     notifyListeners();
    setBusy(false);
  }

Future<void> createTem(BuildContext context,String name,String message) async {
  res=await UpdateLeadServices().createTemplate(name, message);
  if(res){
    masters=await UpdateLeadServices().getleadMaster(leaddata.name) ?? LeadMasters();
     whatsSms=masters.whatsappSms ?? [];
     Navigator.of(context).pop();
  }
  notifyListeners();
}

  void deleteLead(BuildContext context,String id) async {
    setBusy(true);
    res= await UpdateLeadServices().deleteLead(id);
    if(res){
      Navigator.pop(context);
    }
    setBusy(false);
    notifyListeners();
  }


void getLeads(){
 leadlist =ListLeadServices().fetchleadlist() as List<ListLeadModel>;
}

void onUserSelected(Users user) {
  selectedUsers.clear();
selectedUsers.add(user);
Logger().i(selectedUsers);
updateAssign(selectedUsers);
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


Future<void> updatestatus() async {
  Logger().i(leaddata.toJson());
await UpdateLeadServices().update(leaddata);
  notifyListeners();
}



List<String> getUserNames(List<Users> users) {
  return assigneUsers.map((user) => user).toList();
}

void updateAssign(List<Users> users) async {


res=await UpdateLeadServices().assign(users,leaddata.name);
if(res){
  masters=await UpdateLeadServices().getleadMaster(leaddata.name) ?? LeadMasters();
  Logger().i(masters.toJson());
  assignTo=masters.assignTo ?? "";
  
notifyListeners();
}

}


  void deletenote(String? lead, int? index) async {
    if (lead!.isNotEmpty && index!.bitLength != 0) {
      // notes.removeAt(index);
      res = await UpdateLeadServices().deletenotes(lead, index);
      if (res) {
         masters=await UpdateLeadServices().getleadMaster(lead) ?? LeadMasters();
     jsonData = json.decode(leaddata.leadsData ?? "");
     activity=masters.activityLead ?? [];
     users=masters.users ?? [];
      notes = masters.notes ?? [];
      }
    }
    notifyListeners();
  }

  void addnote(String? lead, dynamic note,String? activityType) async {

      res = await UpdateLeadServices().addnotes(lead, note,activityType);    
    if (res) {
     masters=await UpdateLeadServices().getleadMaster(lead) ?? LeadMasters();
     jsonData = json.decode(leaddata.leadsData ?? "");
     activity=masters.activityLead ?? [];
     users=masters.users ?? [];
      notes = masters.notes ?? [];
    }
    notifyListeners();
  }


}
