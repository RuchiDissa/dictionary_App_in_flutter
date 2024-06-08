import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dictionary/DbHelper.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<search> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 232, 174),
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'Search',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'lib/images/man.png', // Adjust the path as necessary
                height: 300, // Adjust the height as necessary
                fit: BoxFit.cover, // Adjust the fit as necessary
              ),
              const Divider(),
              const Text(
                'Search Words You Want',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 4, 0, 126),
                ),
              ),
              const Divider(),
              const SizedBox(height: 20),
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Enter word',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () async {
                        setState(() {
                          _isSearching = true;
                        });
                        String searchText = _searchController.text.trim();
                        if (searchText.isNotEmpty) {
                          List<Map<String, dynamic>> results =
                              await DbHelper.searchWord(searchText);
                          setState(() {
                            _searchResults = results;
                            _isSearching = false;
                          });
                        }
                      },
                      color: Colors.lightBlue,
                      textColor: Colors.white,
                      child: const Text('Search'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          _searchResults = [];
                        });
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                      child: const Text('Clear'),
                    ),
                  ),
                ],
              ),
              const Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.4, // Adjust the height as needed
                child: _isSearching
                    ? const Center(child: CircularProgressIndicator())
                    : _searchResults.isEmpty
                        ? const Center(
                            child: Text(
                              'Word not found',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _searchResults.length,
                            itemBuilder: (context, index) {
                              String? imagePath =
                                  _searchResults[index]["imagePath"];
                              Widget imageWidget = SizedBox.shrink();

                              if (imagePath != null && imagePath.isNotEmpty) {
                                File imageFile = File(imagePath);
                                if (imageFile.existsSync()) {
                                  imageWidget = Image.file(
                                    imageFile,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  );
                                }
                              }

                              return Card(
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      title: const Text(
                                        'English Word:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue,
                                        ),
                                      ),
                                      subtitle: Text(
                                          "${_searchResults[index]["EngWord"]}"),
                                    ),
                                    ListTile(
                                      title: const Text(
                                        'Turkish Word:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue,
                                        ),
                                      ),
                                      subtitle: Text(
                                          "${_searchResults[index]["TrWord"]}"),
                                    ),
                                    imageWidget,
                                  ],
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
