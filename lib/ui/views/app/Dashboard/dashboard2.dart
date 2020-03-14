
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/views/app/Apply/apply1.dart';
import 'package:sfscredit/ui/views/app/Dashboard/timeline.dart';
import 'package:sfscredit/ui/views/app/Dashboard/wallet.dart';
import 'package:sfscredit/ui/views/app/Loans/loan.dart';
import 'package:sfscredit/ui/views/app/Requests/allRequest.dart';
import 'package:sfscredit/ui/views/app/profile/update_kyc.dart';
import 'package:sfscredit/ui/widgets/card_item.dart';
import 'package:sfscredit/ui/widgets/text_link.dart';
import 'package:sfscredit/viewmodels/application_view_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/widgets.dart';

//import 'profile/update_kyc.dart';
//import 'package:sfscredit/ui/views/app/profile/settings.dart';
//import 'package:settings_ui/settings_ui.dart';


class DashboardScreen extends StatelessWidget {

  static const routeName = '/app/dashboard';

  get value => null;

  BuildContext get context => null;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ApplicationViewModel>.withConsumer(
      viewModel: ApplicationViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async => await model.onWillPop(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Dashboard"),
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
                      "${model.user.firstname} ${model.user.lastname}",
                      style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://d1nhio0ox7pgb.cloudfront.net/_img/g_collection_png/standard/512x512/person.png",),
                    ),
                    decoration: new BoxDecoration(
                      color: Hexcolor('#120A44'),
                    ),
                    accountEmail: new Text("${model.user.email}"),
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
                    leading: Icon(Icons.menu,color: Colors.white,),

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
                    leading:  Icon(Icons.content_paste,color: Colors.white,),
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
                    leading: Icon(Icons.save_alt,color: Colors.white,),
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
                    leading: Icon(Icons.notifications_active,color: Colors.white,),
                    title: Text("Notifications",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WalletScreen(),
                        ),
                      );

                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings,color: Colors.white,),
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

          // backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: model.user.profile == null
                ? profileNotSet(model)
                : profileSetup(model),
          ),
        ),
      ),
    );
  }
  Widget profileNotSet(ApplicationViewModel model) {
    return Column(
      children: <Widget>[
        CardItem(
          titleText: "Update KYC",
          btnText: "Update",
          icon: Icons.person,
          onPressed: () => model.toRoute(UpdateKYC.routeName),
        ),
        verticalSpace15,
        CardItem(
          titleText: "Your first loan",
          btnText: "Apply",
          icon: Icons.keyboard_tab,
          onPressed: () {},
        ),
      ],
    );
  }

    Widget profileSetup(ApplicationViewModel model) {
      return Column (
        children: <Widget>[
        Container(
        //  child: SingleChildScrollView(
            child: new Container(
              child: new SingleChildScrollView(
                child: new ConstrainedBox(
                  constraints: new BoxConstraints(),
                  child: new Column(children: <Widget>[

                    CardItem(
                      titleText: "Active Loans",
                      btnText: "N ${model.activeLoan}",
                      icon: Icons.cloud_download,
                      //onPressed: () => model.toRoute(UpdateKYC.routeName),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    CardItem(
                      titleText: "Guaranteed Loans",
                      btnText: "N 20,000",
                      icon: Icons.person,
                     // onPressed: () => model.toRoute(UpdateKYC.routeName),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 5,),
                      padding: EdgeInsets.only(right: 195),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            height: 380.0,
                          ),

                          Text(
                            "Wallet Balance ",
                            style: TextStyle(
                              color: Colors.indigo[900],
                              fontSize: 17,
                            ),
                          ),
//
                          // ),

                          //  SizedBox(width: 7.0),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      margin: EdgeInsets.only( left: 10, ),
                      padding: EdgeInsets.only( right: 110),
                      height: 50,
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            height: 380.0,
                          ),

                          Image(image: AssetImage('assets/images/icon1.png'),alignment: Alignment.topRight,),

                          SizedBox(
                            height: 380.0,
                          ),
                          // RaisedButton(
//
//                                shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(20),
//                                ),
                          Text(
                            "N ${model.walletBalance}.00",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo[900],
                              fontSize: 30,
                            ),
                          ),
//

                          //  SizedBox(width: 7.0),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 5,),
                      padding: EdgeInsets.only(right: 225),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          //  SizedBox(width: 7.0),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 10, left: 15, right: 14),
                      height: 50,
                      child: Center(

                          child: RaisedButton.icon(
                            color: Hexcolor('#120A44'),
                            icon: Icon(Icons.call_made,color: Colors.white,),
                            label: Text('My Wallet',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white,),
                            ),
                            splashColor: Colors.white,
                           onPressed: () => model.toRoute(WalletScreen.routeName),
                          ),

                      ),
                    ),

                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 5,),
                      padding: EdgeInsets.only(right: 215),
                      height: 40,
                      child: Row(
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
                            "Active Loans",
                            style: TextStyle(
                              color: Colors.indigo[900],
                              fontSize: 17,
                            ),
                          ),

                          // ),

                          //  SizedBox(width: 7.0),
                        ],
                      ),
                    ),


                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      margin: EdgeInsets.only( left: 10,),
                      padding: EdgeInsets.only( right: 10,top:5 ),
                      height: 150,
                      width: 250,
                      child: Row(


                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          SizedBox(
                            height: 5.0,
                          ),
                          new CircularPercentIndicator(
                            radius: 130.0,
                            lineWidth: 15.0,
                            animation: true,
                            percent: 0.7,
                            center: new Text(
                              "70.0%",
                              style:
                              new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0,color: Colors.indigo),
                            ),

                            backgroundColor: Colors.white,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Colors.lightBlueAccent,
                          ),

                          SizedBox(
                            height: 5.0,
                          ),


                          // RaisedButton(
//
//                                shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(20),
//                                ),
                          Text(
                            "N 0.00",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo[900],
                              fontSize: 30,
                            ),
                          ),
//
                          //  SizedBox(width: 7.0),
                        ],
                      ),
                    ),
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

                          //Icon(Icons.arrow_forward, color: Colors.indigo[900]),
                          //  SizedBox(width: 7.0),
//
                        ],

                      ),
                    ),

                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, left: 20,),
                      padding: EdgeInsets.only(right: 220),
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          // ),

                          //  SizedBox(width: 7.0),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only( right: 10,left: 15),
                          padding: EdgeInsets.only(right: 25, ),
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(
                                    75,
                                    97,
                                    119,
                                    .1,
                                  ),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                )
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Image(image: AssetImage('assets/images/circle1.png'),alignment: Alignment.topRight,),
                              //  Icon(Icons.radio_button_unchecked, color: Hexcolor('#120A44'),
                              Text(
                                "Loans ",
                                style: TextStyle(
                                  wordSpacing: 5,
                                  color: Hexcolor('#120A44'),
                                  fontSize: 17,
                                  //fontFamily: 'Nunito-Light',
                                ),
                              ),
//
                              // ),


                              //  SizedBox(width: 7.0),
                            ],
                          ),


                        ),
                        Container(
                          //margin: EdgeInsets.only( right: 10),
                         // padding: EdgeInsets.only(right: 3, ),
                          height: 100,
                          width: 145,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
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
                                  offset: Offset(0, 10),
                                )
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[

                              Image(image: AssetImage('assets/images/circle2.png'),alignment: Alignment.topCenter,),
                              //Icon(Icons.radio_button_unchecked, color: Colors.white,),

                              Text(
                                "Requests ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
//
                              // ),
                              Text(
                                "20",
                                style: TextStyle(
                                  color: Colors.indigo[900],
                                  fontSize: 17,
                                ),
                              ),
//
                              //  SizedBox(width: 7.0),
                            ],
                          ),


                        ),
                      ],
                    ),

                  ],
                  ),
                ),
              ),
            ),
          ),
          ],

        );

    }


//  Widget profileSetup() {
//    return Column(
//      children: <Widget>[
//        Text("profile setup"),
//
//      ],
//    );
//  }
}



