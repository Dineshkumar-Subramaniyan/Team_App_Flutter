import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team_app_flutter/main.dart';
import 'package:team_app_flutter/models/team_model.dart';
import 'db_helper.dart';

class TeamAppProvider with ChangeNotifier {
  List tmData = [];

  List get teamData {
    return [...tmData];
  }

  Future getTeamData() async {
    final teamlist = await DataBaseHelper().getDataFromDB('team');
    tmData = teamlist
        .map((item) => TeamModel(item['teamid'], item['tname']))
        .toList();
    notifyListeners();
  }

  Future addUpdateTeam(int teamid, String tname, EditMode editMode) async {
    final teamval = TeamModel(teamid, tname);

    if (EditMode.ADD == editMode) {
      await DataBaseHelper()
          .insertTeamData({'tname': tname}, "team").then((value) async {
        int _teamid = await DataBaseHelper().getteamid();
        final tval = TeamModel(_teamid, tname);
        tmData.insert(0, tval);
        notifyListeners();
      });
    } else {
      tmData[tmData.indexWhere((teamval) => teamval.id == teamid)] = teamval;
      DataBaseHelper()
          .updateTeamData({'tname': tname, 'teamid': teamid}, "team");
      notifyListeners();
    }
  }

  Future deleteTeamCheck(
      BuildContext context, int teamid, String teamname) async {
    final checkMember = await DataBaseHelper().checkMemberTeam(teamid);
    if (checkMember != null && checkMember.isNotEmpty) {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content: Text(
                '${checkMember.length} employee are assigned under this $teamname')));
    } else {
      tmData.removeWhere((tmval) => tmval.id == teamid);
      notifyListeners();
      DataBaseHelper().delTeamData(teamid);
    }
  }
}
