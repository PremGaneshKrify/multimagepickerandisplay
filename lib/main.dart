import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<XFile>? _imageFileList;
  final ImagePicker _picker = ImagePicker();
  Widget _previewImages() {
    if (_imageFileList != null) {
      return GridView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Image.file(File(_imageFileList![index].path));
        },
        itemCount: _imageFileList!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('image picker'),
      ),
      body: _previewImages(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final List<XFile> pickedFileList = await _picker.pickMultiImage();
          setState(() {
            _imageFileList = pickedFileList;
          });
        },
        child: const Icon(Icons.photo_library),
      ),
    );
  }
}
