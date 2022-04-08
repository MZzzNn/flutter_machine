import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'dart:io';

class LocalMachineScreen extends StatefulWidget {
  @override
  _LocalMachineScreenState createState() => _LocalMachineScreenState();
}

class _LocalMachineScreenState extends State<LocalMachineScreen> {
  List<dynamic> result;
  bool loading = false;
  final picker = ImagePicker();
  File _image;

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        loading = true;
        classifyImage(_image);
      } else {
        print('No image selected.');
      }
    });
  }
  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      loading = false;
      if (output == [] || output.isEmpty)
        result = [];
      else
        result = output;
      print(result);
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model/model_unquant.tflite",
      labels: "assets/model/labels.txt",
    );
  }

  @override
  void initState() {
    result = [];
    loading = true;
    loadModel().then((value) {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }
  @override
  void dispose() {
    Tflite.close();
    super.dispose();
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
        title: const Text('Local Model Machine'),
        actions: [
          IconButton(
              onPressed: update,
              icon: Icon(Icons.update)
          )
        ],
      ),
      body: loading ?
      Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ) :
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child:_image != null ?
              Image.file(_image,height:400 , width: double.infinity, fit: BoxFit.contain,):
              Image.asset(
                'assets/images/img2.jpg',
                fit: BoxFit.cover,
                height: 220,
                width: double.infinity,
              ),
            ),

            SizedBox(height: 15,),

            if(result != null && result.isNotEmpty)
              Text(
                "${result[0]["label"].toString().split(" ").last.toUpperCase()}",
                style: Theme.of(context).textTheme.headline5,
              )
            else
              Text(
                'You can classify between dogs, cats and fishes.',
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              )

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
