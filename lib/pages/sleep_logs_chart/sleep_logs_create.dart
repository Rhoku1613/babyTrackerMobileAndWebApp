import 'package:baby_tracker/models/activity_log_response.dart';
import 'package:baby_tracker/models/activity_response.dart';
import 'package:baby_tracker/services/acitvity_log_service.dart';
import 'package:baby_tracker/services/child_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SleepLogsCreateView extends StatefulWidget {
  const SleepLogsCreateView();

  @override
  _SleepLogsCreateViewState createState() => _SleepLogsCreateViewState();
}

class _SleepLogsCreateViewState extends State<SleepLogsCreateView> {
  final _dateController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _ChildrenController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();

  int child=1;

  List<Child> data=[];

  void _submit() async {
    setState(() {
      isLoading = true;
    });
    SleepLogs sleepLogs = SleepLogs(
      id: 999,
      date: _dateController.text,
      child: 3,
      start: _startTimeController.text,
      end: _endTimeController.text,
    );
    final response = await ActivityLogService().add_sleep_log(sleepLogs);
    if (response == 'Sleep log added successfully') {
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
                      controller: _startTimeController,
                      decoration:
                          InputDecoration(hintText: 'Start time of sleep'),
                      validator: _validateEmpty,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _startTime = (await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now()))!;

                        setState(() {
                          _startTimeController.text =_startTime.format(context);
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _endTimeController,
                      decoration:
                          InputDecoration(hintText: 'End time of sleep'),
                      validator: _validateEmpty,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _endTime = (await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now()))!;

                        setState(() {
                          _endTimeController.text =_endTime.format(context);
                        });
                      },
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextFormField(
                  //     onTap: () async{
                  //       showModalBottomSheet(builder: (BuildContext context) {
                  //         return Column(
                  //           children: this._populateChildren(),
                  //         );
                  //       }, context: context);
                  //     },
                  //     controller: _ChildrenController,
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

  @override
  void initState() {
    super.initState();
    _getAllChildrenByAccessToken();
  }

  void _getAllChildrenByAccessToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? access_token=prefs.getString('access_token');
    List<Child> children=await ChildService().get_children_by_access_token(access_token!);
    setState(() {
      this.data=children;
    });
  }

  List<ListTile> _populateChildren(){
    List<ListTile> listTiles=[];
    for(Child child in this.data){
      ListTile listTile=ListTile(
        title:Text(child.name),
        onTap: (){
          Navigator.pop(context);
          setState(() {
            this._ChildrenController.text=child.name;
            this.child=child.id;
          });
        },
      );

      listTiles.add(listTile);
    }
    return listTiles;
  }
}
