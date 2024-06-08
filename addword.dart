import 'package:dictionary/DbHelper.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class addword extends StatefulWidget {
  const addword({Key? key}) : super(key: key);

  @override
  State<addword> createState() => _addwordState();
}

class _addwordState extends State<addword> {
  final englishController = TextEditingController();
  final turkishController = TextEditingController();
  String? _imagePath;
  List words = [];

  final ImagePicker _picker = ImagePicker();

  void getWords() async {
    final data = await DbHelper.getAll();
    setState(() {
      words = data;
    });
  }

  @override
  void initState() {
    getWords();
    super.initState();
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
          'Add Word',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'lib/images/addword.png',
                      width: 400,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Divider(),
                  const Text(
                    'Add Words',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 4, 0, 126),
                    ),
                  ),
                  const Divider(),
                  TextField(
                    controller: englishController,
                    decoration: InputDecoration(
                      labelText: 'English Word',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: turkishController,
                    decoration: InputDecoration(
                      labelText: 'Turkish Word',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    onPressed: _pickImage,
                    height: 50,
                    minWidth: double.infinity,
                    color: Colors.lightBlue,
                    child: const Text('Pick Image'),
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    onPressed: () async {
                      int res = await DbHelper.addWord(
                        EngWord: englishController.text.trim(),
                        TrWord: turkishController.text.trim(),
                        imagePath: _imagePath,
                      );
                      if (res > 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Word was added")),
                        );
                        englishController.clear();
                        turkishController.clear();
                        setState(() {
                          _imagePath = null;
                        });
                        getWords();
                      }
                    },
                    height: 50,
                    minWidth: double.infinity,
                    color: Colors.lightBlue,
                    child: const Text('Add Words'),
                  ),
                  const Divider(),
                  const Text(
                    "Word list",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 4, 0, 126),
                    ),
                  ),
                  const Divider(),
                  ListView.builder(
                    itemCount: words.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
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
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
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
                                ],
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showEditBox(int id, String EngWord, String TrWord, String imagePath) {
    setState(() {
      englishController.text = EngWord;
      turkishController.text = TrWord;
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
