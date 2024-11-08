import 'package:flutter/material.dart';

class IdentifyLeafPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Identify Leaf'),
      ),
      body: Center(
        child: Text(
          'This is the Identify Leaf Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
