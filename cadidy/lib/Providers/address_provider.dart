import 'package:flutter/material.dart';

class AddressProvider with ChangeNotifier {
    String _address = '';
    String get address => _address;

    String _details = '';
    String get details => _details;

    bool get isFormValid => _address.isNotEmpty && _details.isNotEmpty;

    void setAddress(String value) {
        _address = value;
        notifyListeners();
    }

    void setDetails(String value) {
        _details = value;
        notifyListeners();
    }
}