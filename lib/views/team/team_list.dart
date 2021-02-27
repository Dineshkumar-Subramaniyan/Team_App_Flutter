import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_app_flutter/models/team_model.dart';
import 'package:team_app_flutter/views/team/team_add_item.dart';
import 'package:team_app_flutter/views/team/team_list_item.dart';
import 'package:team_app_flutter/Helper/team_provider.dart';
import '../../main.dart';

class TeamListScreen extends StatelessWidget {
  static const route = 'team-list';

  Widget fabWidget(BuildContext ctxt) {
    return FloatingActionButton(
        onPressed: () {
          showDialog(
              barrierDismissible: false,
              context: ctxt,
              builder: (ctxt) => TeamAddItem(editMode: EditMode.ADD));
        },
        child: new Icon(Icons.add));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: Text('Team Names')),
      body: FutureBuilder(
        future:
            Provider.of<TeamAppProvider>(context, listen: false).getTeamData(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return new Center(
              child: new CircularProgressIndicator(),
            );
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              return Consumer<TeamAppProvider>(
                  child: new Center(
                    child: Text('No Team Data Exist',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400)),
                  ),
                  builder: (context, teamAppProvider, child) =>
                      teamAppProvider.teamData.length <= 0
                          ? child
                          : ListView.builder(
                              itemCount: teamAppProvider.teamData.length,
                              itemBuilder: (context, index) {
                                final tData = TeamModel.toMap(
                                    teamAppProvider.teamData[index]);

                                return TeamListItem(
                                    tData['tid'], tData['tname'].toString());
                              },
                            ));
            }
          }
          return Container();
        },
      ),
      floatingActionButton: fabWidget(context),
    );
  }
}
