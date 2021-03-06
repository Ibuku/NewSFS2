import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/views/app/Apply/apply1.dart';
import 'package:sfscredit/ui/views/app/Dashboard/wallet.dart';
import 'package:sfscredit/ui/views/app/profile/update_kyc.dart';
import 'package:sfscredit/ui/widgets/busy_overlay.dart';
import 'package:sfscredit/ui/widgets/card_item.dart';
import 'package:sfscredit/ui/widgets/menu.dart';
import 'package:sfscredit/viewmodels/application_view_model.dart';
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
          ),
          drawer: MenuDrawer(user: model.user, logout: model.logout),
          // backgroundColor: Colors.white,
          body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: BusyOverlay(
                show: model.loading || model.busy,
                overlayBackground: Colors.white,
                child: model.user.profile == null
                    ? profileNotComplete(model)
                    : profileComplete(model),
              )),
        ),
      ),
    );
  }

  Widget profileNotComplete(ApplicationViewModel model) {
    return !model.loading
        ? Column(
            children: <Widget>[
              model.user.profile == null
                  ? CardItem(
                      titleText: "Update KYC",
                      btnText: "Update",
                      icon: Icons.person,
                      onPressed: () => model.toRoute(UpdateKYC.routeName),
                    )
                  : Container(),
              verticalSpace15,
              CardItem(
                titleText: "Your first loan",
                btnText: "Apply",
                icon: Icons.keyboard_tab,
                onPressed: () => model.toRoute(ApplyScreen1.routeName),
              ),
            ],
          )
        : Container();
  }

  Widget profileComplete(ApplicationViewModel model) {
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
                        titleText: "Total Borrowed Loans",
                        btnText:
                            "N ${model.formatNumber(model.borrowedLoansTotal)}.00",
                        icon: Icons.cloud_download,
                        //onPressed: () => model.toRoute(UpdateKYC.routeName),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    CardItem(
                      titleText: "Total Guaranteed Loans",
                      btnText:
                          "N ${model.formatNumber(model.totalGuarantorLoan)}.00",
                      icon: Icons.person,
                      // onPressed: () => model.toRoute(UpdateKYC.routeName),
                    ),
                    verticalSpace15,
                    Container(
                      margin: EdgeInsets.only(
                        top: 5,
                        left: 5,
                      ),
                      height: 25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Wallet Balance ",
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(5),
                    Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/images/icon1.png'),
                            alignment: Alignment.topRight,
                          ),
                          horizontalSpace(15),
                          Text(
                            "N ${model.walletBalance}.00",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpace15,
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
                            onPressed: () {
                              model.toRoute(WalletScreen.routeName);
                            }),
                      ),
                    ),
                    verticalSpace15,
                    Container(
                      margin: EdgeInsets.only(
                        top: 5,
                        left: 3,
                      ),
                      padding: EdgeInsets.only(right: 200),
                      height: 25,
                      child: Text(
                        "Payment Progress",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    verticalSpace15,
                    Container(
                      margin: EdgeInsets.only(
                        left: 10,
                      ),
                      padding: EdgeInsets.only(right: 8, top: 5),
                      height: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CircularPercentIndicator(
                            radius: 130.0,
                            lineWidth: 15.0,
                            animation: true,
                            percent: (model.activeLoansTotalPaid /
                                        model.activeLoanTotal)
                                    .isNaN
                                ? 0
                                : (model.activeLoansTotalPaid /
                                    model.activeLoanTotal),
                            header: Text(
                                "Paid = N ${model.formatNumber(model.activeLoansTotalPaid)}.00",
                              style: TextStyle(color: primaryColor,fontSize: 17,),),
                            footer: Text(
                                "Left To Pay = N ${model.formatNumber(model.activeLoansAmountLeft)}.00",
                              style: TextStyle(color: primaryColor,fontSize: 17,),),
                            center: Text(
                              "${(model.activeLoansTotalPaid / model.activeLoanTotal).isNaN ? 0 : (double.parse((model.activeLoansTotalPaid / model.activeLoanTotal).toStringAsFixed(2)) * 100).floor()}%",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.indigo),
                            ),
                            backgroundColor: Colors.white,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Colors.lightBlue,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "N ${model.formatNumber(model.activeLoanTotal)}.00",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                              verticalSpace15,
                              Text(
                                "Next Installment",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "N ${model.formatNumber(model.nextInstallment)}.00",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
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
