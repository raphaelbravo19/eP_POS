import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/cash_register/cash_register.dart';
import 'package:epaisa_pos/src/views/payments/cash_payment/widgets/cash_tendering.dart';
import 'package:epaisa_pos/src/views/payments/widgets/pay_amount.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class CashPayment extends StatelessWidget {
  CashPayment({
    Key key,
    @required this.sHeight,
  }) : super(key: key);

  final double sHeight;
  final BehaviorSubject<double> paymentAmount =
      new BehaviorSubject<double>.seeded(cashRegisterBloc.streamTotal.value);
  bool init = true;
  @override
  Widget build(BuildContext context) {
    final tablet = isTablet(MediaQuery.of(context));
    return Column(
      children: <Widget>[
        Container(
          child: StreamBuilder<double>(
              stream: paymentAmount,
              builder: (context, snapshot) {
                if (snapshot.data != null)
                  return PayAmount(
                    value: snapshot.data.toStringAsFixed(2),
                  );
                else {
                  return Container();
                }
              }),
        ),
        SizedBox(
          height: hp(1.6),
        ),
        Container(
          child: CashTendering(
            amountStream: paymentAmount,
            updateAmount: (val) {
              if (init) {
                paymentAmount.sink.add(val);
                init = false;
              } else
                paymentAmount.sink.add(paymentAmount.value + val);
            },
          ),
        ),
      ],
    );
  }
}
