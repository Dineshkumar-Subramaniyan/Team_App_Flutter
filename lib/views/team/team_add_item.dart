import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_app_flutter/Helper/team_provider.dart';
import '../../main.dart';

class TeamAddItem extends StatefulWidget {
  final int teamid;
  final String teamname;
  final EditMode editMode;

  TeamAddItem({this.teamid, this.teamname, this.editMode});
  @override
  _TeamAddItemState createState() => _TeamAddItemState();
}

class _TeamAddItemState extends State<TeamAddItem> {
  final TextEditingController teamtextController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (EditMode.UPDATE == widget.editMode) {
      teamtextController.text = widget.teamname;
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
      Provider.of<TeamAppProvider>(context, listen: false).addUpdateTeam(
          widget.teamid, teamtextController.text.trim(), widget.editMode);
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
            if (val.trim().isEmpty) {
              return "Please enter data";
            } else if (val.trim().length <= 1 || val.trim().length > 15) {
              return "Name should be 2-15 characters";
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
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            saveAction(context);
          },
        )
      ],
    );
  }
}
