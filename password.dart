import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dictionary/MyHomePage.dart';

class password extends StatefulWidget {
  const password({Key? key}) : super(key: key);

  @override
  State<password> createState() => _passwordState();
}

class _passwordState extends State<password> {
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _readPasswordFromFile();
  }

  Future<void> _readPasswordFromFile() async {
    try {
      final file = File('"/lib/password.txt"');
      final contents = await file.readAsString();
      passwordController.text = contents;
    } catch (e) {
      print('Error reading password file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 232, 174),
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'User',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'lib/images/password.png',
                  width: 400,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              const Divider(),
              const Text(
                'Enter password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 4, 0, 126),
                ),
              ),
              const Divider(),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: () {
                  String password = passwordController.text;
                  print('Submitted password: $password');

                  if (password.isNotEmpty) {
                    if (password == 'user') {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MyHomePage()));
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text(
                                'Incorrect password. Please try again.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                color: Colors.lightBlue,
                textColor: Colors.white,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
