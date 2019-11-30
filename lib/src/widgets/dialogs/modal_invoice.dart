import 'package:flutter/material.dart';

class ModalInvoice extends StatelessWidget {
  final Widget body;
  final double width;

  ModalInvoice({
    this.body,
    this.width = 600,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            child: body,
            width: width,
            height: 600,
          ),
        ),
      ),
    );
  }
}
