import 'package:flutter/material.dart';

class TeamListItem extends StatelessWidget {
  final int teamid;
  final String teamname;

  TeamListItem(this.teamid, this.teamname);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(12),
      child: new InkWell(
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
                new IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                new IconButton(icon: Icon(Icons.delete), onPressed: () {})
              ],
            )
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
