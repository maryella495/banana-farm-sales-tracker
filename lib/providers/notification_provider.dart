import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  final List<String> _notifications = [];

  List<String> get notifications => _notifications;

  void addNotification(String message) {
    _notifications.add(message);
    notifyListeners();
  }

  void clearNotifications() {
    _notifications.clear();
    notifyListeners();
  }
}
