
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/views/app/Apply/apply1.dart';
import 'package:sfscredit/ui/views/app/Dashboard/dashboard2.dart';
import 'package:sfscredit/ui/views/app/Loans/loan.dart';
import 'package:sfscredit/ui/views/app/Requests/allRequest.dart';
import 'package:sfscredit/ui/views/app/profile/update_kyc.dart';
import 'package:sfscredit/ui/widgets/card_item.dart';
import 'package:sfscredit/ui/widgets/text_link.dart';
import 'package:sfscredit/viewmodels/application_view_model.dart';
import 'package:flutter/widgets.dart';

//import 'profile/update_kyc.dart';
//import 'package:sfscredit/ui/views/app/profile/settings.dart';
//import 'package:settings_ui/settings_ui.dart';

class TimelineScreen extends StatefulWidget {
  static const routeName = '/app/Dashboard/wallet';
  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}


class _TimelineScreenState extends State<TimelineScreen> {

  get value => null;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ApplicationViewModel>.withConsumer(
      viewModel: ApplicationViewModel(),
      //onModelReady: (model) => model.init(),
      builder: (context, model, child) =>
          WillPopScope(
            onWillPop: () async => await model.onWillPop(),
            child: Scaffold(
              appBar: AppBar(
                title: Text("Loan Timeline"),
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
              body: Container(
                child: SingleChildScrollView(
                  child: new Container(
                    child: new SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      child: new ConstrainedBox(
                        constraints: new BoxConstraints(),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SizedBox(height:1.0),
                            Container(
                              margin: EdgeInsets.only(right: 30.0,top: 5),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[


                                  RaisedButton(
                                    color: Colors.white,
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      "Timeline",
                                      style: TextStyle(
                                        color: Colors.indigo[900],
                                        fontSize: 17,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TimelineScreen(),
                                        ),
                                      );
                                    },
                                  ),

                                ],

                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5, left: 30),
                              //padding: EdgeInsets.only(right: 280),
                              height: 40,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    height: 380.0,
                                  ),


                                  // RaisedButton(

                                  Text(
                                    "Transactions",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
//
                                  // ),

                                  //  SizedBox(width: 7.0),
                                ],
                              ),
                            ),

                            // SizedBox(height: 5,),
                            ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text("Credit",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text("Date",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    trailing: Text("N0.00",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                }, separatorBuilder: (context, index) {
                              return Divider(height: 16,);
                            }, itemCount: 10),

                          ],
                        ),
                      ),
                    ),
                  ),

                ),
              ),
            ),
          ),
    );
  }
}
