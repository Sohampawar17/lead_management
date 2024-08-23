import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import '../../constants.dart';
import '../../router.router.dart';
import '../../widgets/full_screen_loader.dart';
import 'profile_viewmodel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onViewModelReady: (model) => model.initialise(context),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Account'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: fullScreenLoader(
            loader: model.isBusy,
            context: context,
            child: SingleChildScrollView(
              // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buildProfileHeader(model),
                  const SizedBox(height: 20),
                  _buildSectionHeader('Masters'),
                  _buildListTile('Employee', context, () {
                    Navigator.pushNamed(context, Routes.teamMemberList);
                  }),
                  _buildListTile('Facebook Integration', context, () {
                    Navigator.pushNamed(context, Routes.listPageSheetScreen);
                  }),
                  const SizedBox(height: 20),
                  _buildSectionHeader('Customer Support'),
                  _buildListTile('Chat With Us', context, () {
                    model.whatsapp(model.employeedetail.supportMobile, model.employeedetail.supportSms);
                  }),
                  _buildListTile('Change Password', context, () {
                    Navigator.pushNamed(context, Routes.changePasswordScreen);
                  }),
                  const SizedBox(height: 20),
                  _buildSectionHeader('App Information'),
                  _buildListTile('App Version', context, () {}, trailing: Text(
                    model.version ?? 'Unknown',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  )),
                  _buildListTile('Logout', context, () {
                    _showLogoutDialog(context, model);
                  }, trailing: const Icon(Icons.logout, color: Colors.red)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

 Widget _buildProfileHeader(ProfileViewModel model) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            model.selectPdf(ImageSource.gallery); // Handle edit action here
          },
          child: ClipOval(
            child: CachedNetworkImage(
              fadeInCurve: Curves.bounceIn,
              fadeOutCurve: Curves.bounceInOut,
              width: 80,
              height: 80,
              imageUrl: model.employeedetail.userImage ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(
                  color: Colors.blueAccent),
              errorWidget: (context, url, error) => Image.asset(
                  'assets/images/profile.png',
                  fit: BoxFit.cover),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.employeedetail.fullName ?? 'N/A',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                model.employeedetail.email ?? 'N/A',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                model.employeedetail.company ?? 'N/A',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  ListTile _buildListTile(String title, BuildContext context, VoidCallback onTap, {Widget? trailing}) {
    return ListTile(

      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(title),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  Padding _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, ProfileViewModel model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                logout(context); // Assuming you have a logout method in the ViewModel
                Navigator.pushReplacementNamed(context, Routes.loginScreen);
              },
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
