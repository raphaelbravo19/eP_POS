import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/add_new_business/widgets/add_new_business_widget.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient.dart';
import 'package:epaisa_pos/src/widgets/cards/toggle_card.dart';
import 'package:epaisa_pos/src/widgets/header_card/header_widget.dart';
import 'package:epaisa_pos/src/views/employee/widgets/row_structure.dart';
import 'package:epaisa_pos/src/widgets/textfields/texfield_number.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_dropdown.dart';
import 'package:flutter/material.dart';

class AddBusinessFinancialInfoScreen extends StatefulWidget {
  AddBusinessBloc bloc;
  AddBusinessFinancialInfoScreen({this.bloc});
  @override
  _AddBusinessFinancialInfoScreenState createState() =>
      _AddBusinessFinancialInfoScreenState();
}

class _AddBusinessFinancialInfoScreenState
    extends State<AddBusinessFinancialInfoScreen> {
  GlobalKey<ToggleCardState> gstkey = GlobalKey<ToggleCardState>();
  GlobalKey<ToggleCardState> vatkey = GlobalKey<ToggleCardState>();
  @override
  Widget build(BuildContext context) {
    final bool tablet = ScreenUtils.of(context).isTablet;
    final Function hp = ScreenUtils.of(context).hp;
    final Function wp = ScreenUtils.of(context).wp;

    Widget buildGSTIN() {
      return Column(
        children: <Widget>[
          RowStructure(
            imagePath: 'assets/my_account/GST.png',
            child: TextfieldClassic(
              fontSize: tablet ? hp(2.7) : hp(2.1),
              paddingBottomInput: tablet ? hp(1.5) : hp(1.2),
              labelText: "GSTIN",
              //alwaysFocus: true,
              showClearButton: false,
              //hintText: "22AAAAA0000A1ZY",
              initialValue: widget.bloc.gstinStream.value,
              onChanged: (val) {
                widget.bloc.changeGstin(val);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: hp(1)),
            child: Text(
              multilang.get('taxes').toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: tablet ? hp(2.7) : wp(5),
                  color: AppColors.PrimaryBlue),
            ),
          ),
        ],
      );
    }

    Widget invoice() {
      return Text(
        "INVOICE",
        style: TextStyle(
          color: AppColors.PrimaryBlue,
          fontSize: tablet ? hp(2.7) : wp(4.5),
          fontWeight: FontWeight.bold,
        ),
      );
    }

    Widget gstAndVat() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: wp(2)),
        child: Row(
          children: <Widget>[
            Expanded(
              child: ToggleCard(
                key: gstkey,
                fontSize: tablet ? hp(2.5) : wp(4.5),
                paddingHorizontal: tablet ? hp(2) : hp(2),
                paddingVertical: tablet ? hp(2) : hp(1.5),
                description: "GST",
                toggleSize: tablet ? hp(1.7) : wp(2.7),
                sized: tablet ? hp(2) : wp(0),
                initial: true,
                onChanged: (val) {
                  widget.bloc.changeGst(val);
                  vatkey.currentState.change(false);
                },
              ),
            ),
            SizedBox(
              width: tablet ? hp(5) : wp(3),
            ),
            Expanded(
              child: ToggleCard(
                key: vatkey,
                fontSize: tablet ? hp(2.5) : wp(4.5),
                paddingHorizontal: tablet ? hp(2) : hp(2),
                paddingVertical: tablet ? hp(2) : hp(1.5),
                description: "VAT",
                toggleSize: tablet ? hp(1.7) : wp(2.7),
                sized: tablet ? hp(2) : wp(0),
                initial: false,
                onChanged: (val) {
                  widget.bloc.changeGst(!val);
                  gstkey.currentState.change(false);
                },
              ),
            ),
          ],
        ),
      );
    }

    Widget customInvoice() {
      return Padding(
        padding: EdgeInsets.only(
            left: wp(2),
            right: wp(2),
            top: wp(tablet ? 0.8 : 1),
            bottom: wp(tablet ? 0 : 1)),
        child: ToggleCard(
          fontSize: tablet ? hp(2.4) : wp(4.5),
          paddingHorizontal: tablet ? hp(1) : wp(3),
          paddingVertical: tablet ? hp(3) : wp(3),
          spaceBeforeDesc: tablet ? hp(3) : wp(3),
          toggleSize: tablet ? hp(1.7) : wp(2.7),
          sized: tablet ? hp(2) : wp(0),
          description: "Enable Custom Invoice",
        ),
      );
    }

    Widget preFixSeriesWidget() {
      return RowStructure(
        imagePath: tablet
            ? 'assets/my_account/Business.png'
            : 'assets/my_account/Invoice.png',
        child: Row(
          children: <Widget>[
            Expanded(
                child: TextfieldClassic(
              alwaysFocus: true,
              hintText: 'INV3402',
              paddingBottomInput: tablet ? hp(1.3) : hp(1.2),
              fontSize: tablet ? hp(2.5) : hp(2.1),
              labelText: "Prefix",
            )),
            Expanded(
                child: TextfieldClassic(
              leftBorder: true,
              alwaysFocus: true,
              hintText: "0000001",
              paddingBottomInput: tablet ? hp(1.3) : hp(1.2),
              fontSize: tablet ? hp(2.5) : hp(2.1),
              labelText: "Series Start",
            )),
          ],
        ),
      );
    }

    Widget Tablet() {
      return Column(
        children: <Widget>[
          buildGSTIN(),
          gstAndVat(),
          SizedBox(
            height: hp(2),
          ),
          invoice(),
          customInvoice(),
          preFixSeriesWidget(),
          SizedBox(
            height: hp(12),
          )
        ],
      );
    }

    Widget buildFinancial() {
      return Padding(
        padding: EdgeInsets.only(top: tablet ? wp(0) : wp(2)),
        child: tablet
            ? Tablet()
            : Column(
                children: <Widget>[
                  buildGSTIN(),
                  gstAndVat(),
                ],
              ),
      );
    }

    return buildFinancial();
  }
}
