import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_app_flutter/views/employee/emp_list.dart';
import 'package:team_app_flutter/Helper/team_provider.dart';
import 'package:team_app_flutter/Helper/switch_provider.dart';
import 'package:team_app_flutter/views/team/team_list.dart';
import 'views/home_screen.dart';

void main() {
  runApp(MyApp());
}

enum EditMode { ADD, UPDATE }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TeamAppProvider>(
            create: (context) => TeamAppProvider()),
        ChangeNotifierProvider<EmpProvider>(create: (context) => EmpProvider()),
      ],
      child: MaterialApp(
        title: 'Team App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          TeamListScreen.route: (context) => TeamListScreen(),
          EmpListScreen.route: (context) => EmpListScreen(),
        },
      ),
    );
  }
}
