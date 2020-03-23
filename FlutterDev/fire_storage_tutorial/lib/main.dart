import 'dart:io';


import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String fileType = '';
  File file;
  String fileName = '';
  String operationText = '';
  bool isUploaded = true;
  String result = '';

  //Asynchronous method to get the file to send
  Future filePicker(BuildContext context) async {
    try {
      if (fileType == 'image') {
        file = await FilePicker.getFile(type: FileType.IMAGE);
        setState(() {
          fileName = p.basename(file.path);   //Gets the name of file after the last separator (i.e. /path/.../file_name.png => filename.png)
        });
        print(fileName);
        _uploadFile(file, fileName);
      }
      if (fileType == 'audio') {
        file = await FilePicker.getFile(type: FileType.AUDIO);
        fileName = p.basename(file.path);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        _uploadFile(file, fileName);
      }
      if (fileType == 'video') {
        file = await FilePicker.getFile(type: FileType.VIDEO);
        fileName = p.basename(file.path);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        _uploadFile(file, fileName);
      }
      if (fileType == 'pdf') {
        file = await FilePicker.getFile(type: FileType.CUSTOM, fileExtension: 'pdf');
        fileName = p.basename(file.path);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        _uploadFile(file, fileName);
      }
      if (fileType == 'others') {
        file = await FilePicker.getFile(type: FileType.ANY);
        fileName = p.basename(file.path);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        _uploadFile(file, fileName);
      }
    } on PlatformException catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sorry...'),
              content: Text('Unsupported exception: $e'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
        );
    }
  }

  //Method to upload the file to the firebase storage server
  Future<void> _uploadFile(File file, String filename) async {
    StorageReference storageReference;
    if (fileType == 'image') {
      //Creates a reference name for the file to be stored on Firebase
      storageReference = 
        FirebaseStorage.instance.ref().child("images/$filename");
    }
    if (fileType == 'audio') {
      storageReference = 
        FirebaseStorage.instance.ref().child("audio/$filename");
    }
    if (fileType == 'video') {
      storageReference = 
        FirebaseStorage.instance.ref().child("videos/$filename");
    }
    if (fileType == 'pdf') {
      storageReference = 
        FirebaseStorage.instance.ref().child("pdf/$filename");
    }
    if (fileType == 'others') {
      storageReference = 
        FirebaseStorage.instance.ref().child("others/$filename");
    }

    //Upload the file to the firebase storage
    final StorageUploadTask uploadTask = storageReference.putFile(file);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    //Get the downloadUrl for downloading images later
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Center(
        child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('Image', style: TextStyle(color: Colors.white),),
                leading: Icon(Icons.image, color: Colors.redAccent,),
                onTap: () {
                  setState(() {
                    fileType = 'image';
                  });
                  filePicker(context);
                },
              ),
              ListTile(
                title: Text('Audio', style: TextStyle(color: Colors.white),),
                leading: Icon(Icons.audiotrack, color: Colors.redAccent,),
                onTap: () {
                  setState(() {
                    fileType = 'audio';
                  });
                  filePicker(context);
                },
              ),
              ListTile(
                title: Text('Video', style: TextStyle(color: Colors.white),),
                leading: Icon(Icons.video_label, color: Colors.redAccent,),
                onTap: () {
                  setState(() {
                    fileType = 'video';
                  });
                  filePicker(context);
                },
              ),
              ListTile(
                title: Text('PDF', style: TextStyle(color: Colors.white),),
                leading: Icon(Icons.pages, color: Colors.redAccent,),
                onTap: () {
                  setState(() {
                    fileType = 'pdf';
                  });
                  filePicker(context);
                },
              ),
              ListTile(
                title: Text('Others', style: TextStyle(color: Colors.white),),
                leading: Icon(Icons.attach_file, color: Colors.redAccent,),
                onTap: () {
                  setState(() {
                    fileType = 'others';
                  });
                  filePicker(context);
                },
              ),
              SizedBox(height: 50,),
              Text(result, style: TextStyle(color: Colors.blue),)
            ],
          ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.cloud_upload
              ), 
              onPressed: () {},
            ),
            
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Firestorage Demo', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}


