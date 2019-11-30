import 'dart:ui';

import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/reset_password/widgets/otp_fields.dart';
import 'package:epaisa_pos/src/views/reset_password/widgets/timer.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_password.dart';
import 'package:epaisa_pos/src/widgets/texts/text_gray.dart';
import 'package:flutter/material.dart';

class ButtonBlurredDialog extends StatefulWidget {
  ButtonBlurredDialog(
      {Key key,
      this.x,
      this.y,
      this.showDelivery,
      this.showDiscount,
      this.showCoupon})
      : super(key: key);
  final double x;
  final double y;
  final Function showDelivery;
  final Function showDiscount;
  final Function showCoupon;
  @override
  ButtonBlurredDialogState createState() => ButtonBlurredDialogState();
}

class ButtonBlurredDialogState extends State<ButtonBlurredDialog> {
  bool showModal = true;
  bool resendDisabled = true;
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
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                      child: Container(
                        width: wp(100),
                        height: hp(100),
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                  Positioned(
                    left: widget.x,
                    top: widget.y,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: hp(5.0),
                          width: hp(5.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/shopping/dots.png")),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(
                          height: hp(2),
                        ),
                        Container(
                          child: Stack(
                            alignment: Alignment.center,
                            overflow: Overflow.visible,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  closeModal();
                                  widget.showDelivery();
                                },
                                child: Container(
                                  height: hp(5.0),
                                  width: hp(5.0),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/shopping/delivery.png")),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: hp(6.5),
                                child: Text(
                                  "Delivery Charge",
                                  style: TextStyle(
                                      fontSize: hp(1.7),
                                      color: AppColors.Gray,
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: hp(2),
                        ),
                        Container(
                          child: Stack(
                            alignment: Alignment.center,
                            overflow: Overflow.visible,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  closeModal();
                                  widget.showCoupon();
                                },
                                child: Container(
                                  height: hp(5.0),
                                  width: hp(5.0),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/shopping/coupon.png")),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: hp(6.5),
                                child: Text(
                                  "Coupons",
                                  style: TextStyle(
                                      fontSize: hp(1.7),
                                      color: AppColors.Gray,
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: hp(2),
                        ),
                        Container(
                          child: Stack(
                            alignment: Alignment.center,
                            overflow: Overflow.visible,
                            children: <Widget>[
                              GestureDetector(
                                  onTap: () {
                                    closeModal();
                                    widget.showDiscount();
                                  },
                                  child: Container(
                                    height: hp(5.0),
                                    width: hp(5.0),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/shopping/discount.png")),
                                      shape: BoxShape.circle,
                                    ),
                                  )),
                              Positioned(
                                right: hp(6.5),
                                child: Text(
                                  "Discount",
                                  style: TextStyle(
                                      fontSize: hp(1.7),
                                      color: AppColors.Gray,
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
