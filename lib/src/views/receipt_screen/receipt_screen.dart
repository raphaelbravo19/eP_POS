import 'package:epaisa_pos/src/views/receipt_screen/widgets/receipt_modal.dart';
import 'package:flutter/material.dart';

class ReceiptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showDialog() {
      Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return ReceiptModal();
        },
      ));
    }

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            _showDialog();
          },
          child: Text("Press"),
        ),
      ),
    );
  }
}
