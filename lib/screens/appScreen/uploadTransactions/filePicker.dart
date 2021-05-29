
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'loadCsvDataScreen.dart';
import 'package:path_provider/path_provider.dart';



class FilePickr extends StatefulWidget {
  const FilePickr({Key key}) : super(key: key);

  @override
  FilePickrState createState() => FilePickrState();
}

class FilePickrState extends State<FilePickr> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  height: 50,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      loadCsvFromStorage();
                    },
                    color: Colors.orange,
                    child: Text("Load csv form phone storage"),
                  ),
                IconButton(
                  iconSize: 40,
                    onPressed:  (){
                    loadCsvFromStorage();
                    },
                    icon: Icon(Icons.cloud_upload_rounded,)
                )
              ],
            )
          ),
          SizedBox(height: 20,),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  height: 50,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () {

                  },
                  color: Colors.orangeAccent,
                  child: Text("Load Uploaded csv"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  loadCsvFromStorage() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['.xlsx'],
      type: FileType.custom
    );
    String path = result.files.first.path;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return LoadCsvDataScreen(path: path);
        },
      ),
    );
  }




}