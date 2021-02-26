import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_app_flutter/Helper/team_provider.dart';

import '../../main.dart';
import 'team_add_item.dart';

class TeamListItem extends StatelessWidget {
  final int teamid;
  final String teamname;

  TeamListItem(this.teamid, this.teamname);

  @override
  Widget build(BuildContext context) {
   
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(12),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          new Expanded(
            child: new Text(
              teamname,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
          new Row(
            children: [
              new IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (ctxt) => TeamAddItem(
                            teamid: this.teamid,
                            teamname: this.teamname,
                            editMode: EditMode.UPDATE));
                  }),
              new IconButton(icon: Icon(Icons.delete), onPressed: () {
Provider.of<TeamAppProvider>(context,listen:false).deleteTeamCheck(context, teamid,teamname);


              })
            ],
          )
        ],
      ),
    );
  }
}
