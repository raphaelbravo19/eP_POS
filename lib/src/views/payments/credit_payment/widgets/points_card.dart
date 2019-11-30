import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_card.dart';
import 'package:flutter/material.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';

class PointsCard extends StatelessWidget {
  const PointsCard({
    Key key,
    @required this.hp,
    @required this.wp,
    this.isTablet,
  }) : super(key: key);

  final Function hp;
  final Function wp;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return EpaisaCard(
      margin: EdgeInsets.all(8),
      header: Container(
        padding: EdgeInsets.symmetric(
          horizontal: hp(1.5),
        ),
        height: hp(9),
        child: Row(
          children: <Widget>[
            Container(
              height: hp(6.5),
              width: hp(6.5),
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(right: hp(2)),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/customers/personal.png'),
                ),
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
            ),
            Text(
              'Abhishek Maurya',
              style: TextStyle(
                color: AppColors.BackPrimaryGray,
                fontWeight: FontWeight.bold,
                fontSize: hp(2.8),
              ),
            ),
          ],
        ),
      ),
      child: Container(
          padding: EdgeInsets.all(hp(1.5)),
          height: hp(11),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextValueBox(
                  wp: wp,
                  hp: hp,
                  title: eptxt('credit_available'),
                  value: '₹ 2720.00',
                  isTablet: isTablet,
                ),
              ),
              Expanded(
                child: TextValueBox(
                  wp: wp,
                  hp: hp,
                  title: eptxt('credit_loyalty_points'),
                  value: '5720',
                  isTablet: isTablet,
                ),
              ),
              Expanded(
                child: TextValueBox(
                  wp: wp,
                  hp: hp,
                  title: eptxt('credit_points_value'),
                  value: '₹ 57.20',
                  isTablet: isTablet,
                ),
              ),
            ],
          )),
    );
  }
}

class TextValueBox extends StatelessWidget {
  const TextValueBox({
    Key key,
    @required this.wp,
    @required this.hp,
    @required this.title,
    @required this.value,
    this.isTablet,
  }) : super(key: key);

  final Function wp;
  final Function hp;
  final String title;
  final String value;
  final bool isTablet;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: AppColors.BackPrimaryGray,
            fontWeight: FontWeight.w600,
            fontSize: isTablet ? hp(1.8) : wp(3),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                color: AppColors.BackPrimaryGray,
                fontWeight: FontWeight.bold,
                fontSize: isTablet ? hp(2.8) : wp(4.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
