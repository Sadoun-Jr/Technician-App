import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:technicians/layouts/create%20portfolio%20item.dart';
import 'package:technicians/layouts/single%20portfolio%20item.dart';
import 'package:technicians/utils/strings%20enum.dart';
import 'package:technicians/widgets/slider.dart';

class CreatePortfolioItem extends StatefulWidget {
  const CreatePortfolioItem({Key? key}) : super(key: key);

  @override
  State<CreatePortfolioItem> createState() => _CreatePortfolioItemState();
}

class _CreatePortfolioItemState extends State<CreatePortfolioItem> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  Color _midblack = Colors.black54;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        bottomNavigationBar: saveFAB(),
        body: Container(
          child: ListView(
            children: [
              myController(titleController, 1, "Title..."),
              myController(descController, 10, "Description of the work..."),
              Container(
                margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: Text("Pictures"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Visibility(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: FloatingActionButton.extended(
                        heroTag: -1,
                        onPressed: pickMultipleImages,
                        label: Text("Select Images"),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: files != null,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: FloatingActionButton.extended(
                        heroTag: -2,
                        onPressed: () => uploadImageToFirebase(context, files),
                        label: Text("Upload Images"),
                      ),
                    ),
                  ),
                ],
              ),
              buildProgress(),
              Visibility(
                visible: files != null,
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: files == null ? 1 : files!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: InkWell(
                          onLongPress: () async {
                            await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Are you sure?'),
                                content: Text('Delete this picture?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.of(context)
                                        .pop(false), //<-- SEE HERE
                                    child: Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                      Fluttertoast.showToast(
                                          msg: "Deleted",backgroundColor: Colors.green);
                                      setState(() {
                                        files!.removeAt(index);
                                      });
                                    }, // <-- SEE HERE
                                    child: Text('Yes'),
                                  ),
                                ],
                              ),
                            );
                          },
                          onTap: () {
                            var selectedImage = files![index];
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SinglePortfolioItem(
                                        selectedImage.path)));
                          },
                          child: files == null
                              ? Align(
                                  alignment: Alignment.center,
                                  child: Text("EMPTY"))
                              : Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  // child: Text(_imageFile == File("") ? "Getting file" : _imageFile.path)
                                  child: Hero(
                                    tag: files![index].path,
                                    child: Image.file(
                                      File(files![index].path),
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget saveFAB() {
    return Hero(
      tag: 100,
      child: Material(
        child: InkWell(
          onTap: insertPortfolioInDb,
          splashColor: Colors.green,
          child: Container(
            color: Colors.transparent,
            height: 75,
            width: double.infinity,
            child: Center(
                child: Text(
              "Save",
              style: TextStyle(fontSize: 25),
            )),
          ),
        ),
      ),
    );
  }

  Future<void> insertPortfolioInDb() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        debugPrint('connected');
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(
          msg: "No internet connection", backgroundColor: Colors.red);
      return;
    }

    try {
      var portfolioRef = FirebaseFirestore.instance.collection("portfolios");

      //get the current user uid
      final auth = FirebaseAuth.instance;
      final User user = auth.currentUser!;
      final userid = user.uid;

      //create an empty issue with a uid
      await FirebaseFirestore.instance.collection("portfolios").add({
        AppStrings.portfolioUidkey: " ",
      }).then((value) async {
        debugPrint(
            "Portfolio made with ID# " + value.id + "\nCreated by ID# " + user.uid);
        await FirebaseFirestore.instance
            .collection("portfolios")
            .doc(value.id)
            .set({
              AppStrings.portfolioUidkey : value.id,
              AppStrings.titlekey : titleController.text.trim().toString(),
              AppStrings.portfolioDesckey : descController.text.trim().toString(),
              AppStrings.issuedByKey : userid,
              AppStrings.dateAddedkey : DateTime.now().millisecondsSinceEpoch,
              AppStrings.numberOfViewskey : 0,
              AppStrings.numberOfPictureskey : listOfFilePaths.length,
              AppStrings.numberOfFavouritesKey : 0,
              AppStrings.listOfImagePathskey: listOfFilePaths,
        });
      });

      setState(() {});
      Fluttertoast.showToast(msg: "Created portfolio item", backgroundColor: Colors.green);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red);
      debugPrint(e.toString());
    }
  }

  Widget addNewPortfolioItem() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(this.context,
            MaterialPageRoute(builder: (context) => CreatePortfolioItem()));
      },
      heroTag: 100,
      child: Icon(Icons.add),
    );
  }

  File _imageFile = File("");
  final picker = ImagePicker();
  List<File>? files;
  UploadTask? uploadTask;
  List<String> listOfFilePaths = [];

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;
          return Visibility(
              visible: uploadTask != null,
              child: Column(
                children: [
                  slider(),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Uploading...")
                ],
              ));
        } else {
          return SizedBox(
            height: 5,
          );
        }
      });

  Future uploadImageToFirebase(
      BuildContext context, dynamic listOfFiles) async {
    // Create a Reference to the file
    for (int i = 0; i < files!.length; i++) {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('portfolios')
          .child("/tech uid")
          .child("/portfolio #$i")
          .child(_imageFile.path);
      // .child('/${_imageFile.path}');
      setState(() {
        uploadTask = ref.putFile(listOfFiles[i]);
      });

      final snapShot = await uploadTask!.whenComplete(() => {});
      final urlDownload = await snapShot.ref.getDownloadURL();
      listOfFilePaths.add(urlDownload);
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
      setState(
          () => {files = result.paths.map((path) => File(path!)).toList()});
    } else {
      // User canceled the picker
    }
  }

  Widget myController(
      TextEditingController controller, int maxLines, String labelText) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.top,
        controller: controller,
        maxLines: maxLines,
        textInputAction: TextInputAction.next,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        // validator: (value) => value != null && value.length < 6
        //     ? "Password can't be less than 6 characters"
        //     : null,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: _midblack,
              width: 1.25,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          labelText: labelText,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _midblack, width: 2.5),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
