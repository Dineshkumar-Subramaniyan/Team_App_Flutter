class TeamModel {
  int _teamid;
  String _tname;

  TeamModel(this._teamid, this._tname);

  int get id => _teamid;
  String get tname => _tname;


static Map<String, dynamic> toMap(dynamic teamDModel) {
    return {
      'tid': teamDModel._teamid,
      'tname': teamDModel.tname,
    };
  }

}
