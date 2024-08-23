import 'dart:async';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../../models/list_lead_model.dart';
import '../../../router.router.dart';
import '../../../services/list_lead_services.dart';
import '../../../services/notification_services.dart';
 // Import the notification service

class LeadListViewModel extends BaseViewModel {
  bool res = false;
  List<ListLeadModel> leadlist = [];
  List<ListLeadModel> filterleadlist = [];
  final TextEditingController searchController = TextEditingController();
  List<String> selectedLeads = [];
  bool isSelectionMode = false;

  Timer? _refreshTimer;
  final NotificationService _notificationService = NotificationService();

  initialise(BuildContext context) async {
    setBusy(true);
    leadlist = await ListLeadServices().fetchleadlist();
    filterleadlist = leadlist;
    notifyListeners();
    setBusy(false);

    // Initialize notification service
    await _notificationService.initialize();

    // Start auto-refresh after initial load
    startAutoRefresh();
  }

  void startAutoRefresh() {
    _refreshTimer?.cancel();

    _refreshTimer = Timer.periodic(Duration(seconds: 15), (Timer timer) {
      refreshData();
    });
  }

  void refreshData() async {
  
      List<ListLeadModel> newLeadList = await ListLeadServices().fetchleadlist();

      // Check if new leads were added
      if (newLeadList.length > leadlist.length) {
        _notificationService.showNotification(
          'New Leads Available',
          '${newLeadList.length - leadlist.length} new leads have been added.',
        );
      }

      filterleadlist = newLeadList;
      leadlist = newLeadList;
      notifyListeners();

  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  void searchItems(String query) {
    filterleadlist = leadlist
        .where((item) => item.leadName
        .toString()
        .toLowerCase()
        .contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void exitSelectionMode() {
    isSelectionMode = false;
    selectedLeads.clear();
    notifyListeners();
  }

  Future<void> refresh() async {
    filterleadlist = await ListLeadServices().fetchleadlist();
    notifyListeners();
  }

  void toggleSelection(String leadName) {
    if (selectedLeads.contains(leadName)) {
      selectedLeads.remove(leadName);
    } else {
      selectedLeads.add(leadName);
    }
    notifyListeners();
  }

  void selectAllLeads() {
    if (selectedLeads.length == filterleadlist.length) {
      selectedLeads.clear();
    } else {
      selectedLeads = filterleadlist.map((lead) => lead.name ?? "").toList();
    }
    notifyListeners();
  }

  void deleteSelectedLeads() async {
    Logger().i(selectedLeads);
    res = await ListLeadServices().deleteleads(selectedLeads);
    if (res) {
      filterleadlist.removeWhere((lead) => selectedLeads.contains(lead.name));
      selectedLeads.clear();
      isSelectionMode = false;
    }
    notifyListeners();
  }

  void onRowClick(BuildContext context, ListLeadModel? leadList) {
    Navigator.pushNamed(
      context,
      Routes.updateLeadScreen,
      arguments:
      UpdateLeadScreenArguments(updateId: leadList?.name.toString() ?? ""),
    );
  }
}
