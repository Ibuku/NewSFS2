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

class ApprovedRequestScreen extends StatefulWidget {
  static const routeName = '/app/Requests/approvedRequest';
  @override
  _ApprovedRequestScreenState createState() => _ApprovedRequestScreenState();
}

class _ApprovedRequestScreenState extends State<ApprovedRequestScreen> {
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
                            Container(
                              //margin: EdgeInsets.only(top: 5,),
                              //padding: EdgeInsets.only(right: 240),
                              height: 100,
                              decoration: BoxDecoration(
                                //borderRadius: BorderRadius.circular(20),
                                  color: Hexcolor('#120A44'),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(
                                        75,
                                        97,
                                        119,
                                        .1,
                                      ),
                                      blurRadius: 20,
                                      offset: Offset(0, 10),)
                                  ]),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  Container(
                                    color: Colors.transparent,
                                    width: 140.0,
                                    child: RaisedButton(
                                      // padding: EdgeInsets.only(top: 20, left: 1, right: 1),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AllRequestScreen(),
                                          ),
                                        );
                                      },
                                      splashColor: Colors.white,
                                      //decoration: BoxDecoration(

                                      child: Center(
                                        child: Text(
                                          "All",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 140.0,

                                    child: Center(
                                      child: Text(
                                        "Pending",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 140.0,

                                    child: Center(
                                      child: Text(
                                        "Approved",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 140.0,

                                    child: Center(
                                      child: Text(
                                        "Declined",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ),
//
//
//
//
                                  // ),

                                  //  SizedBox(width: 7.0),
                                ],
                              ),
                            ),

                            // History
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5,left: 30),
                              //padding: EdgeInsets.only(right: 280),
                              height: 40,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    height: 380.0,
                                  ),
                                  // RaisedButton(
//
//                                shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(20),
//                                ),
                                  Text(
                                    "History",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Hexcolor('#120A44'),
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
                                itemBuilder: (context,index){
                                  return ListTile(
                                    title: Text("Package 1",
                                      style: TextStyle(color: Hexcolor('#120A44'),fontSize: 17,fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text("Date"),
                                    trailing: Text("N0.00"),
                                  );
                                }, separatorBuilder: (context, index){
                              return Divider(height: 16,);
                            },itemCount: 7),

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

