import 'package:flutter/material.dart';

import 'dart:math';

bool isTablet(MediaQueryData query) {
  var size = query.size;
  var diagonal = sqrt((size.width * size.width) + (size.height * size.height));
  var isTablet = diagonal > 1100.0;
  return isTablet;
}
