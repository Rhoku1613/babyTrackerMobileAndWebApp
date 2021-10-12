import 'package:baby_tracker/services/BaseService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dashboard_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading=false;
  final _formKey = GlobalKey<FormState>();

  void _signIn() async {
    setState(() {
      isLoading = true;
    });
    final success = await Services.of(context)
        .authService
        .signIn(_emailController.text, _passwordController.text);
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


  Future<void> _handleResponse(bool success) async {
    if (success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login successful')));
      await Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => DashboardPage()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Email or password incorrect')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
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
                  validator: _validatePassword,
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    _signIn();
                  }
                },
                child:(isLoading)?const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 1.5,
                    )):const Text('Sign In'),
              ),
              ElevatedButton.icon(
                onPressed: _signIn,
                icon: Icon(Icons.login),
                label: Text('Google Sign In'),
              ),
              ElevatedButton.icon(
                onPressed: _signIn,
                icon: Icon(Icons.login),
                label: Text('Facebook Sign in'),
              ),
              ElevatedButton.icon(
                onPressed: _goBack,
                icon: Icon(Icons.arrow_back),
                label: Text('Go Back'),
              )
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
