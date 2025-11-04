import 'package:cipher_magic/homescreen.dart';
import 'package:flutter/material.dart';

// reverse cipher
// rail fence cipher
// geometric figure cipher
// columnar transposition cipher
// double columnar transposition cipher
// row transposition ciphers
// nihilist transposition cipher
// some algorith can have keys like this,  keys can be number of length, given number of columns like 1432, and word

// caesar's cipher
// direct standard
// standard reverse
// keyword cipher
// multiplicative cipher
// addine cipher
// playfair cipher

void main() {
  runApp(const CipherApp());
}

class CipherApp extends StatelessWidget {
  const CipherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cipher Algorithms',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        useMaterial3: true,
      ),
      home: const CipherHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
