import 'package:flutter/material.dart';

class Rasberscreen extends StatelessWidget {
  const Rasberscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Image.asset('assets/drrasper.png')),
    );
  }
}
