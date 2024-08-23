import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';

import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

import '../../../models/add_lead_model.dart';
import '../../../models/lead_master_model.dart';
import '../../../services/add_lead_services.dart';


class AddLeadViewModel extends BaseViewModel{

TextEditingController firstnamecontroller=TextEditingController();
TextEditingController lastnamecontroller=TextEditingController();
TextEditingController mobilenumbercontroller=TextEditingController();
TextEditingController emailcontroller=TextEditingController();
TextEditingController companynamecontroller=TextEditingController();
TextEditingController citycontroller=TextEditingController();
TextEditingController statecontroller=TextEditingController();
TextEditingController whatsappcontroller=TextEditingController();
TextEditingController noteController=TextEditingController();
TextEditingController textEditingController=TextEditingController();
List<Notes> notes=[];
bool isEdit=false;
AddLeadModel leaddata =AddLeadModel();

final formKey = GlobalKey<FormState>();

List<String> territory=[""]; 


  initialise(BuildContext context,String leadId,Contact? contact) async {
    setBusy(true);
// territory= await AddLeadServices().fetchterritory();
if(contact !=null){
  Logger().i(contact.toString());
    firstnamecontroller.text=contact.toString().replaceAll(RegExp('[^A-Za-z]'), '');
    leaddata.firstName=firstnamecontroller.text;
     mobilenumbercontroller.text=contact.toString().replaceAll(RegExp('[^+0-9]'), '');
     leaddata.mobileNo=mobilenumbercontroller.text;
     
}
if(leadId != ""){
  isEdit=true;
  leaddata= await AddLeadServices().getlead(leadId) ?? AddLeadModel();
  firstnamecontroller.text=leaddata.firstName ?? "";
  mobilenumbercontroller.text=leaddata.mobileNo ?? "";
  emailcontroller.text=leaddata.emailId ?? "";
  whatsappcontroller.text=leaddata.whatsappNo ?? "";

  notifyListeners();
}
    setBusy(false);
  }

  void onSavePressed(BuildContext context) async {
    setBusy(true);
    if (formKey.currentState!.validate()) {

      bool res = false;
      Logger().i(leaddata.toJson());
    if(isEdit == true){
  res = await AddLeadServices().updateOrder(leaddata);
      if (res) {
        if (context.mounted) {
          setBusy(false);
          Navigator.pop(context);
        
      }}
    }else{
    
      res = await AddLeadServices().addLead(leaddata);
      if (res) {
        if (context.mounted) {
          setBusy(false);
          Navigator.pop(context);
        
      }}}
    }
  setBusy(false);
  }

void setfirstname(String firstname){
  firstnamecontroller.text=firstname;
  leaddata.firstName =firstnamecontroller.text;
  notifyListeners();
}


void setmobilenumber(String mobileno){
  mobilenumbercontroller.text=mobileno;
  leaddata.mobileNo =mobilenumbercontroller.text;
  notifyListeners();
}

void setterritory(String? territory){
  leaddata.territory =territory;
  notifyListeners();
}

void setemail(String emailId){
  emailcontroller.text=emailId;
  leaddata.emailId =emailcontroller.text;
  notifyListeners();
}


void setwhatsapp(String whatsapp){
  whatsappcontroller.text=whatsapp;
  leaddata.whatsappNo =whatsappcontroller.text;
  notifyListeners();
}

  ///validators
  String? validatefirstname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Full name';
    }
    return null;
  }

  String? validatelastname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Last name';
    }
    return null;
  }
    String? validatemobile(String? value) {

                if (value == null || value.isEmpty) {
                  return 'Please enter a mobile number';
                } else if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value)) {
                  return 'Please enter a valid mobile number';
                }
                return null;
              }
    String? validateemail(String value) {
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }
    String? validatecompany(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter company';
    }
    return null;
  }
    String? validatestate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter State';
    }
    return null;
  }
   
    String? validatecity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter City';
    }
    return null;
  }
  ///dispose controllers
  @override
  void dispose() {
    firstnamecontroller.dispose();
    lastnamecontroller.dispose();
    mobilenumbercontroller.dispose();
    emailcontroller.dispose();
   
    super.dispose();
  }
}