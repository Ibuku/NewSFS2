import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/views/app/Apply/apply1.dart';
import 'package:sfscredit/ui/views/app/Dashboard/timeline.dart';
import 'package:sfscredit/ui/views/app/Dashboard/wallet.dart';
import 'package:sfscredit/ui/views/app/Loans/loan.dart';
import 'package:sfscredit/ui/views/app/Requests/allRequest.dart';
import 'package:sfscredit/ui/views/app/profile/Notifications.dart';
import 'package:sfscredit/ui/views/app/profile/settings.dart';
import 'package:sfscredit/ui/views/app/profile/update_kyc.dart';
import 'package:sfscredit/ui/widgets/card_item.dart';
import 'package:sfscredit/ui/widgets/menu.dart';
import 'package:sfscredit/ui/widgets/text_link.dart';
import 'package:sfscredit/viewmodels/application_view_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/widgets.dart';

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
          drawer: MenuDrawer(user: model.user, logout: model.logout),

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
    return Column(
      children: <Widget>[
        Container(
          child: new Container(
            child: new SingleChildScrollView(
              child: new ConstrainedBox(
                constraints: new BoxConstraints(),
                child: new Column(
                  children: <Widget>[
                    Container(
                      child: CardItem(
                        titleText: "Active Loans",
                        btnText: "N ${model.activeLoan}.00",
                        icon: Icons.cloud_download,
                        //onPressed: () => model.toRoute(UpdateKYC.routeName),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    CardItem(
                      titleText: "Guaranteed Loans",
                      btnText: "N ${model.currentGuarantorLoan}.00",
                      icon: Icons.person,
                      // onPressed: () => model.toRoute(UpdateKYC.routeName),
                    ),
                    verticalSpace15,
                    Container(
                      margin: EdgeInsets.only(
                        top: 5,
                        left: 5,
                      ),
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
                              color: primaryColor,
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
                      margin: EdgeInsets.only(
                        left: 10,
                      ),
                      padding: EdgeInsets.only(right: 110),
                      height: 50,
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            height: 380.0,
                          ),

                          Image(
                            image: AssetImage('assets/images/icon1.png'),
                            alignment: Alignment.topRight,
                          ),

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
                              color: primaryColor,
                              fontSize: 30,
                            ),
                          ),
//

                          //  SizedBox(width: 7.0),
                        ],
                      ),
                    ),
                    verticalSpace15,
                    Container(
                      margin: EdgeInsets.only(
                        top: 5,
                        left: 5,
                      ),
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
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          icon: Icon(
                            Icons.call_made,
                            color: Colors.white,
                          ),
                          label: Text(
                            'My Wallet',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          splashColor: Colors.white,
                          onPressed: () =>
                              model.toRoute(WalletScreen.routeName),
                        ),
                      ),
                    ),
                    verticalSpace15,
                    Container(
                      margin: EdgeInsets.only(
                        top: 5,
                        left: 3,
                      ),
                      padding: EdgeInsets.only(right: 200),
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
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
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
                      margin: EdgeInsets.only(
                        left: 10,
                      ),
                      padding: EdgeInsets.only(right: 8, top: 5),
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
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.indigo),
                            ),
                            backgroundColor: Colors.white,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Colors.lightBlue,
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
                            "N ${model.activeLoan}.00",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              fontSize: 30,
                            ),
                          ),
//
                          //  SizedBox(width: 7.0),
                        ],
                      ),
                    ),
                    verticalSpace15,
                    Container(
                      margin: EdgeInsets.only(right: 30.0, top: 5),
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
                                color: primaryColor,
                                fontSize: 17,
                              ),
                            ),
                            onPressed: () =>
                                model.toRoute(TimelineScreen.routeName),
                          ),

                          //Icon(Icons.arrow_forward, color: Colors.indigo[900]),
                          //  SizedBox(width: 7.0),
//
                        ],
                      ),
                    ),
                    verticalSpace30,
                    Container(
                      padding: EdgeInsets.only(right: 230),
                      height: 20,
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
                            "Overview",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          // ),

                          //  SizedBox(width: 7.0),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 15,
                        left: 20,
                      ),
                      padding: EdgeInsets.only(right: 225),
                      height: 40,
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
                          //margin: EdgeInsets.only(left: 10),
                          height: 100,
                          width: 150,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.white,
                            elevation: 10,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                const ListTile(
                                  leading: Icon(Icons.radio_button_checked,
                                      size: 20, color: primaryColor),
                                  title: Text('Loan',
                                      style: TextStyle(color: primaryColor)),
                                  subtitle: Text('20',
                                      style: TextStyle(color: primaryColor)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          height: 100,
                          width: 160,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: primaryColor,
                            elevation: 10,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                const ListTile(
                                  leading: Icon(
                                    Icons.radio_button_checked,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  title: Text('Request',
                                      style: TextStyle(color: Colors.white)),
                                  subtitle: Text('200',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
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
}