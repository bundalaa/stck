import 'package:flutter/material.dart';
import 'package:stck/drawer.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('STOCK CONTROL'),
      ),
      drawer: Container(
          //height:MediaQuery.of(context).size.height *80/100,
          width: MediaQuery.of(context).size.width * 80 / 100,
          child: DrawerPage()),
      body: Center(
        child: Text(
          'grace stock control',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
