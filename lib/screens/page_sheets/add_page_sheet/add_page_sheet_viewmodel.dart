
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:stacked/stacked.dart';
import '../../../models/add_page_sheet_model.dart';
import '../../../services/add_page_sheet_services.dart';

class AddPageSheetViewmodel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  TextEditingController pagenamecontroller = TextEditingController();
  TextEditingController sheetController = TextEditingController();
  List<SheetLink> sheets = [];
  List<String> users=[];
  String? selectedUser;
  bool isEdit = false;
  AddPageSheetModel addpagesheetdata = AddPageSheetModel();
bool isEnable=false;

void isPageEnable(bool isEnable){
  addpagesheetdata.allowPage=isEnable==true?1:0;
  notifyListeners();
}

  initialise(BuildContext context, String sheetid) async {
    setBusy(true);
   users=await AddPageSheetServices().fetchUsers();
    if (sheetid != "") {
      isEdit = true;
      addpagesheetdata = await AddPageSheetServices().getmember(sheetid) ??
          AddPageSheetModel();
      pagenamecontroller.text = addpagesheetdata.pageName ?? "";
      isEnable=addpagesheetdata.allowPage==1?true:false;
      sheets.addAll(addpagesheetdata.sheetLink?.toList() ?? []);
      notifyListeners();
    }
    setBusy(false);
  }

  void onsaved(BuildContext context) async {
    setBusy(true);
    if (formKey.currentState!.validate()) {
      bool res = false;
      addpagesheetdata.pageName = pagenamecontroller.text;
      addpagesheetdata.sheetLink = sheets;
      Logger().i(addpagesheetdata.toJson().toString());
      Logger().i(isEdit.toString());

      if (isEdit == true) {
        res = await AddPageSheetServices().updatePageSheet(addpagesheetdata);
        if (res) {
          if (context.mounted) {
            setBusy(false);
            setBusy(false);
            Navigator.pop(
              context,
              true
            );
          }
        }
      } else {
        res = await AddPageSheetServices().addPageSheet(addpagesheetdata);
        if (res) {
          if (context.mounted) {
            setBusy(false);
            setBusy(false);
            Navigator.pop(
              context,
         true
            );          }
        }
      }
    }
    setBusy(false);
  }

  void setname(String? name) {
    addpagesheetdata.pageName = name;
    notifyListeners();
  }

  void addSheetLink(String? name,String? user) {
    sheets.add(SheetLink(sheetLink: name,allow: 1,user: user));
    sheetController.clear();
    notifyListeners();
  }

  void deleteSheetLink(int index) {
    if (index >= 0 && index < sheets.length) {
      sheets.removeAt(index);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // Dispose of the controllers to avoid memory leaks
    Logger().i('disposed controller');
    pagenamecontroller.dispose();
    sheetController.dispose();
    super.dispose();
  }
}
