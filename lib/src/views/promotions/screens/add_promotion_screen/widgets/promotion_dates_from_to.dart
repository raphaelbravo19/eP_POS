import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart' as prefix0;
import 'package:epaisa_pos/src/views/transactions/transactions_screen.dart';
import 'package:epaisa_pos/src/widgets/epaisa/epaisa_card_edit.dart';
import 'package:epaisa_pos/src/widgets/textfields/textfield_classic.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PromotionDatesFromTo extends StatefulWidget {
  const PromotionDatesFromTo({
    Key key,
    @required this.hp,
    @required this.tablet,
  }) : super(key: key);

  final Function hp;
  final bool tablet;

  @override
  _PromotionDatesFromToState createState() => _PromotionDatesFromToState();
}

class _PromotionDatesFromToState extends State<PromotionDatesFromTo> {
  GlobalKey<TextfieldClassicState> fromKey = GlobalKey<TextfieldClassicState>();
  GlobalKey<TextfieldClassicState> toKey = GlobalKey<TextfieldClassicState>();
  @override
  Widget build(BuildContext context) {
    final wp = prefix0.ScreenUtils.of(context).wp;
    final fontSize = widget.tablet ? widget.hp(2.8) : wp(4);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          EpaisaCardEdit(
            hp: widget.hp,
            tablet: widget.tablet,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: widget.hp(0.5),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: TextfieldClassic(
                          disabled: true,
                          key: fromKey,
                          optional: false,
                          calendar: true,
                          firstDate: 1955,
                          lastDate: 2020,
                          customIconBuilder: (hasFocus, empty) {
                            return GestureDetector(
                                onTap: () async {
                                  final DateTime picked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1955),
                                      lastDate: DateTime(2020),
                                      footerBuilder: datePickerFooter,
                                      width: widget.tablet ? wp(45) : wp(80),
                                      headerBuilder: datePickerHeader,
                                      builder: (ct, child) {
                                        return child;
                                      });
                                  if (picked != null) {
                                    fromKey.currentState.changeText(
                                        DateFormat.yMd().format(picked));
                                  }
                                },
                                child: Image.asset(
                                    'assets/general_icons/calendar.png',
                                    height: fontSize * 1.4,
                                    colorBlendMode: BlendMode.srcIn,
                                    color: AppColors.PrimaryBlue));
                          },
                          noClear: true,
                          fontSize: fontSize,
                          paddingBottomInput: widget.hp(1),
                          labelText: "From",
                          alwaysFocus: false,
                          alwaysBlue: true,
                        ), /* TextfieldClassic.withDatePicker(
                            ctx: context,
                            firstDate: 2018,
                            lastDate: 2020,
                            fontSize: fontSize,
                            paddingBottomInput: hp(1),
                            labelText: "From",
                            alwaysBlue: true), */
                      ),
                      Container(
                          child: TextfieldClassic(
                        disabled: true,
                        key: toKey,
                        optional: false,
                        calendar: true,
                        firstDate: 1955,
                        lastDate: 2020,
                        customIconBuilder: (hasFocus, empty) {
                          return GestureDetector(
                              onTap: () async {
                                final DateTime picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1955),
                                    lastDate: DateTime(2020),
                                    footerBuilder: datePickerFooter,
                                    width: widget.tablet ? wp(45) : wp(80),
                                    headerBuilder: datePickerHeader,
                                    builder: (ct, child) {
                                      return child;
                                    });
                                if (picked != null) {
                                  toKey.currentState.changeText(
                                      DateFormat.yMd().format(picked));
                                }
                              },
                              child: Image.asset(
                                  'assets/general_icons/calendar.png',
                                  height: fontSize * 1.4,
                                  colorBlendMode: BlendMode.srcIn,
                                  color: AppColors.PrimaryBlue));
                        },
                        noClear: true,
                        fontSize: fontSize,
                        paddingBottomInput: widget.hp(1),
                        labelText: "To",
                        alwaysFocus: false,
                        alwaysBlue: true,
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
