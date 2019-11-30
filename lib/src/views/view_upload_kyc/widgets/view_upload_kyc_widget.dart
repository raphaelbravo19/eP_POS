import 'dart:io';

import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/add_custom_barcode/widgets/arrow_card.dart';
import 'package:epaisa_pos/src/views/add_new_business/widgets/add_new_business_widget.dart';
import 'package:epaisa_pos/src/views/help/widgets/card_item.dart';
import 'package:epaisa_pos/src/views/view_upload_kyc/widgets/view_pdf.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyChromeSafariBrowser extends ChromeSafariBrowser {
  MyChromeSafariBrowser(browserFallback) : super(browserFallback);

  @override
  void onOpened() {
    print("ChromeSafari browser opened");
  }

  @override
  void onLoaded() {
    print("ChromeSafari browser loaded");
  }

  @override
  void onClosed() {
    print("ChromeSafari browser closed");
  }
}

MyChromeSafariBrowser chromeSafariBrowser =
    new MyChromeSafariBrowser(inAppBrowserFallback);

class ViewUploadKycWidget extends StatefulWidget {
  final showViewButton;
  final onUpload;
  final onShow;
  final AddBusinessBloc bloc;

  ViewUploadKycWidget(
      {this.showViewButton, this.onUpload, this.bloc, this.onShow});

  @override
  _ViewUploadKycWidgetState createState() => _ViewUploadKycWidgetState();
}

class _ViewUploadKycWidgetState extends State<ViewUploadKycWidget> {
  var uri = "";
  @override
  Widget build(BuildContext context) {
    List<String> docNameList = [
      'Business PAN',
      'Bank Statement',
      'Company Proof',
      'Address Proof'
    ];
    List<String> docImagePathList = [
      'assets/my_account/PANNumber.png',
      'assets/my_account/Invoice.png',
      'assets/my_account/Business.png',
      'assets/my_account/Location.png',
    ];

    Widget buildCard({String title, String imagePath, int type}) {
      return Padding(
        padding: EdgeInsets.only(
          left: tablet ? hp(0) : wp(3),
          right: tablet ? hp(0) : wp(3),
          bottom: tablet ? hp(1) : wp(2),
        ),
        child: CardItem(
          fontSize: tablet ? hp(2.5) : hp(2.3),
          horizontalMobileCard: 1,
          verticalMobileCard: 2,
          spaceBeforeTextMobile: 3,
          verticalTabletCard: 2,
          borderRadiusValue: wp(0.08),
          icon: Padding(
            padding: EdgeInsets.only(left: tablet ? wp(0) : wp(2)),
            child: Image.asset(
              imagePath,
              height: tablet ? hp(6.5) : wp(13),
            ),
          ),
          title: title,
          showForwardArrow: false,
          otherWidget: Row(
            children: <Widget>[
              widget.showViewButton
                  ? InkWell(
                      onTap: () async {
                        widget.onShow(type: type);
                        /* final directory =
                            await getApplicationDocumentsDirectory();
                        uri = 'file://${directory.path}/businessPan.pdf';
                        print(uri);
                        setState(() {}); */
                        //print(f.);
                        /* if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        } */
                        /* chromeSafariBrowser.open(
                            "file:///storage/emulated/0/Download/93255334525861.pdf",
                            options: {
                              "addShareButton": false,
                              "toolbarBackgroundColor": "#000000",
                              "dismissButtonStyle": 1,
                              "preferredBarTintColor": "#000000",
                            },
                            optionsFallback: {
                              "toolbarTopBackgroundColor": "#000000",
                              "closeButtonCaption": "Close"
                            }); */
                      },
                      child: Image.asset(
                        'assets/my_account/view.png',
                        height: tablet ? hp(3) : wp(4),
                      ),
                    )
                  : SizedBox(
                      width: tablet ? wp(2) : hp(2),
                    ),
              Container(
                margin: EdgeInsets.only(left: hp(1.5)),
                child: InkWell(
                  onTap: () async {
                    File files = await FilePicker.getFile();
                    print(files.path);
                    widget.onUpload(file: files, type: type);
                  },
                  child: Image.asset(
                    'assets/my_account/upload.png',
                    height: tablet ? hp(3.8) : wp(5),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget buildKYC() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: tablet ? hp(1) : wp(5),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                  children: List.generate(
                docNameList.length,
                (index) {
                  return buildCard(
                      title: docNameList.elementAt(index),
                      imagePath: docImagePathList.elementAt(index),
                      type: index);
                },
              )),
            ),
          ),
        ],
      );
    }

    return buildKYC();
  }
}
