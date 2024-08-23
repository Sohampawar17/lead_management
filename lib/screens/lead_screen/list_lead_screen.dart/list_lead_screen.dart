import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';
import '../../../widgets/full_screen_loader.dart';
import 'list_lead_viewmodel.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class LeadListScreen extends StatefulWidget {
  const LeadListScreen({super.key});

  @override
  State<LeadListScreen> createState() => _LeadListScreenState();
}

class _LeadListScreenState extends State<LeadListScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LeadListViewModel>.reactive(
      viewModelBuilder: () => LeadListViewModel(),
      onViewModelReady: (model) => model.initialise(context),
      builder: (context, model, child) => Scaffold(
   appBar:  AppBar(
  leading: model.isSelectionMode
      ? IconButton(
          onPressed: () => model.exitSelectionMode(),
          icon: const Icon(Icons.clear_outlined),
        )
      : null, // Remove the leading icon in normal mode
  titleSpacing: 0.0, // Remove any spacing around the title
  title: model.isSelectionMode
      ? Text('${model.selectedLeads.length} selected')
      : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0), // Padding around the search bar
          child: TextField(
            onChanged: model.searchItems,
            controller: model.searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.5, // Width of the border
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1.5, // Width of the border
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 2.0, // Width of the focused border
                ),
              ),
              filled: true,
              fillColor: Colors.white, // Background color for the search bar
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            ),

          ),
        ),
  actions: [
    if (model.isSelectionMode)
      Row(
        children: [
          TextButton(
            onPressed: model.selectAllLeads,
            child: Text(
              model.selectedLeads.length == model.filterleadlist.length
                  ? "Deselect All"
                  : "Select All",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Theme.of(context).primaryColor),
            onPressed: model.deleteSelectedLeads,
          ),
        ],
      ),
  ],
  automaticallyImplyLeading: false, // Prevent automatic back button
),



        body: SafeArea(
          child: fullScreenLoader(
            child: Column(
              children: [
                const SizedBox(height: 10),
                model.filterleadlist.isNotEmpty
                    ? Expanded(
                        child: RefreshIndicator(
                          onRefresh: () => model.refresh(),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final leadData = model.filterleadlist[index];
                              final isSelected =
                                  model.selectedLeads.contains(leadData.name);
                              return Container(
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.blue.shade100
                                      : Colors.white,
                                ),
                                child: MaterialButton(
                                  onPressed: () async {
                                    if (model.isSelectionMode) {
                                      model.toggleSelection(
                                          leadData.name ?? "");
                                    } else {
                                      final result = await Navigator.pushNamed(
                                        context,
                                        Routes.updateLeadScreen,
                                        arguments: UpdateLeadScreenArguments(
                                          updateId: model
                                              .filterleadlist[index].name
                                              .toString(),
                                        ),
                                      );

                                      if (result == true) {
                                        model.refresh();
                                      }
                                    }
                                  },
                                  onLongPress: () {
                                    setState(() {
                                      model.isSelectionMode = true;
                                    });
                                    model.toggleSelection(
                                        leadData.name ?? "");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
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
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
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
                                              const SizedBox(height: 5),
                                              if (leadData.campaignName != null)
                                                Text(
                                                  "${leadData.source} Lead Via ${leadData.campaignName}",
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  const Icon(Icons.person,
                                                      size: 12),
                                                  const SizedBox(width: 5),
                                                  Expanded(
                                                    child: Text(
                                                      "created by ${leadData.owner}",
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (leadData.assignedTo != "")
                                                Row(
                                                  children: [
                                                    const Icon(Icons.people,
                                                        size: 14),
                                                    const SizedBox(width: 5),
                                                    Expanded(
                                                      child: Text(
                                                        "Assigned To ${leadData.assignedTo}",
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.grey),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              const SizedBox(height: 5),
                                              if (leadData.customPageName !=
                                                  null)
                                                Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .blueAccent),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .facebook_outlined,
                                                        color: Colors.blueAccent
                                                            .shade700,
                                                        size: 19,
                                                      ),
                                                      const SizedBox(width: 2),
                                                      Text(
                                                        leadData.customPageName ??
                                                            "",
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .blueAccent),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, builder) {
                              return const Divider();
                            },
                            itemCount: model.filterleadlist.length,
                          ),
                        ),
                      )
                    : Center(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: const Text(
                            'Sorry, you got nothing!',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
              ],
            ),
            loader: model.isBusy,
            context: context,
          ),
        ),
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.arrow_circle_down_rounded,
                  color: Colors.white),
              label: 'Import from Address Book',
              backgroundColor: Colors.blue,
              onTap: () async {
                Contact? contact =
                    await FlutterContactPicker().selectContact();
                Navigator.pushNamed(context, Routes.addLeadScreen,
                    arguments: AddLeadScreenArguments(
                        leadid: '', contact: contact));
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.person_add, color: Colors.white),
              label: 'New Lead',
              backgroundColor: Colors.blue,
              onTap: () {
                Navigator.pushNamed(context, Routes.addLeadScreen,
                    arguments:
                        const AddLeadScreenArguments(leadid: ''));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemColumn(
      {required String additionalText, required String labelText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          labelText,
          style: const TextStyle(fontWeight: FontWeight.w400),
        ),
        AutoSizeText(
          additionalText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
