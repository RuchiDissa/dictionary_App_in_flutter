import 'package:dictionary/DbHelper.dart';
import 'package:flutter/material.dart';
import 'dart:io'; // for File class
import 'package:image_picker/image_picker.dart'; // for picking images

class wordlist extends StatefulWidget {
  const wordlist({Key? key}) : super(key: key);

  @override
  _wordlistState createState() => _wordlistState();
}

class _wordlistState extends State<wordlist> {
  List<Map<String, dynamic>> words = [];
  final englishController = TextEditingController();
  final turkishController = TextEditingController();
  String? _imagePath;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getWords();
  }

  void getWords() async {
    final data = await DbHelper.getAll();
    setState(() {
      words = data;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 232, 174),
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'Dictionary',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Image.asset(
            'lib/images/dic.png',
            height: 250,
            width: 300,
            fit: BoxFit.fill,
          ),
          const Divider(),
          const Text(
            "List Of Words",
            style: TextStyle(
                color: Color.fromARGB(255, 4, 0, 126),
                fontWeight: FontWeight.bold,
                fontSize: 30),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: words.length,
              itemBuilder: (_, i) {
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
                        subtitle: Text("${words[i]["EngWord"]}"),
                      ),
                      ListTile(
                        title: const Text(
                          'Turkish Word:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue,
                          ),
                        ),
                        subtitle: Text("${words[i]["TrWord"]}"),
                        trailing: IconButton(
                          onPressed: () {
                            showEditBox(
                              words[i]["id"],
                              words[i]["EngWord"],
                              words[i]["TrWord"],
                              words[i]["imagePath"],
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'Created:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue,
                          ),
                        ),
                        subtitle: Text("${words[i]["created"]}"),
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: const Text('Delete'),
                                content: const Text('Are you sure?'),
                                actions: [
                                  OutlinedButton(
                                    onPressed: () {
                                      DbHelper.deleteInfo(words[i]["id"]);
                                      getWords();
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Yes'),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('No'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      if (words[i]["imagePath"] != null)
                        Image.file(
                          File(words[i]["imagePath"]),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void showEditBox(int id, String engWord, String trWord, String? imagePath) {
    setState(() {
      englishController.text = engWord;
      turkishController.text = trWord;
      _imagePath = imagePath;
    });
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Edit', style: TextStyle(color: Colors.lightBlue)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: englishController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'English word',
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: turkishController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Turkish word',
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              MaterialButton(
                onPressed: _pickImage,
                height: 50,
                minWidth: double.infinity,
                color: Colors.lightBlue,
                child: const Text('Pick Image'),
              ),
            ],
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel',
                  style: TextStyle(color: Colors.lightBlue)),
            ),
            OutlinedButton(
              onPressed: () async {
                await DbHelper.updateInfo(
                  id: id,
                  EngWord: englishController.text.trim(),
                  TrWord: turkishController.text.trim(),
                  imagePath: _imagePath,
                );
                Navigator.pop(context);
                getWords();
              },
              child: const Text('Update',
                  style: TextStyle(color: Colors.lightBlue)),
            ),
          ],
        );
      },
    );
  }
}
