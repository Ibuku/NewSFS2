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
import 'package:sfscredit/ui/widgets/menu.dart';
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
                drawer: MenuDrawer(user: model.user, logout: model.logout),
                
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

