import 'package:flutter/material.dart';

class Rasberscreen extends StatelessWidget {
  const Rasberscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ascii art of Doctor Rasper')),
      body: Align(
        alignment: AlignmentGeometry.topCenter,
        child: Image.asset('assets/drrasper.png'),
      ),
    );
  }
}
