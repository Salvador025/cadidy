import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
    bool _order = false;
    bool get order => _order;

    void setOrder(bool value) {
        _order = value;
        notifyListeners();
    }
}
