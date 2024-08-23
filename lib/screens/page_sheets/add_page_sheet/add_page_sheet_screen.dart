import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../widgets/customtextfield.dart';
// ignore: unused_import
import '../../../widgets/drop_down.dart';
import '../../../widgets/full_screen_loader.dart';
import '../../../widgets/text_button.dart';
import 'add_page_sheet_viewmodel.dart';

class AddPageSheetScreen extends StatefulWidget {
  final String pageSheetId;
  const AddPageSheetScreen({super.key, required this.pageSheetId});

  @override
  State<AddPageSheetScreen> createState() => _AddPageSheetScreenState();
}

class _AddPageSheetScreenState extends State<AddPageSheetScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddPageSheetViewmodel>.reactive(
        viewModelBuilder: () => AddPageSheetViewmodel(),
        onViewModelReady: (model) => model.initialise(context,widget.pageSheetId),
        builder: (context, model, child) => Scaffold(
          // backgroundColor: Colors.white,
            appBar: AppBar(
              title:  Text(model.isEdit==true?widget.pageSheetId:'Add Facebook Integration'),
            ),
            body: fullScreenLoader(
              child: SingleChildScrollView(
                  child: Form(
                      key: model.formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(children: [
                          CustomSmallTextFormField(controller: model.pagenamecontroller, labelText: 'Page Name', hintText: 'Enter the page name',onChanged: model.setname,validator:  (value) => value!.isEmpty
                                ? 'Required'
                                : null,),
                         const SizedBox(
                            height: 15,
                          ),
                          SwitchListTile(title: const Text('Enable'),value: model.isEnable, onChanged:(newValue) { 
                // Callback when the switch is toggled 
                setState(() { 
                  model.isEnable = newValue; 
                  model.isPageEnable(newValue);
                  // Call the function to update the message 
                }); 
              }, ),
                          const SizedBox(
                            height: 15,
                          ),
                              CustomSmallTextFormField(controller: model.sheetController, labelText: 'Paste the sheet link here', hintText: 'Enter the sheet link and press add sheet link button'),
                            
                          CdropDown(
                            dropdownButton: DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: model.selectedUser,
                              // Replace null with the selected value if needed
                              decoration: const InputDecoration(
                                labelText: 'User',
                              ),
                              hint: const Text('Select User'),
                              items: model.users.map((val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: AutoSizeText(val),
                                );
                              }).toList(),
                             onChanged:(value) {
                               model.selectedUser=value;
                             },
                  
                            ),
                          ),
                            const SizedBox(
                            height: 10,
                          ),
                         ElevatedButton.icon(onPressed: (){
                          
                          if(model.sheetController.text.isNotEmpty&&model.selectedUser!=null){

                         model.addSheetLink(model.sheetController.text,model.selectedUser);}
                         },icon: const Icon(Icons.add), label: const Text('Add Sheet link')),
                  const SizedBox(height: 8),
                  const Text(
                    'Sheet Link:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                     const SizedBox(height: 8),
                          (model.sheets.isEmpty)
                        ?  Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: const Text(
                'There are no sheets here!',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              border: TableBorder.all(width: 0.7),
                              columnSpacing: 12.0,
                              // ignore: deprecated_member_use
                              dataRowHeight: 40.0,
                              columns: const [
                                DataColumn(
                                    label: Text('Sr No.'),
                                  ),
                                  DataColumn(
                                    label: Text('User'),
                                  ),
                                  DataColumn(
                                    label: Text('Sheet Link'),
                                  ),
                             DataColumn(
                                    label: Text('Allow'),
                                  ),
                                DataColumn(
                                  label: Text('Delete'),
                                  // Add a new DataColumn for the button
                                  numeric: false,
                                ),
                              ],
                              rows: List<DataRow>.generate(
                                model.sheets.length,
                                // Replace 10 with the actual number of rows you want
                                (int index) => DataRow(
                                  cells: [
                                     DataCell(Text("${index+1}"

                                        .toString())),
                                   DataCell(Text(model
                                        .sheets[index].user
                                        .toString())),
                                    DataCell(Text(model
                                        .sheets[index].sheetLink
                                        .toString())),
                                   
                                  DataCell(Text(model
                                        .sheets[index].allow
                                        .toString())),
                                    DataCell(IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title:
                                                  const Text('Confirm Delete'),
                                              content: const Text(
                                                  'Are you sure you want to delete this sheet link?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context); // Close the confirmation dialog
                                                  },
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context); // Close the confirmation dialog
                                                    model.deleteSheetLink(
                                                        index); // Delete the entry
                                                  },
                                                  child: const Text('Delete'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(Icons.delete),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                         
                          const SizedBox(
                            height: 35,
                          ),
                        
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                               Expanded(
                                 child: CtextButton(
                                  text: 'Cancel',
                                  onPressed: () => Navigator.of(context).pop(), buttonColor: Colors.red,
                                                               ),
                               ),
                               const SizedBox(width: 20),
                              Expanded(
                                child: CtextButton(
                                  onPressed: () => model.onsaved(context),
                                  text:model.isEdit==true?'Update': 'Save', buttonColor: Colors.blueAccent,
                                ),
                              ),
                             
                            ],
                          ),
                        ]),
                      ))),
              loader: model.isBusy,
              context: context,
            )));
  }
}