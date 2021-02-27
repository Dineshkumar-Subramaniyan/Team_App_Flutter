import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_app_flutter/Helper/switch_provider.dart';
import 'package:team_app_flutter/main.dart';
import 'package:team_app_flutter/views/employee/emp_list_item.dart';
import 'emp_add_item.dart';
import 'package:team_app_flutter/models/emp_model.dart';

class EmpListScreen extends StatelessWidget {
  static const route = 'emp-list';

  Widget fabWidget(BuildContext ctxt) {
    return FloatingActionButton(
        onPressed: () {
          Navigator.push(
              ctxt,
              MaterialPageRoute(
                  builder: (context) => EmpAddItem(EditMode.ADD)));
        },
        child: new Icon(Icons.add));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      floatingActionButton: fabWidget(context),
      appBar: AppBar(title: Text("Employee Names")),
      body: FutureBuilder(
        future:
            Provider.of<SwitchProvider>(context, listen: false).getEmpData(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return new Center(
              child: new CircularProgressIndicator(),
            );
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              return Consumer<SwitchProvider>(
                child: new Center(
                  child: Text('No Employee Data Exist',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                ),
                builder: (context, empProvider, child) =>
                    empProvider.empData.length <= 0
                        ? child
                        : new ListView.builder(
                            itemCount: empProvider.empData.length,
                            itemBuilder: (context, index) {
                              final empData =
                                  EmpModel.toMap(empProvider.empData[index]);
                              return EmpListItem(empData);
                            }),
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}
