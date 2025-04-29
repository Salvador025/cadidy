import 'package:flutter/material.dart';

class AddressProvider with ChangeNotifier {
    String _address = '';
    String get address => _address;

    String _details = '';
    String get details => _details;

    double _latitude = 20.608229;
    double get latitude => _latitude;

    double _longitude = -103.417031;
    double get longitude => _longitude;

    double _price = 0.0;
    double get price => _price;

    bool get isFormValid => _address.isNotEmpty && _details.isNotEmpty && _price > 0.0;

    void setAddress(String value) {
        _address = value;
        notifyListeners();
    }

    void setlatitude(double value) {
        _latitude = value;
        notifyListeners();
    }

    void setlongitude(double value) {
        _longitude = value;
        notifyListeners();
    }

    void setDetails(String value) {
        _details = value;
        notifyListeners();
    }

    void setPrice(double value) {
        _price = value;
        notifyListeners();
    }

    void reset() {
        _address = '';
        _details = '';
        _latitude = 20.608229;
        _longitude = -103.417031;
        _price = 0.0;
        notifyListeners();
    }
}