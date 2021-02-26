import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget menuName(String name) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(12),
      child:
          new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        new Text(name,
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500)),
        new Icon(Icons.arrow_forward_ios)
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.98),
        appBar: new AppBar(
          title: new Text('Home Screen'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: new Column(
          children: <Widget>[
            new GestureDetector(onTap: () {}, child: menuName('Team')),
            new GestureDetector(onTap: () {}, child: menuName('Employees'))
          ],
        ));
  }
}
