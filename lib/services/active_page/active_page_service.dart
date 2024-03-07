import 'dart:async';
import 'package:drinkup_app/constants/route_constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ActivePageService {
  final ValueNotifier<int> activePage = ValueNotifier<int>(Routes.menu.index);

  ActivePageService._();

  static final ActivePageService _instance = ActivePageService._();

  factory ActivePageService() {
    return _instance;
  }

  void setActivePage(int index) {
    activePage.value = index;
    if (index == Routes.menu.index) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    }
  }

  void dispose() {
    activePage.dispose();
  }
}
