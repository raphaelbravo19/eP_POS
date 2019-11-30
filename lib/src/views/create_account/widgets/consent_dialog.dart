import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/create_account/widgets/agreements_dialog.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_border.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:flutter/material.dart';

class ConsentDialog extends StatefulWidget {
  ConsentDialog({this.selectOption});
  final Function selectOption;
  @override
  _ConsentDialogState createState() => _ConsentDialogState();
}

class _ConsentDialogState extends State<ConsentDialog> {
  bool showModal = true;
  bool searchMode = false;
  String query;
  @override
  void initState() {
    super.initState();
  }

  void closeModal() {
    Navigator.of(context).pop();
    setState(() {
      showModal = false;
    });
  }

  title(title) {
    return Center(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: tablet ? hp(3) : hp(2.4),
            fontWeight: FontWeight.w700,
            color: AppColors.PrimaryBlue),
      ),
    );
  }

  paragraph(text, {int indent}) {
    return Container(
      padding: EdgeInsets.only(
          top: hp(1.4), left: indent == 1 ? 10 : indent == 2 ? 20 : 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            indent == 1 ? "•" : indent == 2 ? "⦿" : "",
            style: TextStyle(
                fontSize: hp(1.5),
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          if (indent != null) SizedBox(width: 5),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: hp(1.5),
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: Container(
        alignment: Alignment.center,
        width: wp(100),
        height: hp(100),
        child: !showModal
            ? Container()
            : Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showModal = false;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: wp(100),
                      height: hp(100),
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        width: (tablet ? wp(70) : wp(95)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(hp(1.5))),
                                  child: ButtonBorder(
                                    callback: () {
                                      widget.selectOption(false);
                                      closeModal();
                                    },
                                    title: eptxt('decline').toUpperCase(),
                                    fontSize: tablet ? hp(2.4) : hp(2.1),
                                    fontWeight: FontWeight.w700,
                                    borderWidth: 1.2,
                                    paddingVertical: tablet ? hp(2.8) : hp(1.8),
                                  )),
                            ),
                            Expanded(
                              flex: 2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(hp(1.5))),
                                child: ButtonGradient(
                                  callback: () {
                                    widget.selectOption(true);
                                    closeModal();
                                  },
                                  title: eptxt('accept').toUpperCase(),
                                  fontSize: tablet ? hp(2.4) : hp(2.1),
                                  fontWeight: FontWeight.w700,
                                  paddingVertical: tablet ? hp(3) : hp(2),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: (tablet ? wp(70) : wp(95)),
                        height: tablet ? hp(80) : hp(85),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(),
                            ),
                            Container(
                              width: (tablet ? wp(70) : wp(95)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: tablet ? wp(2) : wp(4)),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(hp(1.5)),
                                    bottomRight: Radius.circular(hp(1.5))),
                                color: AppColors.PrimaryWhite,
                              ),
                              child: ScrollConfiguration(
                                behavior: RemoveOverScrollGlow(),
                                child: ListView(children: <Widget>[
                                  SizedBox(
                                    height: hp(1.8),
                                  ),
                                  title(eptxt('e_sign')),
                                  paragraph(
                                    "ePaisa Services Pvt Ltd. and its affiliates and third-party service providers (“ePaisa”) may need to provide you with certain communications, notices, agreements, billing statements, or disclosures in writing (“Communications”) regarding our Services. Your agreement to this E-sign Consent confirms your ability and consent to receive Communications electronically from ePaisa, its affiliates, and its third-party service providers, rather than in paper form, and to the use of electronic signatures in our relationship with you (“Consent”). If you choose not to agree to this Consent or you withdraw your consent, you may be restricted from using the Services.",
                                  ),
                                  SizedBox(height: hp(2.4)),
                                  title(
                                    "Electronic Delivery of Communications and Use of Electronic Signatures",
                                  ),
                                  paragraph(
                                    "Under this Consent, ePaisa may provide all Communications electronically by email, by text message, or by making them accessible via ePaisa websites or applications. Communications include, but are notlimited to, (1) agreements and policies required to use the Services (e.g. this Consent, the ePaisa Privacy Notice, the ePaisa Seller Agreement.  (2) payment authorizations and transaction receipts or confirmations, (3) account statements and history, (4) and all federal and state tax statements and documents. We may also use electronic signatures and obtain them from you.",
                                  ),
                                  SizedBox(height: hp(2.4)),
                                  title(
                                    "System Requirements",
                                  ),
                                  paragraph(
                                      "To access and retain the electronic Communications, you will need the following:"),
                                  paragraph(
                                      "A computer or mobile device with Internet or mobile connectivity.",
                                      indent: 1),
                                  paragraph(
                                      "For desktop website-based Communications:",
                                      indent: 1),
                                  paragraph(
                                      "Recent web browser that supports TLS 1.2 and above",
                                      indent: 2),
                                  paragraph(
                                      "The browser must have cookies enabled. Use of browser extensions may impair full website functionality; and",
                                      indent: 2),
                                  paragraph(
                                      "Minimum recommended browser standards are the most recent versions of Mozilla Firefox (seehttp://www.mozilla.comfor latest version), Apple Safari (seehttp://www.apple.com/safarifor latest version), or Google Chrome (seehttp://www.google.com/chromefor latest version).",
                                      indent: 2),
                                  paragraph(
                                      "For application-based Communications:",
                                      indent: 1),
                                  paragraph(
                                      "A recent device operating system that supports text messaging, downloading, and applications from the Apple App Store or Google Play store; and",
                                      indent: 2),
                                  paragraph(
                                      "The most recent versions of Apple Safari or Google Chrome on iOS or Google Chrome for Android OS.",
                                      indent: 2),
                                  paragraph(
                                      "Access to the email address used to create an account for Square Services.",
                                      indent: 1),
                                  paragraph(
                                      "Sufficient storage space to save Communications and/or a printer to print them.",
                                      indent: 1),
                                  SizedBox(height: hp(2.4)),
                                  title(
                                    "Paper Delivery of Communications",
                                  ),
                                  paragraph(
                                    "You have the right to receive Communications in paper form. To request a paper copy of any Communication at no charge, please write to ePaisa Services Private Limites., C-25A,  Market Road, Vasant Vihar, New Delhi, 110057, India, Attn: Customer Support - Legal (“ePaisa Address”) within 180 days of the date of the Disclosure, specifying in detail the Communication you would like to receive.",
                                  ),
                                  SizedBox(height: hp(2.4)),
                                  title(
                                    "Withdrawal of Consent to Electronic Communications",
                                  ),
                                  paragraph(
                                    "You may withdraw your consent to receive electronic Communications at any time, by writing to the ePaisa Address. However, withdrawal of your consent to receive electronic Communications may result in termination of your access to Services. Any withdrawal of your consent will be effective after a reasonable period of time for processing your request.",
                                  ),
                                  SizedBox(height: hp(2.4)),
                                  title(
                                    "Updating Your Email Address",
                                  ),
                                  paragraph(
                                    "You can change your email address by writing to the ePaisa Address. You may also be able to change your email address yourself through the Services.",
                                  ),
                                  SizedBox(height: hp(3.4)),
                                ]),
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
