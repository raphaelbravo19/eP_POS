import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/views/cash_register/cash_register.dart';
import 'package:epaisa_pos/src/views/categories/categories_screen.dart';
import 'package:epaisa_pos/src/views/customers/customers_screen.dart';
import 'package:epaisa_pos/src/views/dashboard/dashboard_screen.dart';
import 'package:epaisa_pos/src/views/distributors/distributors_screen.dart';
import 'package:epaisa_pos/src/views/help/help_screen.dart';
import 'package:epaisa_pos/src/views/left_drawer/left_drawer_screen.dart';
import 'package:epaisa_pos/src/views/manufacturers/manufacturers_screen.dart';
import 'package:epaisa_pos/src/views/my_account/my_account_screen.dart';
import 'package:epaisa_pos/src/views/notifications/notifications_screen.dart';
import 'package:epaisa_pos/src/views/packages/packages_screen.dart';
import 'package:epaisa_pos/src/views/point_of_sale/point_of_sale_screen.dart';
import 'package:epaisa_pos/src/views/products/products_screen.dart';
import 'package:epaisa_pos/src/views/promotions/promotions_screen.dart';
import 'package:epaisa_pos/src/views/receipt_screen/receipt_screen.dart';
import 'package:epaisa_pos/src/views/saved_transactions/saved_transactions_screen.dart';
import 'package:epaisa_pos/src/views/setting_screen/settings_screen.dart';
import 'package:epaisa_pos/src/views/shopping_cart/shopping_cart_screen.dart';
import 'package:epaisa_pos/src/views/shopping_cart/widgets/cart_order_summary.dart';
import 'package:epaisa_pos/src/views/transactions/transactions_screen.dart';
import 'package:flutter/material.dart';

class MainViewScreen extends StatefulWidget {
  final int defaultIndex;
  final String initialLogin;
  MainViewScreen({this.defaultIndex = 5, this.initialLogin});

  @override
  _MainViewScreen createState() {
    return new _MainViewScreen();
  }
}

class _MainViewScreen extends State<MainViewScreen> {
  int _selectedIndex = 5;
  int tabIndex = 0;
  @override
  void initState() {
    _selectedIndex = widget.defaultIndex;
    super.initState();
  }

  final drawerItems = [
    eptxt('products'),
    eptxt('manufacturers'),
    eptxt('categories'),
    eptxt('distributors'),
    eptxt('transactions'),
    "Point of Sale",
    "Dashboard",
    "Receipt",
    "Cash Register",
    eptxt('customers'),
    "Help",
    eptxt('promotions'),
  ];
  // OMAR TE EXTRAÑO
  _getDrawerItemScreen(int pos) {
    switch (pos) {
      case 0:
        return ProductsScreen();
      case 1:
        return ManufacturersScreen();
      case 2:
        return CategoriesScreen();
      case 3:
        return DistributorsScreen();
      case 4:
        return TransactionsScreen();
      case 5:
        return PointOfSaleScreen(navigate: (index) {
          setState(() {
            _selectedIndex = index;
            _getDrawerItemScreen(_selectedIndex);
          });
        });
      case 6:
        return DashboardScreen(navigate: (index) {
          setState(() {
            _selectedIndex = index;
            _getDrawerItemScreen(_selectedIndex);
          });
        });
      case 7:
        return ReceiptScreen();
      case 8:
        return CashRegister();
      case 9:
        return CustomersScreen();
      case 10:
        return HelpScreen(
          index: widget.defaultIndex == 10 ? 1 : -1,
        );
      case 11:
        return PromotionsScreen();
      case 12:
        return PackagesScreen();
      case 13:
        return SettingsScreen();
      case 14:
        return SavedTransactions();
      case 15:
        return NotificationsScreen(navigate: (index) {
          setState(() {
            _selectedIndex = index;
            _getDrawerItemScreen(_selectedIndex);
          });
        });
      case 16:
        return MyAccountScreen();
    }
  }

  _onSelectItem(int index) {
    setState(() {
      _selectedIndex = index;
      _getDrawerItemScreen(_selectedIndex);
    });
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    List<Widget> drawerOptions = List<Widget>();
    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      drawerOptions.add(GestureDetector(
        //leading: new Icon(d.icon),
        child: Text(
          d,
          style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
        ),
        //selected: i == _selectedIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return Scaffold(
      endDrawer: tablet
          ? null
          : _selectedIndex != 5
              ? null
              : SizedBox(
                  child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(-2, 0),
                              blurRadius: 10.0,
                              spreadRadius: 0.5),
                        ],
                      ),
                      child: ShoppingCartScreen(
                        content: CartOrderSummary(),
                      )),
                  width: wp(90),
                ),
      // Drawer(child: Container(width: 500, height: 400, color: Colors.red)),
      drawer: SizedBox(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              new BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  offset: Offset(4, 0),
                  blurRadius: 5.0,
                  spreadRadius: 0.5),
            ],
          ),
          child: LeftDrawerScreen(
              tabIndex: tabIndex,
              changeTab: (val) {
                setState(() {
                  tabIndex = val;
                });
              },
              onTap: (val) {
                _onSelectItem(val);
              }),
        ),
        width: tablet ? wp(35) : wp(87),
      ),
      body: _getDrawerItemScreen(_selectedIndex),
    );
  }
}
