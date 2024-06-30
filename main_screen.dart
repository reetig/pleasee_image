import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  File? _selectedFile;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _cropImage(pickedFile.path);
    }
  }

  Future<void> _cropImage(String path) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        uiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );

    if (croppedFile != null) {
      setState(() {
        _selectedFile = croppedFile as File?;
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedFile == null) return;

    // Implement your upload logic here using dio or any other HTTP client
    // For example:
    // var response = await Dio().post('https://yourserver.com/upload', data: FormData.fromMap({'file': await MultipartFile.fromFile(_selectedFile.path)}));
    // print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add/Upload Image'),
      ),
      body: Center(
        child: Container(
          height: 100,
          width: 200,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _selectedFile != null ? Image.file(_selectedFile!) : Text('No image selected.'),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('choose from device'),
              ),
              ElevatedButton(
                onPressed: _uploadImage,
                child: Text('Upload Image'),
              ),
            ],
          ),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.black
              )
          ),
        ),
      ),
    );
  }
}

