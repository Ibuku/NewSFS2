import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/views/app/Apply/apply1.dart';
import 'package:sfscredit/ui/views/app/Dashboard/dashboard2.dart';
import 'package:sfscredit/ui/views/app/Dashboard/timeline.dart';
import 'package:sfscredit/ui/views/app/Loans/loan.dart';
import 'package:sfscredit/ui/views/app/Requests/allRequest.dart';
import 'package:sfscredit/ui/views/app/profile/update_kyc.dart';
import 'package:sfscredit/ui/widgets/card_item.dart';
import 'package:sfscredit/viewmodels/application_view_model.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = '/app/profile/settings';
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var value = true;

  
  @override
  Widget build(BuildContext context) {
     // var value;
      return ViewModelProvider<ApplicationViewModel>.withConsumer(
        viewModel: ApplicationViewModel(),
        //onModelReady: (model) => model.init(),
        builder: (context, model, child) =>
            WillPopScope(
              onWillPop: () async => await model.onWillPop(),
              child: Scaffold(
                appBar: AppBar(
                  title: Text("Settings"),
                  centerTitle: false,
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(FeatherIcons.logOut),
                      onPressed: () async {
                        await model.logout();
                      },
                    ),
                  ],

                ),
                drawer: new Drawer(
                  child: Container(
                    color: Hexcolor('#120A44'),
                    child: ListView(
                      children: <Widget>[
                        UserAccountsDrawerHeader(

                          accountName: new Text(
                            "Allen Joe",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          currentAccountPicture: CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://d1nhio0ox7pgb.cloudfront.net/_img/g_collection_png/standard/512x512/person.png",),
                          ),
                          decoration: new BoxDecoration(
                            color: Hexcolor('#120A44'),
                          ),
                          accountEmail: new Text("babatundeibukun@gmail.com"),
                        ),
                        ListTile(

                          leading: Icon(Icons.dashboard, color: Colors.white,),
                          title: Text("Dashboard",
                            style: TextStyle(
                              color: Colors.white,
                            ),),
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
                          leading: Icon(Icons.menu, color: Colors.white,),

                          title: Text("Apply",
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
                            Icons.content_paste, color: Colors.white,),
                          title: Text("My Loans",
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
                          leading: Icon(Icons.save_alt, color: Colors.white,),
                          title: Text("Requests",
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
                            Icons.notifications_active, color: Colors.white,),
                          title: Text("Notifications",
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
                          leading: Icon(Icons.settings, color: Colors.white,),
                          title: Text("Settings",
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
                          leading: IconButton(
                            icon: Icon(FeatherIcons.logOut),
                            onPressed: () async {
                              await model.logout();
                            },
                          ),

                        ),
                      ],
                    ),
                  ),
                ),
                
                backgroundColor: Colors.white,
                body:
                          //child: SingleChildScrollView(
                                    SettingsList(
                                      sections: [
                                        SettingsSection(
                                          // title: 'Account',
                                          tiles: [
                                            SettingsTile(
                                              title: 'Account',
                                              subtitle: 'Edit Profile',
                                              leading: Icon(Icons.person_outline),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => UpdateKYC(),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        SettingsSection(
                                          // title: 'Account',
                                          tiles: [

                                            SettingsTile.switchTile(
                                              title: 'Notification',
                                              subtitle: 'Allow Notifications',
                                              leading: Icon(Icons.notifications_none),
                                              switchValue: value,
                                              onToggle: (bool value) {},
                                            ),

                                          ],

                                        ),
                                        SettingsSection(
                                          // title: 'Account',
                                          tiles: [

                                            SettingsTile(
                                              title: 'Others',
                                              //subtitle: 'Allow Notifications',
                                              // leading: Icon(Icons.notifications_none),

                                            ),

                                          ],

                                        ),
                                        SettingsSection(
                                          // title: 'Account',
                                          tiles: [

                                            SettingsTile(
                                              title: 'Privacy Policy',
                                              //subtitle: 'Allow Notifications',
                                              // leading: Icon(Icons.notifications_none),

                                            ),

                                          ],

                                        ),
                                        SettingsSection(
                                          // title: 'Account',
                                          tiles: [

                                            SettingsTile(
                                              title: 'Terms & Conditions',
                                              //subtitle: 'Allow Notifications',
                                              // leading: Icon(Icons.notifications_none),

                                            ),

                                          ],

                                        ),

                                      ],
                                    ),


                                ),
                              ),
      );
  }
  }

