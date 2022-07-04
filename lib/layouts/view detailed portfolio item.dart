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
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:technicians/layouts/create%20portfolio%20item.dart';
import 'package:technicians/layouts/single%20portfolio%20item.dart';
import 'package:technicians/models/portfolio%20object.dart';
import 'package:technicians/utils/strings%20enum.dart';
import 'package:technicians/widgets/slider.dart';

import '../utils/hex colors.dart';

class ViewDetailedPortfolioItem extends StatefulWidget {
  final int? index;
  final List<dynamic>? urlImages;
  final String? desc;
  final bool isIssueImage;
  const ViewDetailedPortfolioItem(
      this.urlImages, this.index, this.desc, this.isIssueImage,
      {Key? key})
      : super(key: key);

  @override
  State<ViewDetailedPortfolioItem> createState() =>
      _ViewDetailedPortfolioItemState();
}

class _ViewDetailedPortfolioItemState extends State<ViewDetailedPortfolioItem> {
  bool isDescVisible = true;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      body: Hero(
        tag: widget.index ?? 1234,
        child: Material(
          color: Colors.transparent,
          child: Stack(alignment: Alignment.center, children: [
            PhotoViewGallery.builder(
              itemCount: widget.urlImages!.length,
              builder: (context, index) {
                final urlImage = widget.urlImages![index];
                return PhotoViewGalleryPageOptions(
                  imageProvider: widget.isIssueImage
                      ? FileImage(urlImage) as ImageProvider
                      : NetworkImage(urlImage),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.contained * 4,
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                color: Colors.transparent,
                child: AnimatedContainer(
                  color: isDescVisible ? Colors.transparent : Colors.transparent,
                  duration: Duration(milliseconds: 500),
                  height: isDescVisible
                      ? MediaQuery.of(context).size.height / 3
                      : 50,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    color: Colors.black54,
                    child: Text( isDescVisible ?
                      "${widget.desc}" : '\n',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
                bottom: isDescVisible
                    ? (MediaQuery.of(context).size.height / 3)
                    : MediaQuery.of(context).size.height / 25,
                // top: MediaQuery.of(context).size.height/10,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _darkTxtClr,
                  ),
                  child: IconButton(
                    icon: Icon(
                      isDescVisible
                          ? Icons.arrow_downward_outlined
                          : Icons.arrow_upward_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () =>
                        setState(() => isDescVisible = !isDescVisible),
                  ),
                ),
                duration: Duration(milliseconds: 500)),
          ]),
        ),
      ),
    ));
  }

  final Color _darkTxtClr = HexColor("#96878D");
}
