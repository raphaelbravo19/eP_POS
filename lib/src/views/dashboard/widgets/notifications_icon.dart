import 'package:flutter/material.dart';

class NotificationsIcon extends StatelessWidget {
  final int count;
  final bool isTablet;
  final Function onPressed;
  NotificationsIcon({this.count, this.isTablet = false, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IconButton(
          icon: Image.asset(
            'assets/dashboard/bell.png',
            width: isTablet ? 32 : 24,
          ),
          onPressed: onPressed,
        ),
        Positioned(
          top: isTablet ? 0 : 4,
          right: isTablet ? 0 : 4,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(2),
            height: isTablet ? 20 : 18,
            width: isTablet ? 20 : 18,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: FittedBox(
              child: Text(
                '$count',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
