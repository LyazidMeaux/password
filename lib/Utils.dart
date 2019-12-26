import 'dart:math';

import 'package:intl/intl.dart';

Random _random = Random();
int next(int min, int max) => min + (_random.nextInt(max - min));

String getStamp() {
  String stamp = DateFormat('ddMMyyyy-hms').format(DateTime.now());

  // new DateFormat('yyyy-MM-dd h:m:s').format(le),
  //          .format(DateTime.parse("2018-09-15 20:18:04Z")),

  return stamp;
}
