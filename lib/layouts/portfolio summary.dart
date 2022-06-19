import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0,20,0,20),
                    child: FloatingActionButton(
                      onPressed: () => uploadImageToFirebase(context, files),
                      child: Icon(Icons.add),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0,20,0,20),
                    child: FloatingActionButton(
                      onPressed: pickMultipleImages,
                      child: Icon(Icons.save),
                    ),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: files == null ? 1 : files!.length,
                itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // child: Text(_imageFile == File("") ? "Getting file" : _imageFile.path)
                    child: files == null ? Text("Select a file") :
                    Image.file(
                      File(files![index].path),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),


                  ),
                );
              },
              )
            ],
          ),
        ),
      ),
    );
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
            child: SizedBox(height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor:Colors.grey,
                  color: Colors.green,
                ),
                Center(
                  child: Text(
                    "${(100 * progress).roundToDouble()}%",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )
              ),
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
