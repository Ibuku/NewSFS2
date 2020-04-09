import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sfscredit/models/user.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/views/app/Apply/apply1.dart';
import 'package:sfscredit/ui/views/app/Dashboard/dashboard2.dart';
import 'package:sfscredit/ui/views/app/Loans/loan.dart';
import 'package:sfscredit/ui/views/app/Requests/allRequest.dart';
import 'package:sfscredit/ui/views/app/profile/Notifications.dart';
import 'package:sfscredit/ui/views/app/profile/settings.dart';

class MenuDrawer extends StatelessWidget {
  MenuDrawer({@required this.user, @required this.logout});

  final User user;
  final Function logout;

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: Container(
        color: primaryColor,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: new Text(
                "${user.firstname} ${user.lastname}",
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  user.profile.avatar != null
                      ? user.profile.avatar
                      : "https://d1nhio0ox7pgb.cloudfront.net/_img/g_collection_png/standard/512x512/person.png",
                ),
              ),
              decoration: new BoxDecoration(
                color: Hexcolor('#120A44'),
              ),
              accountEmail: new Text("${user.email}"),
            ),
            ListTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.white,
              ),
              title: Text(
                "Dashboard",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              title: Text(
                "Apply",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ApplyScreen1(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.content_paste,
                color: Colors.white,
              ),
              title: Text(
                "My Loans",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyLoanScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.save_alt,
                color: Colors.white,
              ),
              title: Text(
                "Requests",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllRequestScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.notifications_active,
                color: Colors.white,
              ),
              title: Text(
                "Notifications",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              title: Text(
                "Settings",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.cancel,
                color: Colors.white,
              ),
              title: Text(
                "Log out",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () async {
                await logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
