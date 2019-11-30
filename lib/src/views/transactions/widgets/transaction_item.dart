import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/payment_button_names.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_card.dart';
import 'package:epaisa_pos/src/widgets/buttons/payment_method_button.dart';
import 'package:flutter/material.dart';

class TransactionStatus {
  final Color color;
  final String text;
  TransactionStatus({
    this.color,
    this.text,
  });
}

class TransactionStatusList {
  static TransactionStatus approved = TransactionStatus(
    color: Color.fromRGBO(143, 199, 66, 1),
    text: 'APPROVED',
  );
  static TransactionStatus settled = TransactionStatus(
    color: Color.fromRGBO(6, 168, 86, 1),
    text: 'SETTLED',
  );
  static TransactionStatus pending = TransactionStatus(
    color: Color.fromRGBO(237, 228, 40, 1),
    text: 'PENDING',
  );
  static TransactionStatus failed = TransactionStatus(
    color: Color.fromRGBO(255, 61, 0, 1),
    text: 'FAILED',
  );
  static TransactionStatus cancelled = TransactionStatus(
    color: Color.fromRGBO(241, 102, 35, 1),
    text: 'CANCELLED',
  );
  static TransactionStatus deposited = TransactionStatus(
    color: Color.fromRGBO(45, 133, 134, 1),
    text: 'DEPOSITED',
  );
}

class TransactionType {
  final Widget icon;
  final String text;
  TransactionType({
    this.icon,
    this.text,
  });
}

class TransactionTypesList {
  static const double sizePortrait = 50;
  static const double sizeLandscape = 60;
  static TransactionType cash({bool isTablet}) {
    return TransactionType(
      icon: PaymentMethodButton(
        paymentName: PaymentButtonNames.Cash,
        onPress: () {},
        size: isTablet
            ? TransactionTypesList.sizeLandscape
            : TransactionTypesList.sizePortrait,
      ),
      text: 'Cash',
    );
  }

  static TransactionType card({bool isTablet}) {
    return TransactionType(
      icon: PaymentMethodButton(
        paymentName: PaymentButtonNames.Card,
        onPress: () {},
        size: isTablet
            ? TransactionTypesList.sizeLandscape
            : TransactionTypesList.sizePortrait,
      ),
      text: 'Card',
    );
  }

  static TransactionType wallet({bool isTablet}) {
    return TransactionType(
      icon: PaymentMethodButton(
        paymentName: PaymentButtonNames.WalletPayments,
        onPress: () {},
        size: isTablet
            ? TransactionTypesList.sizeLandscape
            : TransactionTypesList.sizePortrait,
      ),
      text: 'Wallet',
    );
  }

  static TransactionType upi({bool isTablet}) {
    return TransactionType(
      icon: PaymentMethodButton(
        paymentName: PaymentButtonNames.UpiPayments,
        onPress: () {},
        size: isTablet
            ? TransactionTypesList.sizeLandscape
            : TransactionTypesList.sizePortrait,
      ),
      text: eptxt('payment_button_upi'),
    );
  }

  static TransactionType cheque({bool isTablet}) {
    return TransactionType(
      icon: PaymentMethodButton(
        paymentName: PaymentButtonNames.Cheque,
        onPress: () {},
        size: isTablet
            ? TransactionTypesList.sizeLandscape
            : TransactionTypesList.sizePortrait,
      ),
      text: 'Cheque',
    );
  }
}

class TransactionItem extends StatelessWidget {
  final TransactionStatus status;
  final TransactionType type;
  final String transactionAmount;
  final bool isTablet;
  final Function onTap;
  const TransactionItem(
      {Key key,
      @required this.status,
      @required this.transactionAmount,
      @required this.type,
      this.isTablet = false,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: EpaisaCard(
        margin: EdgeInsets.only(bottom: 8),
        child: Container(
            padding: EdgeInsets.symmetric(
                vertical: isTablet ? hp(1.5) : hp(1.8), horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      TransactionDetailIcon(
                          icon: type.icon, isTablet: isTablet),
                      TransactionItemDetails(
                        textType: type.text,
                        isTablet: isTablet,
                      ),
                    ],
                  ),
                ),
                TransactionItemStatus(
                  color: status.color,
                  textStatus: status.text,
                  textAmount: transactionAmount,
                  isTablet: isTablet,
                )
              ],
            )),
      ),
    );
  }
}

class TransactionItemStatus extends StatelessWidget {
  final String textStatus;
  final String textAmount;
  final Color color;
  final bool isTablet;

  const TransactionItemStatus({
    Key key,
    @required this.textStatus,
    @required this.textAmount,
    @required this.color,
    this.isTablet = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 0,
        horizontal: isTablet ? wp(1.9) : 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 4),
            child: FittedBox(
              child: Text(
                textAmount,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isTablet ? hp(2.2) : wp(4),
                  color: color,
                ),
              ),
            ),
          ),
          Text(
            textStatus,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isTablet ? hp(1.6) : wp(3),
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionItemDetails extends StatelessWidget {
  final String textType;
  final bool isTablet;
  const TransactionItemDetails({
    Key key,
    this.textType,
    this.isTablet = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 8),
                child: Text(
                  textType,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: isTablet ? hp(2.4) : hp(2.4),
                    color: AppColors.BackPrimaryGray,
                    height: 0.6,
                  ),
                ),
              ),
              Text(
                '20 Feb 2018',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: isTablet ? hp(1.5) : hp(1.8),
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: tablet ? hp(0.5) : 0,
        ),
        Text(
          'Invoice No. 45612',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: isTablet ? hp(1.6) : hp(1.8),
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}

class TransactionDetailIcon extends StatelessWidget {
  final Widget icon;
  final bool isTablet;
  const TransactionDetailIcon({
    Key key,
    @required this.icon,
    this.isTablet = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 0, horizontal: isTablet ? wp(1.5) : 12),
      child: icon,
    );
  }
}
