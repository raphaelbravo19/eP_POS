import 'dart:io';

import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ButtonCamera extends StatefulWidget {
  final double size;
  final Function onSuccess;
  final String uriImage;
  const ButtonCamera({this.size, this.onSuccess, this.uriImage = ""});

  @override
  _ButtonCameraState createState() => _ButtonCameraState();
}

class _ButtonCameraState extends State<ButtonCamera> {
  File _image;
  Future getImage(ImageSource option) async {
    await PermissionHandler().requestPermissions([PermissionGroup.camera]);
    var image = await ImagePicker.pickImage(source: option);
    print(image);
    setState(() {
      _image = image;
    });
    if (widget.onSuccess != null) {
      widget.onSuccess(image);
    }
  }

  void _showDialog() {
    // flutter defined function

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(eptxt('select_an_option')),
          content: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  //color: Colors.blue,
                  child: Text(eptxt('camera')),
                  onPressed: () async {
                    Navigator.pop(context);
                    getImage(ImageSource.camera);
                  },
                ),
                FlatButton(
                  child: Text(eptxt('gallery')),
                  onPressed: () async {
                    Navigator.pop(context);
                    getImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDialog();
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.size * 0.07),
          child: Container(
            width: widget.size,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(widget.size * 0.07),
                border: Border.all(
                    width: 1, color: AppColors.DisabledText.withOpacity(0.3))),
            height: widget.size * 0.83,
            child: _image == null
                ? widget.uriImage != ''
                    ? widget.uriImage.indexOf("files") != -1 || widget.uriImage.indexOf("Application") != -1 
                        ? Image.file(
                            new File(widget.uriImage
                                .substring(7, widget.uriImage.length - 1)),
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            widget.uriImage,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                          )
                    : Icon(
                        Icons.camera_alt,
                        size: widget.size * 0.43,
                        color: AppColors.DisabledText.withOpacity(0.75),
                      )
                : Image.file(
                    _image,
                    fit: BoxFit.cover,
                  ),
          )),
    );
  }
}
