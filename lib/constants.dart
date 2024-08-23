import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'router.router.dart';

String apiroleprofile =
    '$baseurl/api/resource/Role Profile';
String apimember = '$baseurl/api/resource/Employee Master';
String apilistmember =
    '$baseurl/api/resource/Employee Master?fields=["first_name","last_name","company","name"]';
getHeight(context) => (MediaQuery.of(context).size.height);
getWidth(context) => (MediaQuery.of(context).size.width);

String baseurl = geturl.toString();
String apiUploadFilePost = '$baseurl/api/method/upload_file';

///functions
Future<String> getTocken() async {
  final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
  final SharedPreferences prefs = await prefs0;
  String? apiSecret = prefs.getString("api_secret") ?? "";
  String? apiKey = prefs.getString("api_key") ?? "";
  String formattedString = 'token $apiKey:$apiSecret';
  return formattedString;
}



Future<String> geturl() async {
  final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
  final SharedPreferences prefs = await prefs0;
  String? url = prefs.getString("url") ?? "";
  return url;
}

void logout(BuildContext context) async {
  final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
  final SharedPreferences prefs = await prefs0;
  prefs.clear();
  if (context.mounted) {
    Navigator.popAndPushNamed(context, Routes.loginScreen);
  }
}

String generateUniqueFileName(File file) {
  // Get the original file name and extension
  String originalFileName = file.path.split('/').last;
  String extension = originalFileName.split('.').last;
  // Generate a unique identifier (You can use any method you prefer)
  String uniqueId = DateTime.now().millisecondsSinceEpoch.toString();
  // Combine the unique identifier with the original extension
  String uniqueFileName = '$uniqueId.$extension';
  return uniqueFileName;
}

bool isImage(File file) {
  List<String> imageExtensions = ['.png', '.jpg', '.jpeg', '.gif', '.bmp'];
  String extension = file.path.split('.').last.toLowerCase();
  return imageExtensions.contains(extension);
}

bool isPDF(File file) {
  String extension = file.path.split('.').last.toLowerCase();
  return extension == '.pdf';
}

Future<File?> compressFile(File file) async {
  // Get the file path.
  final filePath = file.path;
  // Get the file extension.
  final fileExtension = filePath.split('.').last;
  // Create a new file name with the extension "_compressed".
  final compressedFileName =
  filePath.replaceAll(fileExtension, '_compressed.$fileExtension');
  var result = await FlutterImageCompress.compressAndGetFile(
    file.path,
    compressedFileName,
    quality: 60,
    // rotate: 180,
  );
  return fileFromXFile(result ?? XFile(""));
}

// Convert an XFile object to a File object.
File fileFromXFile(XFile xfile) {
  // Get the file path.
  final filePath = xfile.path;
  // Create a File object.
  final file = File(filePath);
  return file;
}

