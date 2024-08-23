import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:stacked/stacked.dart';
import '../../../widgets/customtextfield.dart';
import '../../../widgets/full_screen_loader.dart';
import '../../../widgets/text_button.dart';
import 'add_lead_viewmodel.dart';

class AddLeadScreen extends StatefulWidget {
  final Contact? contact;
  final String leadid;
  const AddLeadScreen({super.key, required this.leadid,  this.contact});

  @override
  State<AddLeadScreen> createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddLeadViewModel>.reactive(
      viewModelBuilder: () => AddLeadViewModel(),
      onViewModelReady: (model) => model.initialise(context,widget.leadid,widget.contact),
      builder: (context, model, child)=>Scaffold(
      //  backgroundColor: Colors.white,
      appBar:AppBar(title:  Text(model.isEdit ?model.leaddata.name.toString() :'Create Lead',style: const TextStyle(fontSize: 18),),
),
    body: fullScreenLoader(
      loader: model.isBusy,context: context,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: model.formKey,
            child: Column(
              children: [
                Row(children: [
 Expanded(child: CustomSmallTextFormField(prefixIcon: Icons.person,controller: model.firstnamecontroller,labelText:'Full Name' ,hintText: 'Enter the first name',onChanged: model.setfirstname,validator: model.validatefirstname,)),
 
                
                ],),
             
                           const SizedBox(height: 15,),
                            CustomSmallTextFormField(prefixIcon:Icons.email,controller: model.emailcontroller,labelText:'Email Address' ,hintText: 'Enter your email id',onChanged: model.setemail,),
                
            const SizedBox(height: 15,),
                        CustomSmallTextFormField(prefixIcon: Icons.phone,controller:model.mobilenumbercontroller,labelText:'Mobile Number' ,hintText: 'Enter the your mobile number',onChanged: model.setmobilenumber,validator: model.validatemobile,length: 10,keyboardtype: TextInputType.phone),
                        
                        
                  //         const SizedBox(height: 15,),
              
                  // CustomDropdownButton2(labelText: 'Territory',value: model.leaddata.territory,prefixIcon:Icons.location_on,searchInnerWidgetHeight: 35,items:model.territory, hintText: 'select territory', onChanged: model.setterritory,),
                  
                        
                          const SizedBox(height: 25,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [Expanded(child: CtextButton(onPressed: () => Navigator.of(context).pop(), text: 'Cancel', buttonColor: Colors.red.shade500,)),
                           const SizedBox(width: 20), Expanded(child: CtextButton(onPressed: ()=> model.onSavePressed(context), text:model.isEdit?'Update' : 'Create', buttonColor: Colors.blueAccent.shade400,))],
                          )
              ],
            ),
          ),
        ),
      ),
    ),  ));
  }
}