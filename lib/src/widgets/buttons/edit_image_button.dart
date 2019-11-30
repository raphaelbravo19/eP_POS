import 'dart:io';

import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/currentcompanys_dao.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/widgets/utils/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileImageButton extends StatefulWidget {
  final double size;
  final bool account;
  final String imageUrl;
  final String id;
  final Function onchange;
  const ProfileImageButton(
      {this.size = 40,
      this.account = false,
      this.imageUrl = "",
      this.id,
      this.onchange});

  @override
  _ProfileImageButtonState createState() => _ProfileImageButtonState();
}

class _ProfileImageButtonState extends State<ProfileImageButton> {
  File _image;
  Future getImage(ImageSource option) async {
    await PermissionHandler().requestPermissions([PermissionGroup.camera]);
    var image = await ImagePicker.pickImage(source: option);
    print(image);
    setState(() {
      _image = image;
    });
    if (widget.onchange != null) {
      widget.onchange(image);
    } else {
      if (widget.id != null) {
        CurrentCompanysDao dao = new CurrentCompanysDao(db);
        var companyData = await dao.getOne(widget.id);
        var company = companyData.toJson();
        company["image"] = _image.toString();
        dao.edit(CurrentCompanysDao.fromMapOwn(company));
        UploadImage("upload/companies/${widget.id}", _image);
      }
    }
  }

  void _showDialog() {
    // flutter defined function

    showDialog(
      context: context,
      builder: (BuildContext context) {
        var tablet = isTablet(MediaQuery.of(context));
        final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;

        // return object of type Dialog
        return Padding(
          padding: EdgeInsets.only(left: hp(tablet ? 50 : 0)),
          child: AlertDialog(
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
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var tablet = isTablet(MediaQuery.of(context));
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    print(widget.account);
    Widget profilePicture() {
      return GestureDetector(
          onTap: () {
            _showDialog();
          },
          child: Center(
            child: Stack(
              children: <Widget>[
                Container(
                  width: tablet ? hp(13) : wp(30),
                  height: tablet ? hp(13) : wp(30),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                  child: _image == null
                      ? widget.imageUrl != '' && widget.imageUrl != null
                          ? widget.imageUrl.indexOf("files") != -1 || widget.imageUrl.indexOf("Application") != -1 
                              ? ClipOval(
                                  child: Image.file(
                                  File(widget.imageUrl.substring(
                                      7, widget.imageUrl.length - 1)),
                                  fit: BoxFit.cover,
                                  width: tablet ? hp(13) : wp(30),
                                  height: tablet ? hp(13) : wp(30),
                                ))
                              : ClipOval(
                                  child: Image.network(
                                  widget.imageUrl,
                                  fit: BoxFit.cover,
                                  width: tablet ? hp(13) : wp(30),
                                  height: tablet ? hp(13) : wp(30),
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes
                                            : null,
                                      ),
                                    );
                                  },
                                ))
                          : Icon(
                              Icons.person,
                              size: tablet ? hp(9) : wp(15),
                              color: AppColors.DisabledText.withOpacity(0.75),
                            )
                      : ClipOval(
                          child: Image.file(
                            _image,
                            fit: BoxFit.cover,
                            width: tablet ? hp(13) : wp(30),
                            height: tablet ? hp(13) : wp(30),
                          ),
                        ),
                ),
                Positioned(
                  //right: 10.0,
                  bottom: wp(tablet ? 0 : 1),
                  child: Image.asset(
                    'assets/general_icons/edit.png',
                    width: wp(tablet ? 3 : 8),
                    height: wp(tablet ? 3 : 8),
                  ),
                )
              ],
            ),
          ));
    }

    return profilePicture();
  }
}
