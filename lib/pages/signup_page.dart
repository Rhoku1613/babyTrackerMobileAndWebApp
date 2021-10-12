import 'package:baby_tracker/services/BaseService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage();

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>{
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController= TextEditingController();
  bool isLoading= false;

  final _formKey = GlobalKey<FormState>();

  void _signUp() async {
    setState(() {
      isLoading = true;
    });

    final success = await Services.of(context)
        .authService
        .signUp(_emailController.text, _passwordController.text);
    await _handleResponse(success);
    setState(() {
      isLoading = false;
    });
  }



  void _goBack() async {
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => HomePage()));
  }

  String? _validateEmail(String? email) {
    RegExp regex = RegExp(r'\w+@\w+\.\w+');
    if (email!.isEmpty)
      return 'Please enter an email address';
    else if (!regex.hasMatch(email))
      return "Please enter a valid email address";
    else
      return null;
  }

  String? _validatePassword(String? password) {
    if (password!.isEmpty)
      return 'Password cannot be empty';
    else
      return null;
  }

  String? _validateConfirmPassword(String? confirmPassword) {
    if (confirmPassword!.isEmpty)
      return 'Confirm password cannot be empty';
    else if(!identical(confirmPassword, _passwordController.text))
      return "Password and confirm password should match";
    else
      return null;
  }



  Future<void> _handleResponse(bool success) async {
    if (success) {
      await Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LoginPage()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Something went wrong.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        autovalidateMode: AutovalidateMode.always, key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: 'Email'),
                  validator: _validateEmail,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password'),
                  validator: _validatePassword
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _passwordConfirmController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Confirm Password'),
                  validator: _validateConfirmPassword,
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    _signUp();
                  }
                },
                child:(isLoading)?const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 1.5,
                    )):const Text('Sign Up'),
              ),
              ElevatedButton.icon(
                onPressed: _goBack,
                icon: Icon(Icons.arrow_back),
                label: Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
