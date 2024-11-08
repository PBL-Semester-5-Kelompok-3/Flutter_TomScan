import 'package:flutter/material.dart';

class InformativePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informative'),
      ),
      body: Center(
        child: Text(
          'This is the Informative Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
