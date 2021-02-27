import 'package:flutter/material.dart';

class EmpListItem extends StatelessWidget {
  final Map<String, dynamic> empDataMap;
  EmpListItem(this.empDataMap);
  final List<Map<String, dynamic>> teamData = [
    {'tname': 'Team1'},
    {'tname': 'Team2'},
    {'tname': 'Team1'},
    {'tname': 'Team2'},
    {'tname': 'Team1'},
    {'tname': 'Team2'}
  ];

  List<Widget> buildchip() {
    List<Widget> chip;
    chip = this
        .teamData
        .map((mapData) => Chip(label: new Text(mapData['tname'])))
        .toList();
    return chip;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(6),
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
                new IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                new IconButton(icon: Icon(Icons.delete), onPressed: () {})
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
         
          this.empDataMap['istl']!=null && this.empDataMap['istl']!=1 ?
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: new Text('Team Lead : '+ this.empDataMap['tlname'].toString()),
          )
          :new Container(),

          SizedBox(height: 2),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 10,
            children: buildchip(),
          ),
        ],
      ),
    );
  }
}
