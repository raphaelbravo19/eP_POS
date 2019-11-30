import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/shared/epaisa_scaffold.dart';
import 'package:epaisa_pos/src/views/shared/new_epaisa_app_bar.dart';
import 'package:epaisa_pos/src/widgets/texts/text_blue.dart';
import 'package:epaisa_pos/src/widgets/texts/text_gray.dart';
import 'package:flutter/material.dart';

class TabNavigationScreen extends StatefulWidget {
  final List<Map> screens;
  final String title;
  TabNavigationScreen({
    @required this.screens,
    @required this.title,
  });
  @override
  _TabNavigationScreenState createState() => _TabNavigationScreenState();
}

class _TabNavigationScreenState extends State<TabNavigationScreen> {
  int _selectedIndex;
  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    Widget _getScreen() {
      return widget.screens[_selectedIndex]['content'];
    }

    Widget _tabNavigator() {
      List<String> options =
          widget.screens.map((f) => f['title'].toString()).toList();
      List<Widget> tabs = new List<Widget>();
      //var counter = 0;
      for (var i = 0; i < options.length; i++) {
        bool isSelected = i == _selectedIndex;
        var x = options[i];
        tabs.add(Expanded(
          flex: tablet ? 1 : i == 2 ? 3 : 5,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = i;
              });
              print(_selectedIndex);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(
                          color: isSelected
                              ? AppColors.PrimaryBlue
                              : AppColors.DisabledBorder,
                          width: 2.5))),
              alignment: Alignment.center,
              child: isSelected
                  ? TextBlue(
                      title: x,
                      fontSize: tablet ? hp(2) : hp(1.7),
                      fontWeight: FontWeight.w700,
                    )
                  : TextGray(
                      title: x,
                      fontSize: tablet ? hp(2) : hp(1.7),
                      fontWeight: FontWeight.w700,
                      opacity: 0.6,
                    ),
            ),
          ),
        ));
      }
      return Container(
        height: tablet ? hp(7) : hp(5.5),
        child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
          Container(
            width: tablet ? wp(100) : wp(110),
            child: Row(
              children: tabs,
            ),
          ),
        ]),
      );
    }

    return EpaisaScaffold(
      appBar: EpaisaAppBar(
        title: widget.title.toUpperCase(),
        back: true,
      ),
      body: Column(
        verticalDirection: VerticalDirection.up,
        children: <Widget>[Expanded(child: _getScreen()), _tabNavigator()],
      ),
    );
  }
}
