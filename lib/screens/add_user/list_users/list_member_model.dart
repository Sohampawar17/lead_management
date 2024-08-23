import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../models/list_member_model.dart';
import '../../../router.router.dart';
import '../../../services/list_member_services.dart';

class ListTeamMemberModel extends BaseViewModel {
  List<MemberList> memberlist = [];
  bool res = false;
  void initialise(BuildContext context) async {
    setBusy(true);
    memberlist = await ListMemberServices().fetchmemberlist();
    setBusy(false);
  }

  void onRowClick(BuildContext context, MemberList? memberlist) {
    Navigator.pushNamed(context, Routes.addTeamMember,
        arguments: AddTeamMemberArguments(memberid: memberlist?.name ?? ""));
  }

  void searchItems(String query) {
    memberlist = memberlist
        .where((item) =>
            item.name.toString().toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  Future<void> refreshList() async {
    memberlist = await ListMemberServices().fetchmemberlist();
    notifyListeners();
  }

  void deleteLead(BuildContext context, String id) async {
    setBusy(true);
    res = await ListMemberServices().deleteMember(id);
    if (res) {
      memberlist = await ListMemberServices().fetchmemberlist();
    }
    setBusy(false);
    notifyListeners();
  }

  
}
