import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/utility/tablet.dart' as prefix0;
import 'package:epaisa_pos/src/views/invoice/widgets/details_card.dart';
import 'package:epaisa_pos/src/views/invoice/widgets/send_receipt.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class InvoiceScreen extends StatelessWidget {
  AudioPlayer advancedPlayer;
  Future loadMusic() async {
    advancedPlayer = await AudioCache().play("sounds/payment_success.mp3");
  }

  @override
  Widget build(BuildContext context) {
    loadMusic();
    final tablet = isTablet(MediaQuery.of(context));
    return EpaisaScaffold(
      noSafe: true,
      appBar: AppBar(
        backgroundColor: AppColors.NotificationGreen,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: tablet ? wp(0.5) : 0),
            padding: EdgeInsets.only(bottom: tablet ? hp(1.5) : 0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(
                'assets/general_icons/xbutton.png',
                height: tablet ? hp(20) : 16,
                colorBlendMode: BlendMode.srcIn,
                color: Colors.white,
              ),
            ),
          ),
        ],
        title: Container(
          padding: EdgeInsets.only(bottom: tablet ? hp(2) : 0),
          child: Text(
            !tablet ? eptxt('invoice').toUpperCase() : 'Invoice',
            style: TextStyle(
              fontSize: tablet ? hp(3.5) : 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: tablet ? InvoiceLandscape() : InvoicePortrait(),
    );
  }
}

class InvoiceLandscape extends StatelessWidget {
  const InvoiceLandscape({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 8),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    DetailsCard(
                      key: Key('one'),
                      isTablet: true,
                    ),
                    DetailsCard(
                      key: Key('two'),
                      isTablet: true,
                    ),
                    DetailsCard(
                      key: Key('three'),
                      isTablet: true,
                    ),
                    DetailsCard(
                      key: Key('four'),
                      isTablet: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 8),
              height: 600,
              width: 400,
              child: SingleChildScrollView(
                child: SendReceipt(isTablet: true),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InvoicePortrait extends StatelessWidget {
  const InvoicePortrait({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hp = ScreenUtils.of(context).hp;
    final wp = ScreenUtils.of(context).wp;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(hp(1)),
        child: Column(
          children: <Widget>[
            SendReceipt(),
            DetailsCard(
              key: Key('one'),
            ),
            DetailsCard(
              key: Key('two'),
            ),
          ],
        ),
      ),
    );
  }
}
