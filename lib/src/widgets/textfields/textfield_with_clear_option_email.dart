import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/widgets/textStyles/label_style.dart';
import 'package:flutter/material.dart';

class TextFieldWithClearOptionEmail extends StatefulWidget {
  Stream<String> stream;
  ValueChanged<String> onChanged;
  Stream<int> enableEmail;
  bool isEnable = true;
  double fontsize;
  FontWeight fontWeight;
  final String initialValue;

  Function emailSink;
  TextFieldWithClearOptionEmail(
      {Key key,
      this.stream,
      this.fontsize,
      this.fontWeight,
      this.onChanged,
      this.isEnable,
      this.enableEmail,
      this.emailSink,
      this.initialValue})
      : super(key: key);
  @override
  TextFieldWithClearOptionEmailState createState() {
    return new TextFieldWithClearOptionEmailState();
  }
}

class TextFieldWithClearOptionEmailState
    extends State<TextFieldWithClearOptionEmail> {
  TextEditingController _textFieldController = TextEditingController();
  FocusNode myFocusNode;
  bool hasFocus = false;

  _onClear() {
    setState(() {
      _textFieldController.text = "";
      widget.emailSink('');
    });
  }

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    if (widget.initialValue != null) {
      _textFieldController.text = widget.initialValue;
    }
    myFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    print("Focus: " + myFocusNode.hasFocus.toString());
    setState(() {
      hasFocus = myFocusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.enableEmail,
        builder: (context, snapshotEmail) {
          print('snapshot email' + snapshotEmail.data.toString());
          return StreamBuilder(
            stream: widget.stream,
            builder: (context, snapshot) {
              return TextField(
                controller: _textFieldController,
                onChanged: widget.onChanged,
                focusNode: myFocusNode,
                enabled: snapshotEmail.data == 2 ||
                    snapshotEmail.data == 0 ||
                    snapshotEmail.data == null,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  fontSize: widget.fontsize * 0.98,
                  color: snapshot.hasError
                      ? AppColors.ErrorText
                      : hasFocus ? AppColors.FocusText : AppColors.DisabledText,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    alignment: Alignment.bottomRight,
                    onPressed: hasFocus ? _onClear : null,
                    icon: hasFocus
                        ? Icon(
                            Icons.cancel,
                            color: AppColors.IconDarkGray,
                            size: 20,
                          )
                        : Icon(
                            Icons.cancel,
                            size: 0,
                            color: AppColors.IconDarkGray,
                          ),
                  ),
                  labelText: 'E-mail',
                  labelStyle: LabelStyle.labelStyleGrey(
                      fontSize: widget.fontsize, fontWeight: widget.fontWeight),
                  errorText: snapshot.error,
                  errorStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: widget.fontsize * 0.63),
                  //enabledBorder: UnderLine.underLine(),
                  contentPadding: new EdgeInsets.fromLTRB(0, 8, 0, 15),
                ),
              );
            },
          );
        });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    myFocusNode.dispose();
    _textFieldController.dispose();
    super.dispose();
  }
}
