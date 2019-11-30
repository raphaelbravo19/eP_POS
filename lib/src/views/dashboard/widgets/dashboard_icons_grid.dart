import './dashboard_item.dart';
import 'package:flutter/material.dart';

class DashboardIconsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final int columns;
  final int rows;
  final bool isTablet;
  const DashboardIconsGrid({
    @required this.items,
    @required this.columns,
    @required this.rows,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    print(items.length);
    final List data = <Widget>[];
    for (var i = 0; i < columns; i++) {
      var children = items.sublist(i * rows, rows * (i + 1)).map((item) {
        return Expanded(
          child: DashboardItem(
              isTablet: isTablet,
              title: item['title'],
              image: item['image'],
              badge: item['badge'],
              size: item['size'],
              tsize: item['tsize'],
              borderRight: isTablet ? item['lnbr'] : item['psbr'],
              borderBottom: isTablet ? item['lnbb'] : item['psbb'],
              onTap: item['onTap'],
              commingSoon:
                  item['commingSoon'] != null ? item['commingSoon'] : false),
        );
      });
      data.add(Expanded(
          child: Row(
        children: children.toList(),
      )));
    }

    return Column(
      children: data,
    );
  }
}
