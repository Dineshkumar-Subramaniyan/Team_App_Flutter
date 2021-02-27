import 'package:flutter/material.dart';
import 'package:team_app_flutter/views/employee/emp_list_item.dart';

class EmpListScreen extends StatelessWidget {
  static const route = 'emp-list';

  Widget fabWidget(BuildContext ctxt) {
    return FloatingActionButton(onPressed: () {}, child: new Icon(Icons.add));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      floatingActionButton: fabWidget(context),
      appBar: AppBar(title: Text("Employee Names")),
      body: new ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            Map<String, dynamic> map = {
              'empid': 5,
              'ename': 'Dinesh',
              'age': 55,
              'city': 'chennai',
              'istl': 0,
              'tlname': 'raj'
            };
            return EmpListItem(map);
          }),
    );
  }
}
