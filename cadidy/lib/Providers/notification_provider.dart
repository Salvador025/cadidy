import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
    bool _notification = false;
    bool get notification => _notification;

    void setNotification(bool value) {
        _notification = value;
        notifyListeners();
    }
}


