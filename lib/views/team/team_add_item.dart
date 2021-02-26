import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_app_flutter/Helper/team_provider.dart';
import 'package:team_app_flutter/views/team/team_list.dart';
import '../../main.dart';

class TeamAddItem extends StatefulWidget {
  final int teamid;
  final String teamname;
  final EditMode editMode;
  TeamAddItem({this.teamid, this.teamname, this.editMode});
  @override
  _TeamAddItemState createState() =>
      _TeamAddItemState(teamid, teamname, editMode);
}

class _TeamAddItemState extends State<TeamAddItem> {
  final TextEditingController teamtextController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int _teamid;
  String _teamname;
  EditMode _editMode;

  _TeamAddItemState(teamid, teamname, editMode) {
    this._teamid = teamid;
    this._teamname = teamname;
    this._editMode = editMode;
  }

  @override
  void initState() {
    if (EditMode.UPDATE == _editMode) {
      teamtextController.text = _teamname;
    }
    super.initState();
  }

  @override
  void dispose() {
    teamtextController.dispose();
    super.dispose();
  }

  Widget actionWidget(String name) {
    return Container(
        padding: EdgeInsets.all(6),
        margin: EdgeInsets.symmetric(horizontal: 8),
        color: Colors.blue,
        child: new Text(name,
            style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w600)));
  }

  void saveAction(context) {
    final formVal = _formKey.currentState.validate();
    if (formVal) {
      Provider.of<TeamAppProvider>(context, listen: false)
          .addUpdateTeam(_teamid, teamtextController.text.trim(), _editMode);
      Navigator.pop(context);
    }
    _formKey.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: new Text('Enter team name'),
      content: Form(
        key: _formKey,
        child: new TextFormField(
          controller: teamtextController,
          validator: (val) {
            if (val.isEmpty) {
              return "Please enter data";
            } else if (val.length <= 1) {
              return "Enter minimum 2 character";
            } else if (val.length > 15) {
              return "Name should not exceed limit";
            } else
              return null;
          },
          maxLines: null,
          maxLength: 15,
          decoration: InputDecoration(hintText: "Enter name", counterText: ''),
        ),
      ),
      actions: [
        new InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: actionWidget('Cancel')),
        new InkWell(
          child: actionWidget('Save'),
          onTap: () {
            saveAction(context);
          },
        )
      ],
    );
  }
}
