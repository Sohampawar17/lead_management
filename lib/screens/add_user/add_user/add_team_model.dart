import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../../models/team_member_model.dart';
import '../../../services/addteammember_services.dart';

class Addteammembermodel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  List<String> designationlist = [""];
  List<String> rolelist = [""];

  bool isEdit = false;
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  bool obscurePassword = true;
  bool obscureconfirmPassword = true;

  Team_member addmemberdata = Team_member();

  initialise(BuildContext context, String memberid) async {
    setBusy(true);

    rolelist = await AddMemberServices().fetchrole();
    if (memberid != "") {
      isEdit = true;
      addmemberdata =
          await AddMemberServices().getmember(memberid) ?? Team_member();
      firstnamecontroller.text = addmemberdata.firstName ?? "";
      lastnamecontroller.text = addmemberdata.lastName ?? "";
      emailcontroller.text = addmemberdata.email ?? "";
      mobilecontroller.text = addmemberdata.mobile ?? "";
      passwordcontroller.text = addmemberdata.password ?? "";
      confirmpasswordcontroller.text = addmemberdata.confirmPassword ?? "";
      notifyListeners();
    }
    setBusy(false);
  }

  void onsaved(BuildContext context) async {
    setBusy(true);
    if (formKey.currentState!.validate()) {
      bool res = false;
      addmemberdata.firstName = firstnamecontroller.text;
      addmemberdata.lastName = lastnamecontroller.text;
      addmemberdata.email = emailcontroller.text;
      addmemberdata.mobile = mobilecontroller.text;
      addmemberdata.password = passwordcontroller.text;
      addmemberdata.confirmPassword = confirmpasswordcontroller.text;
      addmemberdata.role='CRM';
      Logger().i(addmemberdata.toJson().toString());
      if (isEdit == true) {
        res = await AddMemberServices().updateMember(addmemberdata);
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
        res = await AddMemberServices().addMember(addmemberdata);
        if (res) {
          if (context.mounted) {
            setBusy(false);
            setBusy(false);
            Navigator.pop(
              context,
              true,
            );
          }
        }
      }
    }
    setBusy(false);
  }

  void setname(String? name) {
    addmemberdata.firstName = name;
    notifyListeners();
  }

  void setrole(String? role) {
    addmemberdata.role = role;
    notifyListeners();
  }

  void setdesignation(String? designation) {
    addmemberdata.designation = designation;
    notifyListeners();
  }

  void setlastname(String? lastName) {
    addmemberdata.lastName = lastName;
    notifyListeners();
  }

  void setmobile(String? mobile) {
    addmemberdata.mobile = mobile;
    notifyListeners();
  }

  void setemail(String? email) {
    addmemberdata.email = email;
    notifyListeners();
  }

  void setpassword(String? password) {
    addmemberdata.password = password;
    notifyListeners();
  }

  void setconfirmpass(String? confirmPassword) {
    addmemberdata.confirmPassword = confirmPassword;
    notifyListeners();
  }

  String? validaterole(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter role';
    }
    return null;
  }

  String? validatedesignation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter designation';
    }
    return null;
  }

  String? validateconfirmpassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else if (addmemberdata.password != addmemberdata.confirmPassword) {
      return "Password Dosen't Match";
    }
    return null;
  }

  @override
  void dispose() {
    // Dispose of the controllers to avoid memory leaks
    Logger().i('disposed controller');
    firstnamecontroller.dispose();
    lastnamecontroller.dispose();
    emailcontroller.dispose();
    mobilecontroller.dispose();
    passwordcontroller.dispose();
    confirmpasswordcontroller.dispose();
    super.dispose();
  }
}
