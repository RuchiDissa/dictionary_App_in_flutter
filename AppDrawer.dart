import 'package:dictionary/about.dart';
import 'package:dictionary/addword.dart';
import 'package:dictionary/search.dart';
import 'package:dictionary/wordlist.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blueAccent,
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: ClipRRect(
                      child: Container(
                        height: 200,
                        width: 150,
                        child: Image.asset(
                          'lib/images/flag.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'English to Turkish',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text(
                'Dictionary',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => wordlist()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text(
                'Search',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => search()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text(
                'Add Words',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => addword()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.pageview),
              title: const Text(
                'About',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => about()));
              },
            ),
            const Divider(),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  '2024 All Right Reserved',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
