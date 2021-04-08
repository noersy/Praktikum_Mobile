import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black45,
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          GridView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            ),
            children: [
              Card(child: Center(child: Text("Text")),),
              Card(child: Center(child: Text("Text")),),
              Card(child: Center(child: Text("Text")),),
              Card(child: Center(child: Text("Text")),),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Card(child: Container(height : 150,child: Center(child: Text("Text")))),
          ),
        ],
      ),
    );
  }
}