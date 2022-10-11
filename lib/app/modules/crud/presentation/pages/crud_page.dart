import 'package:flutter/material.dart';

class CrudPage extends StatefulWidget {
  final String title;
  const CrudPage({Key? key, this.title = 'CrudPage'}) : super(key: key);
  @override
  CrudPageState createState() => CrudPageState();
}
class CrudPageState extends State<CrudPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}