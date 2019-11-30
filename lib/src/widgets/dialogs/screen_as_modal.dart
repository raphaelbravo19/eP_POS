import 'package:flutter/material.dart';

class ScreenAsModal extends StatelessWidget {
  final Widget body;
  final double width;
  final double height;
  ScreenAsModal({this.body, this.width = 600, this.height});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Container(
        alignment: Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          //padding: EdgeInsets.all(height != null ? 0 : 16),
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              alignment: Alignment.center,
              height: height,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(10),
                color: Colors.red,
              ),
              // padding: EdgeInsets.all(10),

              width: width,
              child: body,
            ),
          ),
        ),
      ),
    );
  }
}
