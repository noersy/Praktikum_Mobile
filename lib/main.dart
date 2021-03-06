import 'package:flutter/material.dart';
import 'package:modul3/View/SplashScreenPage/SplashScreenPage.dart';
import 'package:modul3/provider/ConsoleProvider.dart';
import 'package:modul3/provider/ProfileProvider.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ConsoleProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SplashScreenPage(),
        ),
      ),
    );

    /*MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardPage(username: "username", fullname: ""),
    );*/
  }
}
