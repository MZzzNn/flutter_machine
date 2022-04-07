import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';



class FireBaseMachineScreen extends StatefulWidget {
  @override
  _FireBaseMachineScreenState createState() => _FireBaseMachineScreenState();
}

class _FireBaseMachineScreenState extends State<FireBaseMachineScreen> {
  File _image;
  final picker = ImagePicker();
  final ImageLabeler imageLabeler = FirebaseVision.instance.imageLabeler();
  var result;
  bool loading = false;

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        processImageLabels();
      } else {
        print('No image selected.');
      }
    });
  }

  processImageLabels() async {
    loading =true;
    FirebaseVisionImage myImage = FirebaseVisionImage.fromFile(_image);
    ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
    var _imageLabels = await labeler.processImage(myImage);
    result = "";
    for (ImageLabel imageLabel in _imageLabels) {
      setState(() {
        result = result + imageLabel.text + ":" + imageLabel.confidence.toString() + "\n";
        loading = false;
      });
    }
  }

  void update(){
    _image =null;
    result =null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FireBase Model Machine'),
        actions: [
          IconButton(
              onPressed: update,
              icon: Icon(Icons.update)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child:_image != null ?
              Image.file(_image,height:400 , width: double.infinity, fit: BoxFit.contain,):
              Image.asset(
                'assets/images/img.png',
                fit: BoxFit.cover,
                height: 220,
                width: double.infinity,
              ),
            ),

            SizedBox(height: 15,),

            if(result == null)
              Text(
                'FireBase Model will scan the image and tell you the results.',
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),

            if(result != null)
              loading? CircularProgressIndicator() :
              Container(
                child: Center(
                  child: Text(
                    result,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
