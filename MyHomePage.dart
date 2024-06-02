import 'package:flutter/material.dart';
import 'package:dictionary/addword.dart';
import 'package:dictionary/search.dart';
import 'package:dictionary/wordlist.dart';
import 'package:dictionary/AppDrawer.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 232, 174),
      appBar: AppBar(
        title: const Text(
          'Dictionary App',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  const Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 4, 0, 126),
                    ),
                  ),
                  const Divider(),
                  const Text(
                    'This is a dictionary for English to Turkish language. Find some words!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 4, 0, 126),
                    ),
                  ),
                  const Divider(),
                  ClipRect(
                    child: Container(
                      height: 250,
                      width: 250,
                      child: Image.asset(
                        'lib/images/world.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Choose an action:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 4, 0, 126),
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => wordlist()));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            'lib/images/listw.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Dictionary',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 4, 0, 126),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => search()));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            'lib/images/search.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Search',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 4, 0, 126),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => addword()));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            'lib/images/add.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Add Word',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 4, 0, 126),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
      drawer: const AppDrawer(),
    );
  }
}
