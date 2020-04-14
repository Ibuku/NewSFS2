import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:sfscredit/models/user_notification.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/widgets/busy_overlay.dart';
import 'package:sfscredit/ui/widgets/custom_card.dart';
import 'package:sfscredit/ui/widgets/menu.dart';
import 'package:sfscredit/viewmodels/notification_view_model.dart';

class NotificationScreen extends StatelessWidget {
  static const routeName = '/app/profile/Notifications';

  get value => null;

  Widget notificationCard(UserNotification notification) {
    return CustomCard(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
        child: Row(
          children: <Widget>[
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: primaryColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 25,
                    offset: Offset(0, 10)
                  )
                ]
              ),
            ),
            horizontalSpaceSmall,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${notification.formattedMessage}",
                  style: GoogleFonts.mavenPro(
                    textStyle: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
                Text(
                  "${notification.message}",
                  style: GoogleFonts.mavenPro(
                    textStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: lightGrey,
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }

  List<UserNotification> filterNotifications(
      {List<UserNotification> notifications,
      List<Map> notificationDates,
      Function condition}) {
    return notificationDates.where((notificationDate) {
      return condition(notificationDate['date_time']);
    }).map((n) {
      UserNotification notification = notifications[n['index']];
      return notification;
    }).toList();
  }

  List<Map> generateNotificationsData(List<UserNotification> notifications) {
    final result = <Map>[];
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    final List<Map> notificationDates = notifications
        .map((notification) => {'index': notifications.indexOf(notification), 'date_time': DateTime.parse(notification.date)})
        .toList();

    List<UserNotification> todaysNotifications = filterNotifications(
        notifications: notifications,
        notificationDates: notificationDates,
        condition: (date) => date == today);
    List<UserNotification> yesterdaysNotifications = filterNotifications(
        notifications: notifications,
        notificationDates: notificationDates,
        condition: (date) => date == yesterday);

    List<UserNotification> olderNotifications = filterNotifications(
        notifications: notifications,
        notificationDates: notificationDates,
        condition: (date) => date != today && date != yesterday);
    if(todaysNotifications.length > 0){
      result.add({
        'title': 'Today',
        'notifications': todaysNotifications,
        'date': new DateFormat('dth MMMM, yyyy').format(today)
      });
    }
    if(yesterdaysNotifications.length > 0){
      result.add({
        'title': 'Yesterday',
        'notifications': yesterdaysNotifications,
        'date': new DateFormat('dth MMMM, yyyy').format(yesterday)
      });
    }
    if(olderNotifications.length > 0){
      result.add({'title': 'Older', 'notifications': olderNotifications, 'date': null });
    }
    return result;
  }

  List<Widget> buildNotifications(List<UserNotification> notifications) {
    if(notifications.length < 1) {
      return [Container()];
    }
    List<Map> notificationData = generateNotificationsData(notifications);

    return notificationData.map((nData) {
      return Container(
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "${nData['title']}",
                    style: GoogleFonts.mavenPro(
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  nData['date'] != null ? Text(
                    "${nData['date']}",
                    style: GoogleFonts.mavenPro(
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                  ): Container(),
                ],
              ),
              verticalSpace15,
              ListView.separated(
                shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return notificationCard(nData['notifications'][index]);
                  },
                  separatorBuilder: (context, index) {
                    return verticalSpace15;
                  },
                  itemCount: nData['notifications'].length)
            ],
          ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<NotificationViewModel>.withConsumer(
      viewModel: NotificationViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("Notifications"),
          centerTitle: false,
        ),
        backgroundColor: Colors.white,
        drawer: MenuDrawer(user: model.user, logout: model.logout),
        body: BusyOverlay(
          title: "Loading...",
          show: model.loading,
          child: Container(
            child: new SingleChildScrollView(
              child: new ConstrainedBox(
                constraints: new BoxConstraints(),
                child: new Column(
                  children: <Widget>[
                    verticalSpace15,
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: primaryColor,
                      ),
                      child: Column(
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                Icons.notifications_none,
                                size: 20,
                                color: Colors.white,
                              ),
                              new Text(
                                'Notifications',
                                style: GoogleFonts.mavenPro(
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ...buildNotifications(model.notifications)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
