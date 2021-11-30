import 'package:baby_tracker/models/forum_response.dart';
import 'package:baby_tracker/services/forum_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForumCreateView extends StatefulWidget {
  const ForumCreateView();

  @override
  _ForumCreateViewState createState() => _ForumCreateViewState();
}

class _ForumCreateViewState extends State<ForumCreateView> {
  final _questionController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading=false;

  String? _validateQuestion(String? question) {
    if (question!.isEmpty)
      return 'Question field cannot be empty';
    else
      return null;
  }

  void _submit() async {
    setState(() {
      isLoading = true;
    });
    Forum forum=Forum(id: 999,title:_questionController.text,body:_descriptionController.text,author:1);
    final response=await ForumService().create_forum_post(forum);
    if(response=='Forum post created successfully'){
      setState((){
        isLoading=false;
      });
    }else{
      setState((){
        isLoading=false;
      });
    }
  }


  String? _validateDescription(String? description) {
    if (description!.isEmpty)
      return 'Description is required';
    else
      return null;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ask A Question"),
        ),
        body: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _questionController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: 'Question'),
                    validator: _validateQuestion,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(hintText: 'Description'),
                    validator: _validateDescription,
                  ),
                ),
                ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      _submit();
                    }
                  },
                  child:(isLoading)?const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 1.5,
                      )):const Text('Submit'),
                ),

              ],
            ),
          )
        ));
  }
}
