import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_app_flutter/Helper/db_helper.dart';
import 'package:team_app_flutter/Helper/switch_provider.dart';
import '../../main.dart';
import 'emp_add_item.dart';

class EmpListItem extends StatelessWidget {
  final Map<String, dynamic> empDataMap;
  EmpListItem(this.empDataMap);

  List<Widget> buildchip(List<Map<String, dynamic>> _teamData) {
    List<Widget> chip;
    if (_teamData != null && _teamData.isNotEmpty) {
      chip = _teamData
          .map((mapData) => Chip(label: new Text(mapData['tname'])))
          .toList();
    } else {
      chip = List<Widget>();
    }
    return chip;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(4),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Row(
            children: [
              new Expanded(
                child: new Text(
                  this.empDataMap['ename'] ?? ''.toString(),
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                ),
              ),
              new Row(children: [
                new IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EmpAddItem(EditMode.UPDATE,
                                  empDatamap: this.empDataMap)));
                    }),
                new IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      print(this.empDataMap.toString());
                    })
              ]),
            ],
          ),
          SizedBox(height: 2),
          new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Expanded(
                  child: new Text(
                      'Age : ' + this.empDataMap['age'].toString() ?? '')),
              new Expanded(
                  child: new Text(
                      'City : ' + this.empDataMap['city'].toString() ?? ''))
            ],
          ),
          this.empDataMap['istl'] != null && this.empDataMap['istl'] != 1
              ? Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: new Text(
                      'Team Lead : ' + this.empDataMap['tlname'].toString()),
                )
              : new Container(),
          SizedBox(height: 2),
          FutureBuilder(
            future: DataBaseHelper().getTeammembr(this.empDataMap['empid']),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 4,
                  children: buildchip(snapshot.data),
                );
              }
              return SizedBox(height: 50);
            },
          ),
        ],
      ),
    );
  }
}
