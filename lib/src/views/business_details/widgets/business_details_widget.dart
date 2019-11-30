import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/add_new_business/widgets/add_new_business_widget.dart';
import 'package:epaisa_pos/src/views/business_details/details/details_info_screen.dart';
import 'package:epaisa_pos/src/views/business_details/finential_info/business_details_financial_info.dart';
import 'package:epaisa_pos/src/views/business_details/information/business_details_info_screen.dart';
import 'package:epaisa_pos/src/widgets/header_card/header_widget.dart';
import 'package:epaisa_pos/src/widgets/utils/dialogs_helper.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class BusinessDetailsWidget extends StatefulWidget {
  CurrentCompany company;
  BusinessDetailsWidget({this.company, Key key}) : super(key: key);
  @override
  BusinessDetailsWidgetState createState() => BusinessDetailsWidgetState();
}

class BusinessDetailsWidgetState extends State<BusinessDetailsWidget> {
  int _selectedIndex = 0;
  Future<String> imageUrl;

  BehaviorSubject<String> _name = BehaviorSubject<String>();
  AddBusinessBloc bloc = AddBusinessBloc();
  bool valid = false;
  @override
  void initState() {
    bloc.createValid.listen((s) {
      print("VALID$s");
      valid = s;
    });
    if (widget.company != null) {
      bloc.changeCompany(
          widget.company.name != null ? widget.company.name : "");
      bloc.changeMail(widget.company.email != null ? widget.company.email : "");
      bloc.changePhone(
          widget.company.mobile != null ? widget.company.mobile : "");
    }
    super.initState();
  }

  void create() async {
    showLoading(context);
    //await bloc.updateBusiness(widget.company.id);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(MediaQuery.of(context));
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;

    Widget _getScreenTablet() {
      switch (_selectedIndex) {
        case 0:
          return Row(
            children: <Widget>[
              Expanded(
                child: BusinessInfoScreen(
                  company: widget.company,
                  changeName: (val) {
                    _name.sink.add(val);
                  },
                  bloc: bloc,
                ),
              ),
            ],
          );
        case 1:
          return Row(
            children: <Widget>[
              Expanded(
                child: BusinessDetailsInfoScreen(
                  company: widget.company,
                ),
              ),
            ],
          );
        case 2:
          return Row(
            children: <Widget>[
              Expanded(
                child: BusinessFinancialInfoScreen(),
              ),
            ],
          );
        default:
          return Row(
            children: <Widget>[
              Expanded(
                child: BusinessInfoScreen(),
              ),
            ],
          );
      }
    }

    Widget _tabNavigator() {
      List<String> options = ["Information", "Details", "Financial Info"];
      List<Widget> tabs = new List<Widget>();
      //var counter = 0;
      for (var i = 0; i < options.length; i++) {
        bool isSelected = i == _selectedIndex;
        var x = options[i];
        tabs.add(Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = i;
              });
              print(_selectedIndex);
            },
            child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: isSelected
                                ? AppColors.PrimaryBlue
                                : AppColors.PrimaryWhite,
                            width: 4))),
                alignment: Alignment.center,
                child: Text(
                  x,
                  style: TextStyle(
                      fontSize: tablet ? hp(2.3) : wp(3.6),
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? AppColors.PrimaryBlue
                          : AppColors.DisabledText.withOpacity(0.6)),
                )),
          ),
        ));
      }
      return Container(
        height: tablet ? hp(7) : hp(6),
        decoration: BoxDecoration(
          color: AppColors.PrimaryWhite,
          boxShadow: [
            BoxShadow(
                color: AppColors.DarkGray.withOpacity(0.3),
                offset: Offset(0, 2),
                blurRadius: 1)
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.PrimaryWhite,
            boxShadow: [
              BoxShadow(
                  color: AppColors.DarkGray.withOpacity(0.4),
                  offset: Offset(0.5, tablet ? 3.5 : 2.0),
                  blurRadius: 1.0)
            ],
          ),
          child: Row(
            children: tabs,
          ),
        ),
      );
    }

    Widget _getScreen() {
      switch (_selectedIndex) {
        case 0:
          return BusinessInfoScreen(
            company: widget.company,
            changeName: (val) {
              _name.sink.add(val);
            },
            bloc: bloc,
          );
        case 1:
          return BusinessDetailsInfoScreen(
            company: widget.company,
          );
        case 2:
          return BusinessFinancialInfoScreen();
        default:
          return BusinessInfoScreen(
            company: widget.company,
          );
      }
    }

    Widget buildEmployee() {
      return Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              verticalDirection: VerticalDirection.up,
              children: <Widget>[
                tablet ? _getScreenTablet() : _getScreen(),
                _tabNavigator(),
                CommonHeader(
                    account: true,
                    showButton: false,
                    text: widget.company.name,
                    id: widget.company.id != null ? widget.company.id : null,
                    imageUrl: widget.company.image != null
                        ? widget.company.image
                        : '',
                    streamName: _name),
              ],
            )),
          ),
        ],
      );
    }

    return buildEmployee();
  }
}
