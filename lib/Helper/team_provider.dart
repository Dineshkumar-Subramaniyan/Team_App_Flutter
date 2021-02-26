import 'package:flutter/cupertino.dart';
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
      tmData.insert(0, teamval);
      DataBaseHelper().insertTeamData({'tname': tname}, "team");
    } else {
      tmData[tmData.indexWhere((teamval) => teamval.id == teamid)] =
          teamval;
    }
    notifyListeners();
  }
}
