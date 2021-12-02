import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:baby_tracker/models/activity_response.dart';
import 'package:baby_tracker/services/acitvity_log_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class GrowthLogsCreateView extends StatefulWidget {
  GrowthLogsCreateView({Key? key, required this.child}): super(key: key);

  final Child child;

  @override
  _GrowthLogsCreateViewState createState() => _GrowthLogsCreateViewState();
}

class _GrowthLogsCreateViewState extends State<GrowthLogsCreateView> {
  final _heightController = TextEditingController();
  final _dateTimeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;


  DateTime _selectedDate = DateTime.now();

  void _submit() async {
    setState(() {
      isLoading = true;
    });
    GrowthLogs growthLog = GrowthLogs(
        id: 999,
        datetime:_dateTimeController.text,child: this.widget.child.id, height: int.parse(_heightController.text));
    final response = await ActivityLogService().add_growth_log(growthLog);
    if (response == 'Growth log added successfully') {
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
                      controller: _heightController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(hintText: 'Height(in CM)'),
                      validator: _validateEmpty,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _dateTimeController,
                      decoration: InputDecoration(hintText: 'Date of recording'),
                      validator: _validateEmpty,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _selectedDate = (await showDatePicker(
                            context: context,
                            firstDate: DateTime(2021),
                            lastDate: DateTime(3000),
                            initialDate: DateTime.now()))!;

                        setState(() {
                          _dateTimeController.text =
                              DateFormat('yyyy-MM-dd').format(_selectedDate);
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
