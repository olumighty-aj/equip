



import 'package:equipro/utils/base_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppStateProvider extends BaseModel {
  static AppStateProvider of(BuildContext context) =>
      Provider.of<AppStateProvider>(context, listen: false);
  int _currentTabIndex = 0; // Defaults to chat tab

  int get currentTabIndex => _currentTabIndex;

  void setCurrentTabTo({required int newTabIndex}) {

    _currentTabIndex = newTabIndex;
    notifyListeners();
  }

}
