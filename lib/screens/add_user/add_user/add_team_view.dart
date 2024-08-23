import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import '../../../widgets/customtextfield.dart';
import '../../../widgets/full_screen_loader.dart';
import '../../../widgets/text_button.dart';
import 'add_team_model.dart';

class AddTeamMember extends StatefulWidget {
  final String memberid;
  const AddTeamMember({super.key, required this.memberid});

  @override
  State<AddTeamMember> createState() => _AddTeamMemberState();
}

class _AddTeamMemberState extends State<AddTeamMember> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<Addteammembermodel>.reactive(
        viewModelBuilder: () => Addteammembermodel(),
        onViewModelReady: (model) => model.initialise(context, widget.memberid),
        builder: (context, model, child) => Scaffold(
          // backgroundColor: Colors.white,
            appBar: AppBar(
              title:  Text(model.isEdit==true?model.addmemberdata.email.toString():'Add Employee'),
            ),
            body: fullScreenLoader(
              child: SingleChildScrollView(
                  child: Form(
                      key: model.formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(children: [
                          CustomSmallTextFormField(controller: model.firstnamecontroller, labelText: 'First Name', hintText: 'Enter the first name',onChanged: model.setname,validator:  (value) => value!.isEmpty
                                ? 'Required'
                                : null,),
                         
                          const SizedBox(
                            height: 15,
                          ),
                                                    CustomSmallTextFormField(controller: model.lastnamecontroller, labelText: 'Last Name', hintText: 'Enter the last name',onChanged: model.setlastname,validator:(value) => value!.isEmpty
                                ? 'Please enter a last Name'
                                : null,),

                          
                          const SizedBox(
                            height: 15,
                          ),
                            CustomSmallTextFormField(controller: model.emailcontroller, labelText: 'Email Address', hintText: 'Enter the email',onChanged: model.setemail,validator:  (value) => value!.isEmpty
                                ? 'Please enter a email address'
                                : null,),

                        
                          const SizedBox(
                            height: 15,
                          ),
                          CustomSmallTextFormField(controller: model.mobilecontroller, labelText: 'Mobile No.', hintText: 'Enter the mobile',onChanged: model.setmobile,validator:  (value) => value!.isEmpty
                                ? 'Please enter a mobile'
                                : null,
                                length: 10,keyboardtype: TextInputType.phone,),
                         
                          // const SizedBox(
                          //   height: 15,
                          // ),
                          // CdropDown(
                          //   dropdownButton: DropdownButtonFormField<String>(
                          //     isExpanded: true,
                          //     value: model.addmemberdata.role,
                          //     // Replace null with the selected value if needed
                          //     decoration: const InputDecoration(
                          //       labelText: 'Role Profile',
                          //     ),
                          //     hint: const Text('Select Role Profile'),
                          //     items: model.rolelist.map((val) {
                          //       return DropdownMenuItem<String>(
                          //         value: val,
                          //         child: AutoSizeText(val),
                          //       );
                          //     }).toList(),
                          //     onChanged: model.setrole,
                          //     validator: model.validaterole,
                          //   ),
                          // ),
                         
                         
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                              controller: model.passwordcontroller,
                              obscureText: model.obscurePassword,
                              decoration: InputDecoration(
                                labelText: "Password",
                                hintText: "*********",
                                prefixIcon: const Icon(Icons.password_outlined),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      model.obscurePassword =
                                          !model.obscurePassword;
                                    });
                                  },
                                  child: Icon(
                                    model.obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.blue, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red, width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onChanged: model.setpassword,
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter a password'
                                  : null),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: model.confirmpasswordcontroller,
                            obscureText: model.obscureconfirmPassword,
                            decoration: InputDecoration(
                              labelText: "Confirm Password",
                              prefixIcon: const Icon(Icons.password_outlined),
                              hintText: "*********",
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    model.obscureconfirmPassword =
                                        !model.obscureconfirmPassword;
                                  });
                                },
                                child: Icon(
                                  model.obscureconfirmPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.red, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.red, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onChanged: model.setconfirmpass,
                            validator: model.validateconfirmpassword,
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          if(model.isEdit==false)
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
                                  text: 'Save', buttonColor: Colors.blueAccent,
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
