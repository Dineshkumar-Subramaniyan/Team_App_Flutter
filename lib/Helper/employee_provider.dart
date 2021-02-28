import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team_app_flutter/main.dart';
import 'package:team_app_flutter/models/emp_model.dart';
import 'db_helper.dart';

class EmpProvider extends ChangeNotifier {
  List empData = [];
  List empTlData = [];

  List get emplyData {
    return [...empData];
  }

  Future getEmpTLData({int empid}) async {
    
    final empTllist = await DataBaseHelper().getTlDataFromDB('employee', empid);
    
    try {
      empTlData = empTllist
          .map((item) => EmpModel(item['ename'], item['age'], item['city'],
              item['istl'], item['tlid'], item['tlname'],
              empid: item['empid']))
          .toList();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future getEmpData() async {
    final emplist = await DataBaseHelper().getEmpFromDB();
    
    try {
      empData = emplist
          .map((item) => EmpModel(item['ename'], item['age'], item['city'],
              item['istl'], item['tlid'], item['tlname'],
              empid: item['empid']))
          .toList();
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  getEmpId(int empid) {
    
    return empData.firstWhere((item) => item.empid == empid,
        orElse: () => null);
  }

  Future addUpdateEmp(int empid, String name, int age, String city,
      bool switchVal, int tlid, List<int> selteamid, EditMode editMode) async {
    String teamleadName;
    if (tlid != null) {
      teamleadName = await DataBaseHelper().getTlName(tlid);
    }

    final empval = EmpModel(
        name, age, city, switchVal == true ? 1 : 0, tlid, teamleadName,
        empid: empid);
    Map<String, dynamic> mapData = EmpModel.toMap(empval);

    if (EditMode.ADD == editMode) {
      await DataBaseHelper()
          .insertTeamData(mapData, "employee")
          .then((value) async {
        int _empid = await DataBaseHelper().getuniqid();
        await addteammembr(_empid, selteamid);
        try {
          final tmval = EmpModel(
            name,
            age,
            city,
            switchVal == true ? 1 : 0,
            tlid,
            teamleadName,
            empid: _empid,
          );
          empData.insert(0, tmval);
        } catch (e) {
          print(e);
        }
        notifyListeners();
      });
    } else {
      await addteammembr(empid, selteamid);
      empData[empData.indexWhere((empval) => empval.id == empid)] = empval;
      DataBaseHelper().updateEmpData(mapData, "employee");
      notifyListeners();
    }
  }

  addteammembr(int empid, List<int> selectedTeams) async {
    if (empid != null && selectedTeams != null && selectedTeams.isNotEmpty) {
      for (var i = 0; i < selectedTeams.length; i++) {
        await DataBaseHelper().addupdtmmem(empid, selectedTeams[i], i);
      }
    }
  }

  Future deleteEmpCheck(BuildContext context, int empid, String ename) async {
    final checTlRole = await DataBaseHelper().checkTlRole(empid);
    if (checTlRole != null && checTlRole.isNotEmpty) {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content: Text(
                '${checTlRole.length} employee are assigned under the $ename TL')));
    } else {
      empData.removeWhere((tmval) => tmval.empid == empid);
      notifyListeners();
      DataBaseHelper().delEmpData(empid);
    }
  }
}
