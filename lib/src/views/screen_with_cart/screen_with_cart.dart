import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/views/shopping_cart/shopping_cart_screen.dart';
import 'package:epaisa_pos/src/views/shopping_cart/widgets/cart_order_summary.dart';
import 'package:flutter/material.dart';

class ScreenWithCart extends StatelessWidget {
  final Widget body;
  final Widget cart;
  ScreenWithCart({
    this.body,
    this.cart,
    this.transactionsFooter = false,
  });
  final bool transactionsFooter;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 65,
          child: body,
        ),
        Expanded(
          flex: 35,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                    color: AppColors.Black.withOpacity(0.6),
                    offset: new Offset(-3, 0),
                    blurRadius: 7.0),
              ],
            ),
            child: cart != null
                ? cart
                : ShoppingCartScreen(
                    transactionsFooter: transactionsFooter,
                    content: CartOrderSummary(),
                  ),
          ),
        )
      ],
    );
  }
}
