import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ManagementCategoriesSxreen extends StatefulWidget {
  const ManagementCategoriesSxreen({Key? key}) : super(key: key);

  @override
  State<ManagementCategoriesSxreen> createState() =>
      _ManagementCategoriesSxreenState();
}

class _ManagementCategoriesSxreenState
    extends State<ManagementCategoriesSxreen> {
  File? image;
  //late PickedFile _imageFile;
  //final ImagePicker _picker = ImagePicker();
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Faild To Pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'Management Catrgories',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/BackGround.jpg'),
        )),
        child: Center(
          child: Column(
            children: [
              //   imageProfile(),
              Stack(
                children: [
                  image != null
                      ? Image.file(
                          image!,
                          width: 169,
                          height: 169,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          child: IconButton(
                            alignment: Alignment.bottomRight,
                            color: Colors.limeAccent,
                            iconSize: 70,
                            onPressed: () {
                              pickImage();
                            },
                            icon: Icon(
                              Icons.add_a_photo_rounded,
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  /*Widget imageProfile(){
    return Center(
      child: Stack(
        children:[
          CircleAvatar(
            radius: 80.0,
            backgroundImage: _imageFile == null ?
            AssetImage("assets/BackGround.jpg") : FileImage(File(_imageFile.path)),
          ),
          Positioned(
            bottom: 20,
              right: 20,
              child: InkWell(
                onTap: (){
                  takePhoto(ImageSource.gallery);
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.teal,
                  size: 30,
                ),
              ))
        ],
      ),
    );
  }
  void takePhoto(ImageSource Source) async{
    final pickedFile = await _picker.getImage(
      source: Source,
    );
    setState(() {
      _imageFile = pickedFile! ;
    });
  }*/
}
