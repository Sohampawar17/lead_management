
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:stacked/stacked.dart';
import '../../../constants.dart';
import '../../../models/lead_master_model.dart';
import '../../../router.router.dart';
import '../../../services/update_lead_services.dart';
import '../../../widgets/customtextfield.dart';
import '../../../widgets/full_screen_loader.dart';
import 'update_viewmodel.dart';


class UpdateLeadScreen extends StatefulWidget {
  final String updateId;
  const UpdateLeadScreen({super.key, required this.updateId});

  @override
  State<UpdateLeadScreen> createState() => _UpdateLeadScreenState();
}

class _UpdateLeadScreenState extends State<UpdateLeadScreen> {
bool isNeed=false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpdateLeadModel>.reactive(
        viewModelBuilder: () => UpdateLeadModel(),
        onViewModelReady: (model) => model.initialise(context, widget.updateId),
        builder: (context, model, child) => Scaffold(
            
              appBar: AppBar(
                leading: IconButton(
                 
                  onPressed: (){

                    Navigator.pop(context, true);
                }, icon: const Icon(Icons.arrow_back_sharp)),
            
                actions: [
                  TextButton(onPressed: (){
 showModalBottomSheet(
      context: context,
      builder: (context) =>
      Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Options'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Lead'),
                onTap: () {
                 Navigator.pushNamed(
                          context, Routes.addLeadScreen,
                          arguments:
                              AddLeadScreenArguments(leadid: widget.updateId));
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.delete_forever_outlined),
                title: const Text('Delete Lead'),
                onTap: () {
                  Navigator.pop(context);
                 model.deleteLead(context,widget.updateId);
                 
                },
              ),
                            const Divider(),

              ListTile(
                leading: Icon(model.leaddata.customSeenLead==1?Icons.visibility_off:Icons.visibility),
                title:  Text(model.leaddata.customSeenLead==1?'Unseen':'Seen'),
                onTap: () {
                  Navigator.of(context).pop();
                  model.leaddata.customSeenLead=model.leaddata.customSeenLead==1?0:1;
                  UpdateLeadServices().update(model.leaddata);
                },
              ),
              
              const Divider(),
 ListTile(
                leading: const Icon(Icons.person_outline_outlined),
                title:  const Text('Change Owner'),
                onTap: () {
                  Navigator.of(context).pop();
                 _showUserBottomSheet(context, model.users, model.onUserSelected);
                },
              ),
            ],
          ),
        ),
      ),
    )
    );
                  }, child: const Text('options')),
                 
                ],
              ),
              body: WillPopScope(
  onWillPop: () async {
   Navigator.pop(context, true);
    return Future.value(true);
  },
                child: fullScreenLoader(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                model.leaddata.leadName ?? "",
                                style: const TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                   IconButton.filled(
                                style:    ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.teal.shade700), // Use MaterialStateProperty.all
    foregroundColor: WidgetStateProperty.all(Colors.white), // Ensure this line uses MaterialStateProperty.all as well
  ),
                              iconSize: 30,
                                  icon: const FaIcon(FontAwesomeIcons.whatsapp,color: Colors.white,),
                                  onPressed: () {
                                     model.whatsapp(model.leaddata.mobileNo ?? "", "");
                                  },
                                ),
                              const SizedBox(
                                width: 15,
                              ),
                             IconButton.filled(
                               style:    ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.teal.shade700), // Use MaterialStateProperty.all
    foregroundColor: WidgetStateProperty.all(Colors.white), // Ensure this line uses MaterialStateProperty.all as well
  ),
                            onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: const Text('Message Templates'),
                        actions: [
                          ElevatedButton.icon(onPressed: (){
                showDialog(
                      context: context,
                      builder: (BuildContext context) {
                       
                        final TextEditingController nameController = TextEditingController();
                         final TextEditingController messageController = TextEditingController();
                        return StatefulBuilder(
                          builder: (BuildContext context, StateSetter setState) {
                            return AlertDialog(
                backgroundColor: Colors.white,
                title: const Text('New Template'),
                content: SizedBox(
                  width: getWidth(context),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                     CustomSmallTextFormField(
                        controller: nameController,
                        labelText: 'Template Name',
                        hintText: 'Enter the template name',
                      ),
                      const SizedBox(height: 15),
                      CustomSmallTextFormField(
                        controller: messageController,
                        labelText: 'Message',
                        hintText: 'Enter the message',
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      // Handle the data here
                      String message = messageController.text;
                       String name=nameController.text;
                      model.createTem(context,name,message);
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text('Submit'),
                  ),
                ],
                            );
                          },
                        );
                      },
                    );
                          }, label: const Text('Add Template'))
                        ],
                      ),
                      body: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: model.whatsSms.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(model.whatsSms[index].name ?? ""),
                            onTap: () {
                              model.whatsapp(model.leaddata.mobileNo ?? "", model.whatsSms[index].message ?? "");
                            },
                          );
                        },
                      ),
                      
                    );
                  },
                );
                            },
                            
                            icon: const Icon(
                Icons.send,color: Colors.white,
                           
                            ),
                 iconSize: 30,
                          ),
                            const SizedBox(
                                width: 15,
                              ),
                           IconButton.filled(
                             style:    ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.teal.shade700), // Use MaterialStateProperty.all
    foregroundColor: WidgetStateProperty.all(Colors.white), // Ensure this line uses MaterialStateProperty.all as well
  ),
                                 iconSize: 30,
                                  icon: const Icon(Icons.phone,color: Colors.white,),
                                  onPressed: () {
                                    model.service
                                        .call(model.leaddata.mobileNo ?? "");
                                  },
                                ),
                               
                           const SizedBox(
                                width: 15,
                              ),
                                IconButton.filled(
                                   style:    ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.teal.shade700), // Use MaterialStateProperty.all
    foregroundColor: WidgetStateProperty.all(Colors.white), // Ensure this line uses MaterialStateProperty.all as well
  ),
                              iconSize: 30,
                                  icon: const FaIcon(FontAwesomeIcons.message,color: Colors.white,),
                                  onPressed: () {
                                    model.service
                                        .sendSms(model.leaddata.mobileNo ?? "");
                                  },
                                ),
                                 const SizedBox(
                                width: 15,
                              ),
                                IconButton.filled(
                                   style:    ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.teal.shade700), // Use MaterialStateProperty.all
    foregroundColor: WidgetStateProperty.all(Colors.white), // Ensure this line uses MaterialStateProperty.all as well
  ),
                                 iconSize: 30,
                                  icon: const Icon(Icons.email,color: Colors.white,),
                                  onPressed: () {
                                    model.service
                                        .sendEmail(model.leaddata.emailId ?? "");
                                  },
                                ),
                                 const SizedBox(
                                width: 15,
                              ),
                               
                                 
                              ]),
                            ],
                          ),
                        ),
                        _buildSectionHeader(model),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFollowUpSection(model),
                              const Divider(),
                            _buildTimelineSection(model),
                               const Divider(),
                            //  if(model.leaddata.customLeadsData == "{}")
                                _buildNotesSection(model),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  loader: model.isBusy,
                  context: context,
                ),
              ),
            ));
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

void _showUserBottomSheet(BuildContext context, List<Users> users, Function(Users) onUserSelected) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: const Text('Select Owner')),
          body: ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user.fullName ?? ""),
                subtitle: Text(user.name ?? ""), // Display email as subtitle
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  onUserSelected(user); // Trigger the method with the selected user
                },
              );
            },
          ),
        );
      },
    );
  }
  Widget _buildSectionHeader(UpdateLeadModel model) {
  return Container(
    width: getWidth(context),
    height: 40,
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 110, 180, 238)
    ),
    child: Row(
      children: [
         const SizedBox(width: 10),
        const Icon(Icons.person, color: Colors.white),
        const SizedBox(width: 10),
        Expanded(
          child:  Text(
              'Owner - ${model.assignTo!=""?model.assignTo:'Not Assigned'}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis, // Ensures text does not overflow
            ),
        
        ),
         const Icon(Icons.arrow_drop_down, color: Colors.white),
      ],
    ),
  );
}


  Widget _buildFollowUpSection(UpdateLeadModel model) {
    return InkWell(
      onTap: ()=>_showFollowUpOptions(model),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Follow Up',
           style: TextStyle(
            fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
          ),
          Text( 
            'Follow up scheduled on ${model.leaddata.customSfollowUp=="Some Day"?model.leaddata.customSfollowUp:''}',
          ),
          if(model.leaddata.customFollowUpDatetime!=null && model.leaddata.customSfollowUp!='Some Day')
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(DateFormat('dd-MMM-yyyy').format(DateTime.tryParse(model.leaddata.customFollowUpDatetime.toString())?? DateTime.now()))
                        , Text(DateFormat.jm().format(DateTime.tryParse(model.leaddata.customFollowUpDatetime.toString())?? DateTime.now()))

            ],
          )
        ],
      ),
    );
  }


  

  void _showFollowUpOptions(UpdateLeadModel model) {
    showModalBottomSheet(
      context: context,
      builder: (context) => DateOptionsBottomSheet(
        onDateSelected: (DateSelection selection) {
          setState(() {
            model.leaddata.customSfollowUp=selection.label;
            model.leaddata.customFollowUpDatetime = _formatDate(selection.dateTime); 
            model.updatestatus(); // Update model's follow-up date
          });
        },
      ),
    );
  }

Widget _buildNotesSection(UpdateLeadModel model) {
  String subtitleText = '${DateFormat('dd-MMM-yyyy HH:mm a').format(DateTime.tryParse(model.leaddata.customLeadsDataCreatedTime.toString()) ?? DateTime.now())} | Source: ${model.leaddata.source ?? ""}';
  return Card(
    elevation: 1,
    color: Colors.white,
    child: Container(
      padding: const EdgeInsets.all(8.0),
     
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: model.jsonData.entries.map((entry) {
              final key = entry.key.toUpperCase().replaceAll("_", " ");
              final value = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$key: ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '$value',
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10,),
         
           Text(
            subtitleText,
            style: const TextStyle(
            color: Colors.blue,
     fontWeight: FontWeight.w600
            ),
          ),
        ],
      ),
    ),
  );
}


 bool isLoading = false;

  Widget _buildTimelineSection(UpdateLeadModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'ACTIVITIES',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            IconButton(
              onPressed: () {
                _showAddActivityDialog(model);
              },
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(),
          )
        else if (model.notes.isNotEmpty)
          ListView.separated(
            separatorBuilder: (context, builder) {
              return const Divider();
            },
            reverse: true,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: model.notes.length,
            itemBuilder: (context, index) {
              final noteData = model.notes[index];
              return Dismissible(
                background: Container(
                  color: Colors.red.shade400,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Remove',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    bool dismiss = false;
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text("Are you sure you want to delete the activity"),
                          title: const Text("Delete Activity?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                dismiss = false;
                                Navigator.pop(context);
                              },
                              child: const Text("No"),
                            ),
                            TextButton(
                              onPressed: () {
                                dismiss = true;
                                model.deletenote(widget.updateId, noteData.name);
                                Navigator.pop(context);
                                setState(() {
                                  model.notes.removeAt(index);
                                });
                              },
                              child: const Text("Yes"),
                            ),
                          ],
                        );
                      },
                    );
                    return dismiss;
                  }
                  return null;
                },
                direction: DismissDirection.startToEnd,
                key: UniqueKey(),
                child: Container(
                  width: getWidth(context),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ACTIVITY : ${model.notes[index].customActivityLead}',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${model.notes[index].note}",
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${DateFormat('dd-MMM-yyyy').add_jm().format(DateTime.tryParse(model.notes[index].addedOn.toString()) ?? DateTime.now())} | Source: ${model.notes[index].commented ?? ""}'
                        ,textAlign: TextAlign.end,
                        style: const TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        else
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: const Text(
                'There are no activities!',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
      ],
    );
  }

void _showAddActivityDialog(UpdateLeadModel model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? selectedActivityType;
        final TextEditingController messageController = TextEditingController();
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text('Enter Activity Details'),
              content: SizedBox(
                width: getWidth(context),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Activity Type',
                      ),
                      value: selectedActivityType,
                      items: model.activity.map((String type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedActivityType = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomSmallTextFormField(
                      controller: messageController,
                      labelText: 'Message',
                      hintText: 'Enter the message',
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    // Handle the data here
                    String message = messageController.text;
                     model.addnote(widget.updateId, message, selectedActivityType);
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Submit'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
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
