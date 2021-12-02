import 'package:baby_tracker/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView();

  @override
  _SettingsView createState() => _SettingsView();
}

class _SettingsView extends State<SettingsView> {
  bool isSwitched=false;





  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger=Provider.of<ThemeChanger>(context);


    ListTile _buildItemsForListView(BuildContext context, int index) {
      return ListTile(
          onTap: (){
          },
          title: Text("Dark Theme"),
          subtitle: Text("Switch Between Dark And Light Theme"), trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Switch(value: this.isSwitched,onChanged: (value){
            setState(() {
              //write logic to change theme
              isSwitched = value;
              if(isSwitched){
                _themeChanger.setTheme(ThemeData.dark());
              }else{
                _themeChanger.setTheme(ThemeData.light());
              }
            });
          },)
        ],
      )
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: _buildItemsForListView,
        ));
  }
}
