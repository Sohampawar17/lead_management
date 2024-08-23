import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:stacked/stacked.dart';
import '../../constants.dart';
import 'login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText=true;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewmodel>.reactive(
      viewModelBuilder: () => LoginViewmodel(),
      onViewModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        body: Container(
         
          decoration: const BoxDecoration(
           gradient: LinearGradient(
            colors: [Color(0xFF87CEFA), Color(0xFF8A2BE2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          ),
          child: Form(
            key: model.formGlobalKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 180),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Login", style: TextStyle(color: Colors.white, fontSize: 40)),
                        SizedBox(height: 10),
                        Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 18)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                     height: getHeight(context),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 60),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(225, 95, 27, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                _buildTextField(
                                  controller: model.usernameController,
                                  hintText: "Email or Phone number",
                                  autofillHints: const [AutofillHints.username],
                                  validator: model.validateUsername,
                                ),
                                _buildTextField(
                                  controller: model.passwordController,
                                  hintText: "Password",
                                  obscureText: obscureText,
                                  suffixIcon:  InkWell(
                                  onTap: () {
                                    setState(() {
                                      obscureText =
                                          !obscureText;
                                    });
                                  },
                                  child: Icon(
                                    obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                ),
                                  autofillHints: const [AutofillHints.password],
                                  validator: model.validatePassword,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          const Text("Forgot Password?", style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 40),
                           model.isLoading
                                  ?  CircularProgressIndicator(color: Colors.blueAccent[900])
                                  : SizedBox(
                            width: double.infinity, // Same width as the input fields
                            child:
                             MaterialButton(
                              height: 50,
                              color: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (model.formGlobalKey.currentState!.validate()) {
                                  model.formGlobalKey.currentState!.save();
                                  model.loginwithUsernamePassword(context);
                                }
                              },
                              child:const Text(
                                      'Login',
                                      style: TextStyle(fontSize: 20, color: Colors.white),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    Widget? suffixIcon,
    required List<String> autofillHints,
    required String? Function(String?) validator,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon:  suffixIcon,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
        
        autofillHints: autofillHints,
        onEditingComplete: () {
          TextInput.finishAutofillContext();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        validator: validator,
      ),
    );
  }
}
