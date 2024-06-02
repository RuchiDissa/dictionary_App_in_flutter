import 'package:flutter/material.dart';

class about extends StatelessWidget {
  const about({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 232, 174),
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'About',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'lib/images/about.png',
              width: 200,
              height: 200,
              fit: BoxFit.fill,
            ),
          ),
          const Divider(),
          const Text(
            'This is created for the project of mobile application development final project',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
          const Divider(),
          const Text(
            'Student information : ',
            textAlign: TextAlign.center,
          ),
          const Divider(),
          const Text(
            '21815070 Ruchira Dissanayaka',
            textAlign: TextAlign.center,
          ),
          const Text(
            '21906861 DEOGRATIAS WAMPOYI OLEKO',
            textAlign: TextAlign.center,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
