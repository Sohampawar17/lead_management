import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import '../../models/user_details.dart';
import '../../services/profile_screen.dart';

class ProfileViewModel extends BaseViewModel {
  bool res = false;
  UserDetails employeedetail = UserDetails();
  String? version;
  initialise(BuildContext context) async {
    setBusy(true);
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    employeedetail = await ProfileServices().profile() ?? UserDetails();
    setBusy(false);
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


  Future<void> selectPdf(ImageSource source) async {
    try {
      final result = await ImagePicker().pickImage(source: source);

      if (result == null) {
        return;
      }

      setBusy(true);

      File? compressedFile = await compressFile(fileFromXFile(result));
      Logger().i(result);

      String aadharUrl = await ProfileServices().uploadDocs(compressedFile);
      Logger().i(aadharUrl);

      res = await ProfileServices().updateProfilePicture(aadharUrl);
      employeedetail = await ProfileServices().profile() ?? UserDetails();

      setBusy(false);
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error while picking an image or document: $e',
      );
    }
  }
}
