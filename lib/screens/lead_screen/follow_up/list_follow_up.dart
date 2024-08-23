import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import '../../../models/follow_up_list.dart';
import '../../../router.router.dart';
import '../../../widgets/full_screen_loader.dart';
import 'list_followUp_viewmodel.dart';

class FollowUpListScreen extends StatefulWidget {
  const FollowUpListScreen({super.key});

  @override
  State<FollowUpListScreen> createState() => _FollowUpListScreenState();
}

class _FollowUpListScreenState extends State<FollowUpListScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FollowUpListViewModel>.reactive(
      viewModelBuilder: () => FollowUpListViewModel(),
      onViewModelReady: (model) => model.initialise(context),
      builder: (context, model, child) => DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
         
            leading: model.isSelectionMode ? IconButton(onPressed: ()=>model.exitSelectionMode(), icon: const Icon(Icons.clear_outlined)):Container(),
            title: model.isSelectionMode
                ? Text('${model.selectedFollowUps.length} selected')
                : const Text('Follow Up'),
            centerTitle: true,
            actions: [
              if (model.isSelectionMode)
                TextButton(
                child: const Text('Followup on'),
                  onPressed: () => _showStatusChangeSheet(context, model),
                ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueAccent,
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.white,
                  tabs: const [
                    TabItem(title: 'Overdue'),
                    TabItem(title: 'Today'),
                    TabItem(title: 'Upcoming'),
                    TabItem(title: 'Some Day'),
                  ],
                ),
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: model.refresh,
            child: fullScreenLoader(
              loader: model.isBusy,
              context: context,
              child: TabBarView(
                children: [
                  _buildTabContent(context, model, model.overdueFollowlist),
                  _buildTabContent(context, model, model.todayFollowlist),
                  _buildTabContent(context, model, model.upcomingFollowlist),
                  _buildTabContent(context, model, model.someDaylist),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context, FollowUpListViewModel model, List<Overdue> leadList) {
    if (leadList.isEmpty) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Sorry, you got nothing!',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      );
    }

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final leadData = leadList[index];
        final isSelected = model.selectedFollowUps.contains(leadData.name);

        return Container(
          color: isSelected ? Colors.blue.shade100 : Colors.white,
          child: ListTile(
            onTap: model.isSelectionMode
                ? () => model.toggleSelection(leadData.name)
                : () async {
                    final result = await Navigator.pushNamed(
                      context,
                      Routes.updateLeadScreen,
                      arguments: UpdateLeadScreenArguments(updateId: leadData.name ?? ''),
                    );
                    if (result == true) {
                      model.refresh();
                    }
                  },
            onLongPress: () => model.enterSelectionMode(leadData.name),
            leading: model.isSelectionMode
                ? Checkbox(
                    value: isSelected,
                    onChanged: (value) => model.toggleSelection(leadData.name),
                  )
                : Container(
                    alignment: Alignment.center,
                    color: Colors.blue,
                    height: 40,
                    width: 40,
                    child: Text(
                      leadData.abbreviation ?? "N/A",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 17,
                      ),
                    ),
                  ),
            title: Row(
                                                children: [
                                                  if (leadData.customSeenLead ==
                                                      0)
                                                    Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8,
                                                          vertical: 4),
                                                      decoration:
                                                          BoxDecoration(
                                                        color: Colors
                                                            .purple.shade100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                      ),
                                                      child: const Text(
                                                        "Uncontacted",
                                                        style: TextStyle(
                                                          color: Colors.purple,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  if (leadData.customSeenLead ==
                                                      0)
                                                    const SizedBox(width: 5),
                                                  Expanded(
                                                    child: Text(
                                                      leadData.leadName ?? "",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                if (leadData.campaignName != null)
                  Text(
                    "${leadData.source} Lead Via ${leadData.campaignName}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.person, size: 12),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        "created by ${leadData.owner}",
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (leadData.assignedTo != "")
                  Row(
                    children: [
                      const Icon(Icons.people, size: 14),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          "Assigned To ${leadData.assignedTo}",
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                                              if (leadData.customPageName != null)
                                                Container(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 5, vertical: 2),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.blueAccent),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        Icons.facebook_outlined,
                                                        color: Colors.blueAccent.shade700,
                                                        size: 19,
                                                      ),
                                                      const SizedBox(width: 2),
                                                      Text(
                                                        leadData.customPageName ?? "",
                                                        style: const TextStyle(color: Colors.blueAccent),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
              ],
            ),
          ),
        );
      },
     separatorBuilder: (context, builder) {
                              return const Divider();
                            },
      itemCount: leadList.length,
    );
  }

  void _showStatusChangeSheet(BuildContext context, FollowUpListViewModel model) {

    showModalBottomSheet(
      context: context,
      builder: (context) => DateOptionsBottomSheet(
        onDateSelected: (DateSelection selection) {
          setState(() {
            model.updateSelectedFollowUpStatus(selection.label,_formatDate(selection.dateTime)); // Update model's follow-up date
          });
        },
      ),
    );
  }


 String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
  }
}

class TabItem extends StatelessWidget {
  final String title;

  const TabItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}



class DateSelection {
  final DateTime dateTime;
  final String label;

  DateSelection({required this.dateTime, required this.label});
}

class DateOptionsBottomSheet extends StatelessWidget {
  final void Function(DateSelection) onDateSelected;

  const DateOptionsBottomSheet({
    super.key,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        
        title: const Text('Follow Up Options'),
       
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                 ListTile(
                title: const Text('Set Custom Date & Time'),
                onTap: () async {
                  final DateTime? dateTime = await _selectCustomDateTime(context);
                  if (dateTime != null) {
                    Navigator.of(context).pop();
                    onDateSelected(DateSelection(
                      dateTime: dateTime,
                      label: 'Set Custom Date & Time',
                    ));
                  }
                },
              ),
              ListTile(
                title: const Text('Today'),
                onTap: () {
                  Navigator.of(context).pop();
                  onDateSelected(DateSelection(
                    dateTime: DateTime.now(),
                    label: 'Today',
                  ));
                },
              ),
              ListTile(
                title: const Text('Tomorrow'),
                onTap: () {
                  Navigator.of(context).pop();
                  onDateSelected(DateSelection(
                    dateTime: DateTime.now().add(const Duration(days: 1)),
                    label: 'Tomorrow',
                  ));
                },
              ),
              ListTile(
                title: const Text('3 Days from Now'),
                onTap: () {
                  Navigator.of(context).pop();
                  onDateSelected(DateSelection(
                    dateTime: DateTime.now().add(const Duration(days: 3)),
                    label: '3 Days from Now',
                  ));
                },
              ),
              ListTile(
                title: const Text('1 Week from Now'),
                onTap: () {
                  Navigator.of(context).pop();
                  onDateSelected(DateSelection(
                    dateTime: DateTime.now().add(const Duration(days: 7)),
                    label: '1 Week from Now',
                  ));
                },
              ),
              ListTile(
                title: const Text('1 Month from Now'),
                onTap: () {
                  Navigator.of(context).pop();
                  onDateSelected(DateSelection(
                    dateTime: DateTime.now().add(const Duration(days: 30)),
                    label: '1 Month from Now',
                  ));
                },
              ),
           
              ListTile(
                title: const Text('Some Day'),
                onTap: () {
                  Navigator.of(context).pop();
                  onDateSelected(DateSelection(
                    dateTime: DateTime.now().subtract(const Duration(days: 365 * 30)), // Placeholder for "Never"
                    label: 'Some Day',
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> _selectCustomDateTime(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime selectedDate = now;
    TimeOfDay selectedTime = TimeOfDay.fromDateTime(now);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Date and Time'),
          content: SizedBox(
            height: 200, // Set a height for the dialog content
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  child: Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (newDate != null && newDate != selectedDate) {
                      selectedDate = newDate;
                    }
                  },
                ),
                TextButton(
                  child: Text(selectedTime.format(context)),
                  onPressed: () async {
                    TimeOfDay? newTime = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                    );
                    if (newTime != null && newTime != selectedTime) {
                      selectedTime = newTime;
                    }
                  },
                ),
                ElevatedButton(
                  child: const Text('Save'),
                  onPressed: () {
                    Navigator.of(context).pop(DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedTime.hour, selectedTime.minute));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    return DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedTime.hour, selectedTime.minute);
  }
}
