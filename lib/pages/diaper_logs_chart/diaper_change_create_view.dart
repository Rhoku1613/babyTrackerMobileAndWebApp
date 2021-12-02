import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:baby_tracker/services/acitvity_log_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DiaperLogCreateView extends StatefulWidget {
  const DiaperLogCreateView();

  @override
  _DiaperLogCreateViewState createState() => _DiaperLogCreateViewState();
}

class _DiaperLogCreateViewState extends State<DiaperLogCreateView> {
  final _descriptionController = TextEditingController();
  final _dateTimeController = TextEditingController();
  final _ChildrenController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;


  DateTime _selectedDate = DateTime.now();

  void _submit() async {
    setState(() {
      isLoading = true;
    });
    DiaperChangeLogs diaperChangeLog = DiaperChangeLogs(
        id: 999,
        datetime:_dateTimeController.text,description: _descriptionController.text,child: 3);
    final response = await ActivityLogService().add_diaper_change_log(diaperChangeLog);
    if (response == 'Diaper change log added successfully') {
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Diaper Change Log"),
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
                      controller: _descriptionController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(hintText: 'Description of Diaper Change'),
                      validator: _validateEmpty,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _dateTimeController,
                      decoration: InputDecoration(hintText: 'Date and Time Of Diaper Change'),
                      validator: _validateEmpty,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _selectedDate = (await showDatePicker(
                            context: context,
                            firstDate: DateTime(2021),
                            lastDate: DateTime(3000),
                            initialDate: DateTime.now()))!;

                        setState(() {
                          _dateTimeController.text =_selectedDate.toIso8601String();
                        });
                      },
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextFormField(
                  //     controller: _genderController,
                  //     decoration: InputDecoration(hintText: 'Gender'),
                  //     validator: _validateEmpty,
                  //   ),
                  // ),
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
