import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:technicians/layouts/create%20portfolio%20item.dart';
import 'package:technicians/layouts/single%20portfolio%20item.dart';
import 'package:technicians/widgets/slider.dart';

class PortfolioSummary extends StatefulWidget {
  const PortfolioSummary({Key? key}) : super(key: key);

  @override
  State<PortfolioSummary> createState() => _PortfolioSummaryState();
}

class _PortfolioSummaryState extends State<PortfolioSummary> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        floatingActionButton: addNewPortfolioItem(),
        body: Container(
          padding: EdgeInsets.all(16),
          child: ListView(
            physics: ScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true, //
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: Stack(children: const [
                  Align(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      maxRadius: 100,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    left: 250,
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      maxRadius: 10,
                    ),
                  ),
                ]),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0,20,0,20),
                child: Text(
                  "Portfolio items", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              buildProgress(),
            ],
          ),
        ),
      ),
    );
  }

  Widget addNewPortfolioItem() {
    return FloatingActionButton(onPressed:
    () {
      Navigator.push(this.context, MaterialPageRoute(
          builder: (context) => CreatePortfolioItem())
      );
      },
      heroTag: 100,
    child: Icon(Icons.add),);
  }

  File _imageFile = File("");
  final picker = ImagePicker();
  List<File>? files;
  UploadTask? uploadTask;

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot){
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;
          return Visibility(
            visible: uploadTask != null,
            child: Column(
              children: [
                slider(),
                SizedBox(height: 10,),
                Text("Uploading...")
              ],
            )
          );
        } else {
          return SizedBox(height: 5,);
        }
      }
  );

  Future uploadImageToFirebase(BuildContext context, dynamic listOfFiles) async {
    // Create a Reference to the file
    for(int i=0;i<listOfImages.length;i++){
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('portfolios').child("/tech uid").child("/portfolio #$i").child(_imageFile.path);
      // .child('/${_imageFile.path}');
      setState(() {
        uploadTask = ref.putFile(listOfFiles[i]);
      });

      final snapShot = await uploadTask!.whenComplete(() => {});
      final urlDownload = await snapShot.ref.getDownloadURL();

      setState(() {
        uploadTask = null;
      });
      debugPrint("Download link: $urlDownload");
    }
  }



  Future pickMultipleImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'svg']);

    if (result != null) {
      setState(()=> {
        files = result.paths.map((path) => File(path!)).toList()
      });
    } else {
      // User canceled the picker
    }
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }


  var listOfImages = [
    "assets/Begin.png",
    "assets/Add goal.png",
    "assets/1.png",
    "assets/Edit entry.png",
    "assets/Grab times.png",
    "assets/Introductory screens.png",
    "assets/List.png",
    "assets/Rate entry.png"
  ];

}
