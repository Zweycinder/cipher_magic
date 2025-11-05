import 'dart:io';

import 'package:cipher_magic/cipher/algorithms/substitution.dart';
import 'package:cipher_magic/cipher/algorithms/tansposition.dart';
import 'package:cipher_magic/cipher/algorithms/top_secret_magic.dart';
import 'package:cipher_magic/rasberscreen.dart';
import 'package:cipher_magic/widgets/my_textfeild.dart';
import 'package:cipher_magic/widgets/mysnackbar.dart';
import 'package:flutter/material.dart';

class CipherHomePage extends StatefulWidget {
  const CipherHomePage({super.key});

  @override
  State<CipherHomePage> createState() => _CipherHomePageState();
}

class _CipherHomePageState extends State<CipherHomePage> {
  String selectedType = 'Substitution';
  String selectedCipher = 'Caesar Cipher And Diract standerd';
  final TextEditingController inputController = TextEditingController();
  final TextEditingController outputController = TextEditingController();
  final TextEditingController keyController = TextEditingController();
  final TextEditingController key2Controller = TextEditingController();

  final Map<String, List<String>> cipherTypes = {
    'Substitution': [
      'Caesar Cipher And Diract standerd',
      'Standard Reverse Cipher',
      'Keyword Cipher',
      'Multiplicative Cipher',
      'Affine Cipher',
      'Playfair Cipher',
    ],
    'Transposition': [
      'Reverse Cipher',
      'Rail Fence Cipher',
      'Columnar Cipher',
      'Double Columnar Cipher',
      'Row Cipher',
      'Nihilist Cipher',
    ],
    'Top Secret Magic': ['FBI level secrets'],
  };

  String getKeyHint() {
    switch (selectedCipher) {
      case 'Caesar Cipher And Diract standerd':
        return 'Enter shift value (e.g., 3)';
      case 'Keyword Cipher':
        return 'Enter keyword (e.g., abyss)';
      case 'Multiplicative Cipher':
        return 'Enter GCD number (e.g., 1,3,5,7,9..)';
      case 'Affine Cipher':
        return 'Enter GCD number (e.g., 1,3,5,7,9..)';
      case 'Rail Fence Cipher':
        return 'Enter number of rails (e.g., 3)';
      case 'Columnar Cipher':
        return 'key: e.g, 3, 2134, word';
      case 'Double Columnar Cipher':
        return 'key: e.g, 3, 2134, word';
      case 'Row Cipher':
        return 'key: e.g, 2134';
      case 'Nihilist Cipher':
        return 'Enter Word key: e.g word';
      case 'FBI level secrets':
        return 'Enter number Key: e.g 3';
      default:
        return '';
    }
  }

  String getKey2Hint() {
    switch (selectedCipher) {
      case 'Keyword Cipher':
        return 'Enter shift key (e.g., 3)';
      case 'Affine Cipher':
        return 'Enter shift key';
      case 'Double Columnar Cipher':
        return 'key: e.g, 3, 2134, word';
      default:
        return '';
    }
  }

  bool requiresKey() {
    return getKeyHint().isNotEmpty;
  }

  bool requiresTwoKeys() {
    return getKey2Hint().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple.shade50, Colors.blue.shade50],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Rasberscreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.security,
                                color: Colors.deepPurple.shade700,
                                size: 32,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Cipher Algorithms',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2D3748),
                                ),
                              ),
                              Text(
                                'Information Security',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text('Made by:'),
                      const Text(
                        'Mohammed Abdulsalam (Zwey)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3748),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('Supervised by:'),
                      const Text(
                        'Assist.Prof.Dr.Rasper Dh. Rashid',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3748),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select Cipher',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3748),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedType,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.deepPurple.shade700,
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF2D3748),
                            ),
                            items: cipherTypes.keys.map((String type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Row(
                                  children: [
                                    Icon(
                                      type == 'Substitution'
                                          ? Icons.swap_horiz
                                          : Icons.compare_arrows,
                                      color: Colors.deepPurple.shade700,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(type),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedType = newValue!;
                                selectedCipher = cipherTypes[selectedType]![0];
                                outputController.clear();
                                keyController.clear();
                                key2Controller.clear();
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.deepPurple.shade200),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedCipher,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.deepPurple.shade700,
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.deepPurple.shade900,
                            ),
                            items: cipherTypes[selectedType]!.map((
                              String cipher,
                            ) {
                              return DropdownMenuItem<String>(
                                value: cipher,
                                child: Text(cipher),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCipher = newValue!;
                                outputController.clear();
                                keyController.clear();
                                key2Controller.clear();
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // First Key Field
                if (requiresKey())
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.vpn_key,
                              color: Colors.deepPurple.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              requiresTwoKeys() ? 'Key 1' : 'Key',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D3748),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: keyController,
                          decoration: InputDecoration(
                            hintText: getKeyHint(),
                            filled: true,
                            fillColor: Colors.grey.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.all(16),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (requiresKey()) const SizedBox(height: 24),

                // Second Key Field
                if (requiresTwoKeys())
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.vpn_key,
                              color: Colors.deepPurple.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Key 2',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D3748),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: key2Controller,
                          decoration: InputDecoration(
                            hintText: getKey2Hint(),
                            filled: true,
                            fillColor: Colors.grey.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.all(16),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (requiresTwoKeys()) const SizedBox(height: 24),

                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.input,
                            color: Colors.blue.shade700,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Input Message',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D3748),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: inputController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Enter your message here...',
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: encrypt,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple.shade600,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.lock, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Encrypt',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: decrypt,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade600,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.lock_open, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Decrypt',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.output,
                            color: Colors.green.shade700,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Output Message',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D3748),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      MyTextfeild(textcontroller: outputController),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void encrypt() {
    String input = inputController.text;
    String output = '';

    if (input.isEmpty) {
      showSnackBar('Please enter a message to encrypt', context);
      return;
    }

    switch (selectedCipher) {
      case 'Caesar Cipher And Diract standerd':
        output = Substitution().caesarEncrypt(input, keyController.text);
        break;
      case 'Standard Reverse Cipher':
        output = Substitution().standardReverseEncrypt(
          input,
          keyController.text,
        );
        break;
      case 'Keyword Cipher':
        output = Substitution().keywordEncrypt(
          input,
          keyController.text,
          key2Controller.text,
        );
        break;
      case 'Multiplicative Cipher':
        output = Substitution().multiplicativeEncrypt(
          input,
          keyController.text,
        );
        break;
      case 'Affine Cipher':
        output = Substitution().affineEncrypt(
          input,
          keyController.text,
          key2Controller.text,
        );
        break;
      case 'Playfair Cipher':
        output = Substitution().playfairEncrypt(input, keyController.text);
        break;

      case 'Reverse Cipher':
        output = Transposition().reverseEncryptDecrypt(input);
        break;
      case 'Rail Fence Cipher':
        output = Transposition().railFenceEncrypt(input, keyController.text);
        break;
      case 'Columnar Cipher':
        output = Transposition().columnarEncrypt(input, keyController.text);
        break;
      case 'Double Columnar Cipher':
        output = Transposition().doubleColumnarEncrypt(
          input,
          keyController.text,
          key2Controller.text,
        );
        break;
      case 'Row Cipher':
        output = Transposition().rowEncrypt(input, keyController.text);
        break;
      case 'Nihilist Cipher':
        output = Transposition().nihilistEncrypt(input, keyController.text);
        break;

      case 'FBI level secrets':
        output = TopSecretMagic().encryptToEmojis(input, keyController.text);
        break;
    }

    setState(() {
      outputController.text = output;
    });
  }

  void decrypt() {
    String input = inputController.text;
    String output = '';

    if (input.isEmpty) {
      showSnackBar('Please enter a message to decrypt', context);
      return;
    }

    switch (selectedCipher) {
      case 'Caesar Cipher And Diract standerd':
        output = Substitution().caesarDecrypt(input, keyController.text);
        break;
      case 'Standard Reverse Cipher':
        output = Substitution().standardReverseDecrypt(
          input,
          keyController.text,
        );
        break;
      case 'Keyword Cipher':
        output = Substitution().keywordDecrypt(
          input,
          keyController.text,
          key2Controller.text,
        );
        break;
      case 'Multiplicative Cipher':
        output = Substitution().multiplicativeDecrypt(
          input,
          keyController.text,
        );
        break;
      case 'Affine Cipher':
        output = Substitution().affineDecrypt(
          input,
          keyController.text,
          key2Controller.text,
        );
        break;
      case 'Playfair Cipher':
        output = Substitution().playfairDecrypt(input, keyController.text);
        break;

      case 'Reverse Cipher':
        output = Transposition().reverseEncryptDecrypt(input);
        break;
      case 'Rail Fence Cipher':
        output = Transposition().railFenceDecrypt(input, keyController.text);
        break;
      case 'Columnar Cipher':
        output = Transposition().columnarDecrypt(input, keyController.text);
        break;
      case 'Double Columnar Cipher':
        output = Transposition().doubleColumnarDecrypt(
          input,
          keyController.text,
          key2Controller.text,
        );
        break;
      case 'Row Cipher':
        output = Transposition().rowDecrypt(input, keyController.text);
        break;
      case 'Nihilist Cipher':
        output = Transposition().nihilistDecrypt(input, keyController.text);
        break;

      case 'FBI level secrets':
        output = TopSecretMagic().decryptFromEmojis(input, keyController.text);
        break;
    }

    setState(() {
      outputController.text = output;
    });
  }
}
