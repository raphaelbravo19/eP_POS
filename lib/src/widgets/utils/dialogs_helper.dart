import 'package:epaisa_pos/src/bloc/login_bloc.dart' as prefix0;
import 'package:epaisa_pos/src/logic/login_bloc/login_bloc.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/views/customers/add_customer/search.dart';
import 'package:epaisa_pos/src/views/login/login_screen.dart';
import 'package:epaisa_pos/src/widgets/dialogs/dialog_with_close.dart';

import '../../views/customers/add_customer/search_customer.dart';
import 'package:flutter/material.dart';

void searchCustomer(BuildContext context, Function onAddNew) {
  // flutter defined function

  Navigator.of(context).push(
    new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return SearchCustomerDialog(
          close: Navigator.of(context).pop,
          onAddNew: onAddNew,
        );
      },
    ),
  );
}

void showDialogMessage(
    BuildContext context, String message, Function callback) {
  // flutter defined function
  var isLogOut = message.indexOf("expired") != -1;
  Navigator.of(context).push(
    new PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return DialogWithClose(
            message: isLogOut
                ? "Your session has expired. Please log in again"
                : message,
            callback: () async {
              if (isLogOut) {
                await prefix0.loginBloc.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              }
              if (callback != null) {
                callback();
              }
            });
      },
      transitionsBuilder: (c, anim, a2, child) =>
          FadeTransition(opacity: anim, child: child),
      transitionDuration: Duration(milliseconds: 150),
    ),
  );
}

void showLoading(BuildContext ctx) {
  showDialog(
      context: ctx,
      builder: (context) {
        return Center(
          child: SizedBox(
            height: hp(6),
            width: hp(6),
            child: CircularProgressIndicator(
              strokeWidth: hp(1),
              backgroundColor: AppColors.PrimaryWhite,
            ),
          ),
        );
      });
}

void hideLoading(BuildContext context) {
  Navigator.pop(context);
}
