

import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:mock_data/mock_data.dart';
class AddPost extends StatefulWidget {
  final GlobalKey<ScaffoldState> globalKey;
  const AddPost({Key key, this.globalKey}) : super(key: key);
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<AddPost> {
  List<Asset> images = List<Asset>();
  List<String> imageUrls = <String>[];
  String _error = 'No Error Dectected';
  bool isUploading = false;
  var width;
  var height;
  String popop = mockString(50);
  String _uploadedFileURL;
  List<String> imagURL = List();

  @override
  void initState() {
    super.initState();
  }
  Future saveImage(Asset asset) async {
    String fileName = popop;
    ByteData byteData = await asset.requestOriginal();
    List<int> imageData = byteData.buffer.asUint8List();
   // StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats/${Path.basename(fileName)}}');
    StorageUploadTask uploadTask = storageReference.putData(imageData);


    return await uploadTask.onComplete..ref.getDownloadURL();
  }


  void uploadImages(){
    for ( var imageFile in images) {
      postImage(imageFile).then((downloadUrl) {
        imageUrls.add(downloadUrl.toString());
        if(imageUrls.length==images.length){
          String documnetID = DateTime.now().millisecondsSinceEpoch.toString();
          Firestore.instance.collection('images').document(documnetID).setData({
            'urls':imageUrls
          }).then((_){
            SnackBar snackbar = SnackBar(content: Text('Uploaded Successfully'));
            widget.globalKey.currentState.showSnackBar(snackbar);
            setState(() {
              images = [];
              imageUrls = [];
            });
          });
        }
      }).catchError((err) {
        print(err);
      });
    }

  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Upload Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      print(resultList.length);
      print((await resultList[0].getThumbByteData(122, 100)));
      print((await resultList[0].getByteData()));
      print((await resultList[0].metadata));

    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;
    setState(() {
      images = resultList;
      _error = error;
    });
  }
  Future<dynamic> postImage(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }


  Widget buildGridView() {


    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        print('imageAssset: ${asset.getByteData(quality: 100)}');
        return AssetThumb(
          asset: asset,

          width: 300,
          height: 300,
        );
      }),
    );
  }


  Widget showImage(){
   return  Image.network('${imageUrls[1]}', fit: BoxFit.fill,);
  }


  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            Center(child: Text('Error: $_error')),
            RaisedButton(
              child: Text("Pick images"),
              onPressed: loadAssets,
            ),
            RaisedButton(
              child: Text("Save Image"),
              onPressed: () {
                uploadImages();
              },
            ),
           Text("Uploaded Image:"),
           (imageUrls.length != 0)?
            SizedBox(
              width: 200,
              height: 200,
              child: Image.network(imageUrls[0]),
            ): Text('Upload Imaage:'),
            Expanded(
              child: buildGridView(),
            ),

          ],
        ),
      ),
    );
  }
}