import 'package:epaisa_pos/src/logic/login_bloc/login_bloc.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/widgets/textStyles/label_style.dart';
import 'package:flutter/material.dart';

class TextFieldPassword extends StatefulWidget {
  LoginBloc bloc;

  Function emailSink;
  double fontsize;
  FontWeight fontWeight;
  TextFieldPassword({Key key, this.fontsize, this.fontWeight, this.bloc});

  @override
  TextFieldPasswordState createState() {
    return new TextFieldPasswordState();
  }
}

class TextFieldPasswordState extends State<TextFieldPassword> {
  FocusNode focusNode;
  bool hasFocus = false;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(changeFocus);
  }

  changeFocus() {
    setState(() {
      hasFocus = focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.bloc.password,
      builder: (context, snapshot) {
        return StreamBuilder(
          stream: widget.bloc.passwordVisibility,
          initialData: true,
          builder: (context, snapshotPass) {
            return TextField(
              textInputAction: TextInputAction.done,
              style: TextStyle(
                fontSize: widget.fontsize * 0.98,
                color: snapshot.hasError
                    ? AppColors.ErrorText
                    : hasFocus ? AppColors.FocusText : AppColors.DisabledText,
                fontWeight: FontWeight.w600,
              ),
              onChanged: widget.bloc.changePassword,
              focusNode: focusNode,
              obscureText: snapshotPass.data,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  alignment: Alignment.bottomRight,
                  onPressed: () {
                    print("Password${snapshotPass.hasData}");
                    widget.bloc.passwordVisibilitySink.add(!snapshotPass.data);
                  },
                  icon: snapshotPass.data == false
                      ? Icon(
                          Icons.visibility,
                          color: AppColors.IconDarkGray,
                        )
                      : Icon(
                          Icons.visibility_off,
                          color: AppColors.IconDarkGray,
                        ),
                ),
                labelText: 'Password',

                labelStyle: LabelStyle.labelStyleGrey(
                    fontSize: widget.fontsize, fontWeight: widget.fontWeight),
                errorText: snapshot.error,
                errorStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: widget.fontsize * 0.63),
                contentPadding: new EdgeInsets.fromLTRB(0, 8, 0, 15),
                //enabledBorder: UnderLine.underLine(),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    super.dispose();
  }
}
