import 'package:baby_tracker/models/activity_response.dart';
import 'package:baby_tracker/services/child_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:intl/intl.dart";

class ChildrenEnrollView extends StatefulWidget {
  const ChildrenEnrollView();

  @override
  _ChildrenEnrollViewState createState() => _ChildrenEnrollViewState();
}

class _ChildrenEnrollViewState extends State<ChildrenEnrollView> {
  final _nameController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _dobController = TextEditingController();
  final _genderController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  DateTime _selectedDate = DateTime.now();

  void _submit() async {
    setState(() {
      isLoading = true;
    });
    Child child = Child(
        id: 999,
        name: _nameController.text,
        dob: _dobController.text,
        weight: double.parse(_weightController.text),
        height: int.parse(_heightController.text),
        gender: _genderController.text,
        parent: 1);
    final response = await ChildService().enroll_a_child(child);
    if (response == 'Child enrolled successfully') {
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  String? _validateEmpty(String? question) {
    if (question!.isEmpty)
      return 'Field cannot be empty';
    else
      return null;
  }

  DropdownButton _showDropDownMenu() {
    return DropdownButton(
        value: _genderController.text,
        onChanged: (value) {
          setState(() {
            _genderController.text = value;
          });
        },
        items: [
          DropdownMenuItem(
            child: Text("Male"),
            value: "ML",
          ),
          DropdownMenuItem(
            child: Text("Female"),
            value: "FM",
          ),
          DropdownMenuItem(
            child: Text("Other"),
            value: "OT",
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Enroll A Child"),
        ),
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
                      controller: _nameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: 'Name'),
                      validator: _validateEmpty,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: _weightController,
                        decoration:
                            InputDecoration(hintText: 'Weight At Birth(lbs)'),
                        validator: _validateEmpty,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: _heightController,
                        decoration:
                            InputDecoration(hintText: 'Height At Birth(Cm)'),
                        validator: _validateEmpty,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _dobController,
                      decoration: InputDecoration(hintText: 'Date Of Birth'),
                      validator: _validateEmpty,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _selectedDate = (await showDatePicker(
                            context: context,
                            firstDate: DateTime(2021),
                            lastDate: DateTime(3000),
                            initialDate: DateTime.now()))!;

                        setState(() {
                          _dobController.text =
                              DateFormat('yyyy-MM-dd').format(_selectedDate);
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _genderController,
                      decoration: InputDecoration(hintText: 'Gender'),
                      validator: _validateEmpty,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _submit();
                      }
                    },
                    child: (isLoading)
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1.5,
                            ))
                        : const Text('Submit'),
                  ),
                ],
              ),
            )));
  }
}
