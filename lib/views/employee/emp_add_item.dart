import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_app_flutter/Helper/db_helper.dart';
import 'package:team_app_flutter/models/emp_model.dart';
import 'package:flutter/services.dart';
import 'package:team_app_flutter/Helper/employee_provider.dart';
import 'package:team_app_flutter/Helper/team_provider.dart';
import '../../main.dart';

class EmpAddItem extends StatefulWidget {
  final Map<String, dynamic> empDatamap;
  final EditMode _editMode;
  EmpAddItem(this._editMode, {this.empDatamap});
  @override
  _EmpAddItemState createState() => _EmpAddItemState();
}

class _EmpAddItemState extends State<EmpAddItem> {
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController ageController = new TextEditingController();
  final TextEditingController cityController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldkey =
      new GlobalKey<ScaffoldState>(debugLabel: "Emp_add_page");
  bool isTlval = false;
  int selectedTlID;
  String selectedTl = "";
  List<int> selectedID = [];

  @override
  void initState() {
    Provider.of<TeamAppProvider>(context, listen: false).getData();
    setData();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    cityController.dispose();
    super.dispose();
  }

  setData() async {
    if (EditMode.UPDATE == widget._editMode) {
      Provider.of<EmpProvider>(context, listen: false)
          .getEmpTLData(empid: widget.empDatamap['empid']);
      nameController.text = widget.empDatamap['ename'];
      ageController.text = widget.empDatamap['age'].toString();
      cityController.text = widget.empDatamap['city'];
      isTlval = widget.empDatamap['istl'] == 1 ? true : false;
      if (widget.empDatamap['istl'] == 0 && widget.empDatamap['tlid'] != null) {
      
        selectedTlID = widget.empDatamap['tlid'];
        selectedTl = widget.empDatamap['tlid'].toString();
      }

      await DataBaseHelper()
          .getTeammembr(widget.empDatamap['empid'])
          .then((value) {
        for (var i = 0; i < value.length; i++) {
          selectedID.add(value[i]['teamid']);
        }
        if (mounted) setState(() {});
      });
    } else {
      Provider.of<EmpProvider>(context, listen: false).getEmpTLData();
    }
  }

  selectTeamID(int teamid) {
    if (selectedID != null) {
      if (selectedID.contains(teamid)) {
        selectedID.remove(teamid);
      } else {
        selectedID.add(teamid);
      }
    } else {
      selectedID.add(teamid);
    }
    if (mounted) setState(() {});
  }

  List<Widget> buildSelectChip(
      List<Map<String, dynamic>> tmdata, List<int> selectedIDs) {
    List<Widget> chip;

    chip = tmdata != null
        ? tmdata
            .map((mapData) => ChoiceChip(
                onSelected: (bool select) {
                  unfocusKeyboard();
                  selectTeamID(mapData['teamid']);
                },
                selected: selectedIDs != null && selectedIDs.length > 0
                    ? selectedIDs.contains(mapData['teamid'])
                    : false,
                disabledColor: Colors.white,
                selectedColor: Colors.blue.shade300,
                elevation: 2,
                label: new Text(mapData['tname'],
                    style: TextStyle(
                        color: selectedIDs != null &&
                                selectedIDs.length > 0 &&
                                selectedIDs.contains(mapData['teamid'])
                            ? Colors.white
                            : Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500))))
            .toList()
        : List<Widget>();
    return chip;
  }

  unfocusKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  saveAction(
      List<Map<String, dynamic>> teamdata, List tldata, BuildContext context) {
    unfocusKeyboard();
    final formVal = _formKey.currentState.validate();

    if (formVal) {
      if (isTlval) {
        if (selectedID != null && selectedID.isNotEmpty) {
          try {
            Provider.of<EmpProvider>(context, listen: false).addUpdateEmp(
                widget._editMode == EditMode.UPDATE
                    ? widget.empDatamap['empid']
                    : null,
                nameController.text.trim(),
                int.parse(ageController.text.trim()),
                cityController.text.trim(),
                isTlval,
                selectedTlID,
                selectedID,
                widget._editMode);
          } catch (e) {
            print(e);
          }
          Navigator.pop(context);
        } else {
          if (teamdata != null && teamdata.isNotEmpty) {
            scaffoldkey.currentState
              ..removeCurrentSnackBar()
              ..showSnackBar(
                  SnackBar(content: Text('Select Team to add employee')));
          } else {
            scaffoldkey.currentState
              ..removeCurrentSnackBar()
              ..showSnackBar(
                  SnackBar(content: Text('Create Team to add employee')));
          }
        }
      } else if (!isTlval && selectedTl.isEmpty) {
        if (tldata != null && tldata.isNotEmpty) {
          scaffoldkey.currentState
            ..removeCurrentSnackBar()
            ..showSnackBar(
                SnackBar(content: Text('Select Team Leader to add employee')));
        } else {
          scaffoldkey.currentState
            ..removeCurrentSnackBar()
            ..showSnackBar(
                SnackBar(content: Text('Create Team Leader to add employee')));
        }
      } else {
        if (selectedID != null && selectedID.length > 0) {
          try {
            Provider.of<EmpProvider>(context, listen: false).addUpdateEmp(
                widget._editMode == EditMode.UPDATE
                    ? widget.empDatamap['empid']
                    : null,
                nameController.text.trim(),
                int.parse(ageController.text.trim()),
                cityController.text.trim(),
                isTlval,
                selectedTlID,
                selectedID,
                widget._editMode);
          } catch (e) {
            print(e);
          }
          Navigator.pop(context);
        } else {
          if (teamdata != null && teamdata.isNotEmpty) {
            scaffoldkey.currentState
              ..removeCurrentSnackBar()
              ..showSnackBar(
                  SnackBar(content: Text('Select Team to add employee')));
          } else {
            scaffoldkey.currentState
              ..removeCurrentSnackBar()
              ..showSnackBar(
                  SnackBar(content: Text('Create Team to add employee')));
          }
        }
      }
    }
    _formKey.currentState.save();
  }

  Widget nameTextField() {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: new TextFormField(
        controller: nameController,
        validator: (val) {
          if (val.trim().isEmpty) {
            return "Please enter name";
          } else if (val.trim().length < 5 || val.trim().length > 15) {
            return "Name should be 5-15 characters";
          } else
            return null;
        },
        maxLines: null,
        maxLength: 15,
        decoration: InputDecoration(hintText: "Enter name", counterText: ''),
      ),
    );
  }

  Widget ageTextField() {
    return Padding(
        padding: EdgeInsets.only(top: 5),
        child: new TextFormField(
          controller: ageController,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'[/\\., -]')),
          ],
          keyboardType: TextInputType.number,
          validator: (val) {
            if (val.trim().isEmpty) {
              return "Please enter age";
            } else
              return null;
          },
          maxLines: null,
          maxLength: 15,
          decoration: InputDecoration(hintText: "Enter age", counterText: ''),
        ));
  }

  Widget cityTextField() {
    return Padding(
        padding: EdgeInsets.only(top: 5),
        child: new TextFormField(
          controller: cityController,
          validator: (val) {
            if (val.trim().isEmpty) {
              return "Please enter city";
            } else if (val.trim().length < 5 || val.trim().length > 15) {
              return "City should be 5-15 characters";
            } else
              return null;
          },
          maxLines: null,
          maxLength: 15,
          decoration: InputDecoration(hintText: "Enter city", counterText: ''),
        ));
  }

  @override
  Widget build(BuildContext context) {
    var teamdata = (Provider.of<TeamAppProvider>(context).listofteam);

    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
          title: new Text(
              (EditMode.ADD == widget._editMode ? 'Add' : 'Update') +
                  ' employee'),
          centerTitle: true),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Column(children: [
              nameTextField(),
              ageTextField(),
              cityTextField(),
              SizedBox(height: 3),
              Consumer<EmpProvider>(
                builder: (context, model, child) => Column(children: [
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text('Is Team Lead '),
                      Switch(
                          value: isTlval,
                          onChanged: (val) async {
                            if (widget._editMode == EditMode.UPDATE) {
                              final checTlRole = await DataBaseHelper()
                                  .checkTlRole(widget.empDatamap['empid']);
                              if (checTlRole != null && checTlRole.isNotEmpty) {
                                scaffoldkey.currentState
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(SnackBar(
                                      content: Text(
                                          '${checTlRole.length} employee are assigned under this user.So change those users before update')));
                              } else {
                                unfocusKeyboard();
                                isTlval = !isTlval;
                                if (mounted) setState(() {});
                              }
                            } else {
                              unfocusKeyboard();
                              isTlval = !isTlval;
                              if (mounted) setState(() {});
                            }
                          }),
                    ],
                  ),
                  !isTlval
                      ? model.empTlData != null && model.empTlData.isNotEmpty
                          ? DropdownButton(
                              hint: Text('Please choose a Team Lead'),
                              value: selectedTl.isEmpty
                                  ? selectedTlID
                                  : selectedTl,
                              onChanged: (newValue) {
                                unfocusKeyboard();
                                if (mounted)
                                  setState(() {
                                    try {
                                      selectedTlID = int.parse(newValue);
                                    } catch (e) {
                                      print(e);
                                    }
                                    selectedTl = newValue;
                                  });
                              },
                              items: model.empTlData.map((tlname) {
                                final empData = EmpModel.toMap(tlname);
                                return DropdownMenuItem(
                                  child: new Text(
                                    empData['ename'].toString(),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  value: empData['empid'].toString(),
                                );
                              }).toList())
                          : new Container()
                      : new Container(),
                  SizedBox(height: 5),
                  teamdata != null && teamdata.isNotEmpty
                      ? new Text(
                          'Teams',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                          textAlign: TextAlign.left,
                        )
                      : new Container(),
                  SizedBox(height: 5),
                  new Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 10,
                      children: buildSelectChip(teamdata, selectedID)),
                  SizedBox(height: 30),
                  new InkWell(
                    onTap: () => saveAction(teamdata, model.empTlData, context),
                    child: new Container(
                      width: 75,
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      color: Colors.blue,
                      child: new Text('Save',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600)),
                    ),
                  )
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
