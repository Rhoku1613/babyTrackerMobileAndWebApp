import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:baby_tracker/services/acitvity_log_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class VaccinationLogsCreateView extends StatefulWidget {
  const VaccinationLogsCreateView();

  @override
  _VaccinationLogsCreateViewState createState() =>
      _VaccinationLogsCreateViewState();
}

class _VaccinationLogsCreateViewState extends State<VaccinationLogsCreateView> {
  final _dateController = TextEditingController();
  final _nameController = TextEditingController();
  final _numberOfDosesController = TextEditingController();
  final _numberOfDosesTakenController = TextEditingController();
  final _childrenController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  DateTime _selectedDate = DateTime.now();

  void _submit() async {
    setState(() {
      isLoading = true;
    });
    Vaccine vaccineLogs = Vaccine(
      id: 999,
      date: _dateController.text,
      child: 3,
      name: _nameController.text,
      numberOfDosesTaken: int.parse(_numberOfDosesController.text),
      numberOfDoses: int.parse(_numberOfDosesTakenController.text),
    );
    final response = await ActivityLogService().add_vaccine_log(vaccineLogs);
    if (response == 'Vaccine log added successfully') {
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
          title: Text("Add Growth Log"),
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
                      controller: _dateController,
                      decoration:
                          InputDecoration(hintText: 'Date of recording'),
                      validator: _validateEmpty,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _selectedDate = (await showDatePicker(
                            context: context,
                            firstDate: DateTime(2021),
                            lastDate: DateTime(3000),
                            initialDate: DateTime.now()))!;

                        setState(() {
                          _dateController.text =
                              DateFormat('yyyy-MM-dd').format(_selectedDate);
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(hintText: 'Name of Vaccine'),
                      validator: _validateEmpty,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _numberOfDosesController,
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(hintText: 'Total Number Of Doses'),
                      validator: _validateEmpty,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _numberOfDosesTakenController,
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(hintText: 'Number Of Doses Taken'),
                      validator: _validateEmpty,
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
