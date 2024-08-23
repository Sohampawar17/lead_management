// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i14;
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart'
    as _i15;
import 'package:lead_management/screens/add_user/add_user/add_team_view.dart'
    as _i9;
import 'package:lead_management/screens/add_user/list_users/list_member_view.dart'
    as _i10;
import 'package:lead_management/screens/bottom_navigation.dart' as _i5;
import 'package:lead_management/screens/change_password/change_screen.dart'
    as _i6;
import 'package:lead_management/screens/home_screen/home_screen.dart' as _i4;
import 'package:lead_management/screens/lead_screen/add_lead_screen/add_lead_screen.dart'
    as _i8;
import 'package:lead_management/screens/lead_screen/list_lead_screen.dart/list_lead_screen.dart'
    as _i7;
import 'package:lead_management/screens/lead_screen/update_lead_screen/update_screen.dart'
    as _i11;
import 'package:lead_management/screens/login%20screen/login_screen.dart'
    as _i3;
import 'package:lead_management/screens/page_sheets/add_page_sheet/add_page_sheet_screen.dart'
    as _i13;
import 'package:lead_management/screens/page_sheets/list_page_sheet/list_page_sheet_screen.dart'
    as _i12;
import 'package:lead_management/screens/splash_screen.dart' as _i2;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i16;

class Routes {
  static const splashScreen = '/';

  static const loginScreen = '/login-screen';

  static const homeScreen = '/home-screen';

  static const bottomNavigationScreen = '/bottom-navigation-screen';

  static const changePasswordScreen = '/change-password-screen';

  static const leadListScreen = '/lead-list-screen';

  static const addLeadScreen = '/add-lead-screen';

  static const addTeamMember = '/add-team-member';

  static const teamMemberList = '/team-member-list';

  static const updateLeadScreen = '/update-lead-screen';

  static const listPageSheetScreen = '/list-page-sheet-screen';

  static const addPageSheetScreen = '/add-page-sheet-screen';

  static const all = <String>{
    splashScreen,
    loginScreen,
    homeScreen,
    bottomNavigationScreen,
    changePasswordScreen,
    leadListScreen,
    addLeadScreen,
    addTeamMember,
    teamMemberList,
    updateLeadScreen,
    listPageSheetScreen,
    addPageSheetScreen,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashScreen,
      page: _i2.SplashScreen,
    ),
    _i1.RouteDef(
      Routes.loginScreen,
      page: _i3.LoginScreen,
    ),
    _i1.RouteDef(
      Routes.homeScreen,
      page: _i4.HomeScreen,
    ),
    _i1.RouteDef(
      Routes.bottomNavigationScreen,
      page: _i5.BottomNavigationScreen,
    ),
    _i1.RouteDef(
      Routes.changePasswordScreen,
      page: _i6.ChangePasswordScreen,
    ),
    _i1.RouteDef(
      Routes.leadListScreen,
      page: _i7.LeadListScreen,
    ),
    _i1.RouteDef(
      Routes.addLeadScreen,
      page: _i8.AddLeadScreen,
    ),
    _i1.RouteDef(
      Routes.addTeamMember,
      page: _i9.AddTeamMember,
    ),
    _i1.RouteDef(
      Routes.teamMemberList,
      page: _i10.TeamMemberList,
    ),
    _i1.RouteDef(
      Routes.updateLeadScreen,
      page: _i11.UpdateLeadScreen,
    ),
    _i1.RouteDef(
      Routes.listPageSheetScreen,
      page: _i12.ListPageSheetScreen,
    ),
    _i1.RouteDef(
      Routes.addPageSheetScreen,
      page: _i13.AddPageSheetScreen,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashScreen: (data) {
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.SplashScreen(),
        settings: data,
      );
    },
    _i3.LoginScreen: (data) {
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.LoginScreen(),
        settings: data,
      );
    },
    _i4.HomeScreen: (data) {
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.HomeScreen(),
        settings: data,
      );
    },
    _i5.BottomNavigationScreen: (data) {
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.BottomNavigationScreen(),
        settings: data,
      );
    },
    _i6.ChangePasswordScreen: (data) {
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.ChangePasswordScreen(),
        settings: data,
      );
    },
    _i7.LeadListScreen: (data) {
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.LeadListScreen(),
        settings: data,
      );
    },
    _i8.AddLeadScreen: (data) {
      final args = data.getArgs<AddLeadScreenArguments>(nullOk: false);
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.AddLeadScreen(
            key: args.key, leadid: args.leadid, contact: args.contact),
        settings: data,
      );
    },
    _i9.AddTeamMember: (data) {
      final args = data.getArgs<AddTeamMemberArguments>(nullOk: false);
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i9.AddTeamMember(key: args.key, memberid: args.memberid),
        settings: data,
      );
    },
    _i10.TeamMemberList: (data) {
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.TeamMemberList(),
        settings: data,
      );
    },
    _i11.UpdateLeadScreen: (data) {
      final args = data.getArgs<UpdateLeadScreenArguments>(nullOk: false);
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i11.UpdateLeadScreen(key: args.key, updateId: args.updateId),
        settings: data,
      );
    },
    _i12.ListPageSheetScreen: (data) {
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.ListPageSheetScreen(),
        settings: data,
      );
    },
    _i13.AddPageSheetScreen: (data) {
      final args = data.getArgs<AddPageSheetScreenArguments>(nullOk: false);
      return _i14.MaterialPageRoute<dynamic>(
        builder: (context) => _i13.AddPageSheetScreen(
            key: args.key, pageSheetId: args.pageSheetId),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class AddLeadScreenArguments {
  const AddLeadScreenArguments({
    this.key,
    required this.leadid,
    this.contact,
  });

  final _i14.Key? key;

  final String leadid;

  final _i15.Contact? contact;

  @override
  String toString() {
    return '{"key": "$key", "leadid": "$leadid", "contact": "$contact"}';
  }

  @override
  bool operator ==(covariant AddLeadScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.leadid == leadid &&
        other.contact == contact;
  }

  @override
  int get hashCode {
    return key.hashCode ^ leadid.hashCode ^ contact.hashCode;
  }
}

class AddTeamMemberArguments {
  const AddTeamMemberArguments({
    this.key,
    required this.memberid,
  });

  final _i14.Key? key;

  final String memberid;

  @override
  String toString() {
    return '{"key": "$key", "memberid": "$memberid"}';
  }

  @override
  bool operator ==(covariant AddTeamMemberArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.memberid == memberid;
  }

  @override
  int get hashCode {
    return key.hashCode ^ memberid.hashCode;
  }
}

class UpdateLeadScreenArguments {
  const UpdateLeadScreenArguments({
    this.key,
    required this.updateId,
  });

  final _i14.Key? key;

  final String updateId;

  @override
  String toString() {
    return '{"key": "$key", "updateId": "$updateId"}';
  }

  @override
  bool operator ==(covariant UpdateLeadScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.updateId == updateId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ updateId.hashCode;
  }
}

class AddPageSheetScreenArguments {
  const AddPageSheetScreenArguments({
    this.key,
    required this.pageSheetId,
  });

  final _i14.Key? key;

  final String pageSheetId;

  @override
  String toString() {
    return '{"key": "$key", "pageSheetId": "$pageSheetId"}';
  }

  @override
  bool operator ==(covariant AddPageSheetScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.pageSheetId == pageSheetId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ pageSheetId.hashCode;
  }
}

extension NavigatorStateExtension on _i16.NavigationService {
  Future<dynamic> navigateToSplashScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomeScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBottomNavigationScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.bottomNavigationScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChangePasswordScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.changePasswordScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLeadListScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.leadListScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddLeadScreen({
    _i14.Key? key,
    required String leadid,
    _i15.Contact? contact,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addLeadScreen,
        arguments:
            AddLeadScreenArguments(key: key, leadid: leadid, contact: contact),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddTeamMember({
    _i14.Key? key,
    required String memberid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addTeamMember,
        arguments: AddTeamMemberArguments(key: key, memberid: memberid),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTeamMemberList([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.teamMemberList,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUpdateLeadScreen({
    _i14.Key? key,
    required String updateId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.updateLeadScreen,
        arguments: UpdateLeadScreenArguments(key: key, updateId: updateId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToListPageSheetScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.listPageSheetScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddPageSheetScreen({
    _i14.Key? key,
    required String pageSheetId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addPageSheetScreen,
        arguments:
            AddPageSheetScreenArguments(key: key, pageSheetId: pageSheetId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBottomNavigationScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.bottomNavigationScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChangePasswordScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.changePasswordScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLeadListScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.leadListScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddLeadScreen({
    _i14.Key? key,
    required String leadid,
    _i15.Contact? contact,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addLeadScreen,
        arguments:
            AddLeadScreenArguments(key: key, leadid: leadid, contact: contact),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddTeamMember({
    _i14.Key? key,
    required String memberid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addTeamMember,
        arguments: AddTeamMemberArguments(key: key, memberid: memberid),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTeamMemberList([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.teamMemberList,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUpdateLeadScreen({
    _i14.Key? key,
    required String updateId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.updateLeadScreen,
        arguments: UpdateLeadScreenArguments(key: key, updateId: updateId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithListPageSheetScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.listPageSheetScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddPageSheetScreen({
    _i14.Key? key,
    required String pageSheetId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addPageSheetScreen,
        arguments:
            AddPageSheetScreenArguments(key: key, pageSheetId: pageSheetId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
