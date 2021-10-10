import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:w10_filepicker/file_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FilePickerResult? result;
  PlatformFile? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Picker"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                pickFiless();
              },
              child: Text("Pick File"),
            ),
            (file == null)
                ? Container()
                : Image.file(
                    File(file!.path.toString()),
                    width: 150,
                    height: 150,
                  ),
          ],
        ),
      ),
    );
  }

  void pickFiless() async {
    result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );
    if (result == null) return;
    loadSelectedFile(result!.files);
  }

  void loadSelectedFile(List<PlatformFile> files) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FileList(files: files, onOpenedFile: viewFile)));
  }

  void viewFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
}
