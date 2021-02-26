import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_app_flutter/views/team/team_list_item.dart';
import 'package:team_app_flutter/Helper/team_provider.dart';

class TeamListScreen extends StatelessWidget {
  static const route = 'team-list';

  Widget fabWidget() {
    return FloatingActionButton(onPressed: () {}, child: new Icon(Icons.add));
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
              return new Consumer<TeamAppProvider>(
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
                          : TeamListItem(
                              1, "Team name"));
            }
          }
          return Container();
        },
      ),
      floatingActionButton: fabWidget(),
    );
  }
}
