import 'package:baby_tracker/models/activity_response.dart';
import 'package:baby_tracker/services/child_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:intl/intl.dart";

class ChildrenDetailView extends StatelessWidget {
  const ChildrenDetailView({Key? key, required this.child}): super(key: key);

  final Child child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.child.name),
        ),
        body: Text("This is the child detail view"));
  }
}
