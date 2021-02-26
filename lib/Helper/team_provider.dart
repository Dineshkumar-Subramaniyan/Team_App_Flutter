import 'package:flutter/cupertino.dart';
import 'package:team_app_flutter/models/team_model.dart';
import 'db_helper.dart';

class TeamAppProvider with ChangeNotifier{
List _teamData = [];

List get teamData{
  return [..._teamData];
}

Future getTeamData()async{
final teamlist  = await DataBaseHelper().getDataFromDB('team');
_teamData =  teamlist.map((item) =>TeamModel(item['teamid'],item['tname'])).toList();
notifyListeners();
}

}