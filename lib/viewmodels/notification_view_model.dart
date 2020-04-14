import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:sfscredit/models/user_notification.dart';

import '../viewmodels/application_view_model.dart';
import '../services/dialog_service.dart';
import '../services/application_service.dart';
import '../locator.dart';

class NotificationViewModel extends ApplicationViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final ApplicationService _application = locator<ApplicationService>();

  List<UserNotification> _notifications = [];
  List<UserNotification> get notifications => _notifications;

  void setNotifications(List<UserNotification> notifications) {
    _notifications = notifications;
    notifyListeners();
  }

  Future<void> getNotifications() async {
    var notificationsRes = await _application.getNotifications();
    if (notificationsRes.runtimeType == Response) {
      Map body = jsonDecode(notificationsRes.body);
      if (notificationsRes.statusCode == 200) {
        List rawData = body['data'];
        List<UserNotification> notifications = rawData.map((n) => UserNotification.fromMap((n))).toList();
        setNotifications(notifications);
      } else {
        _dialogService.showDialog(
            title: "Request Error",
            description: body['message'] ?? "Request Failed");
      }
    } else {
      _dialogService.showDialog(
          title: "Application Error", description: notificationsRes.toString());
    }
  }

  @override
  Future<void> init() async {
    setLoading(true);
    await getNotifications();
    setLoading(false);
  }
}
