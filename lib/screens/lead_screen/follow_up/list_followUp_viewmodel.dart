import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../../models/follow_up_list.dart';
import '../../../models/list_lead_model.dart';
import '../../../router.router.dart';
import '../../../services/list_lead_services.dart';

class FollowUpListViewModel extends BaseViewModel {
  FollowUpListLeadModel followUp = FollowUpListLeadModel();
  List<Overdue> overdueFollowlist = [];
  List<Overdue> todayFollowlist = [];
  List<Overdue> upcomingFollowlist = [];
  List<Overdue> someDaylist = [];
  List<Overdue> selectedItems = [];
  bool isSelectionMode = false;
  List<ListLeadModel> filterleadlist = [];


  Timer? _refreshTimer;

  bool res=false;
  initialise(BuildContext context) async {
    setBusy(true);
    followUp = (await ListLeadServices().getfolloeupleadMaster())!;
    Logger().i(followUp.toJson());
    overdueFollowlist = followUp.overdue ?? [];
    todayFollowlist = followUp.today ?? [];
    upcomingFollowlist = followUp.upcoming ?? [];
    someDaylist = followUp.someDay ?? [];
    notifyListeners();
    setBusy(false);
  }

  void startAutoRefresh() {
    // Cancel any existing timer
    _refreshTimer?.cancel();

    // Start a new timer that refreshes data every 5 seconds
    _refreshTimer = Timer.periodic(Duration(seconds: 15), (Timer timer) {
      refresh();
    });
  }

  Future<void> refresh() async {
    followUp = (await ListLeadServices().getfolloeupleadMaster())!;
    overdueFollowlist = followUp.overdue ?? [];
    todayFollowlist = followUp.today ?? [];
    upcomingFollowlist = followUp.upcoming ?? [];
    someDaylist = followUp.someDay ?? [];
    notifyListeners();
  }

  List<String> selectedFollowUps = [];

  void enterSelectionMode(String? followUpId) {
    isSelectionMode = true;
    toggleSelection(followUpId);
    notifyListeners();
  }

  void toggleSelection(String? followUpId) {
    if (selectedFollowUps.contains(followUpId)) {
      selectedFollowUps.remove(followUpId);
    } else {
      selectedFollowUps.add(followUpId.toString());
    }
    notifyListeners();
  }

  void exitSelectionMode() {
    isSelectionMode = false;
    selectedFollowUps.clear();
    notifyListeners();
  }
Future<void> updateSelectedFollowUpStatus(String newStatus, String statusTime) async {
 setBusy(true);

     Logger().i(selectedFollowUps);
    final listLeadServices = ListLeadServices(); // Create an instance of ListLeadServices
     res = await listLeadServices.changeFollowUp(selectedFollowUps, newStatus, statusTime);
    if (res){
 exitSelectionMode();
    await refresh();
    setBusy(false);
    }
}

  void onRowClick(BuildContext context, String? name) {
    Navigator.pushNamed(
      context,
      Routes.updateLeadScreen,
      arguments: UpdateLeadScreenArguments(updateId: name.toString()),
    );
  }
}
