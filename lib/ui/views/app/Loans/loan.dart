import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:hexcolor/hexcolor.dart';
import 'package:provider_architecture/provider_architecture.dart';

import 'package:sfscredit/models/loan_request.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/widgets/busy_overlay.dart';
import 'package:sfscredit/ui/widgets/card_item.dart';
import 'package:sfscredit/ui/widgets/custom_list_item.dart';
import 'package:sfscredit/ui/widgets/menu.dart';
import 'package:sfscredit/viewmodels/application_view_model.dart';
import 'package:flutter/widgets.dart';

class MyLoanScreen extends StatelessWidget {
  static const routeName = '/app/Loans/loan';
  get value => null;

  int getCurrentSalary(List<LoanRequest> requests) {
    int salary = 0;
    if(requests.isNotEmpty){
      LoanRequest latestRequest = new List.from(requests.reversed)[0];
      salary = latestRequest.currentSalary;
    }
    return salary;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ApplicationViewModel>.withConsumer(
      viewModel: ApplicationViewModel(),
      onModelReady: (model) => model.getUserLoanRequests(),
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async => await model.onWillPop(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("My Loans"),
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
          body: BusyOverlay(
            show: model.loading,
            title: "Loading...",
            child: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: new BoxConstraints(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/background.png'),
                              fit: BoxFit.fill),
                        ),
                        child: CardItem(
                          customTitleTextWidget: Text(
                            "Current Salary",
                            style: GoogleFonts.mavenPro(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ).copyWith(color: primaryColor),
                          ),
                          customBtnTextWidget: Text(
                            "N ${new NumberFormat('###,###').format(getCurrentSalary(model.loanRequests))}.00",
                            style: GoogleFonts.mavenPro(
                              fontWeight: FontWeight.bold,
                            ).copyWith(color: primaryColor, fontSize: 20),
                          ),
                          icon: Icons.person,
                          paddingVertical: 30,
                        ),
                      ),
                      verticalSpace15,
                      Container(
                        margin: EdgeInsets.only(top: 5, left: 30),
                        height: 20,
                        child: Text(
                          "Loans",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Hexcolor('#120A44'),
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        height: 150,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container(
                              width: 120,
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              padding: EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  image: DecorationImage(
                                    alignment: Alignment.topLeft,
                                    image: AssetImage('assets/images/up1.png'),
                                  ),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "${model.loanRequests.where((loanRequest) => loanRequest.status == 'approved').length}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17),
                                  ),
                                  Text(
                                    "Active",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17),
                                  ),
                                ],
                              )),
                            ),
                            Container(
                              width: 120,
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              padding: EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                  color: Hexcolor('#70C6FF'),
                                  image: DecorationImage(
                                    alignment: Alignment.topLeft,
                                    image: AssetImage('assets/images/up1.png'),
                                  ),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "${model.loanRequests.where((loanRequest) => loanRequest.status == 'approved').length}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17),
                                  ),
                                  Text(
                                    "Approved",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17),
                                  ),
                                ],
                              )),
                            ),
                            Container(
                              width: 120,
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              padding: EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                color: Hexcolor('#7787FC'),
                                borderRadius: BorderRadius.circular(15.0),
                                image: DecorationImage(
                                  alignment: Alignment.topLeft,
                                  image: AssetImage('assets/images/up2.png'),
                                ),
                              ),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "${model.loanRequests.where((loanRequest) => loanRequest.status == 'declined').length}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17),
                                  ),
                                  Text(
                                    "Declined",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17),
                                  ),
                                ],
                              )),
                            ),
                            Container(
                              width: 120,
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              padding: EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                color: Hexcolor('#E2E2E2'),
                                borderRadius: BorderRadius.circular(15.0),
                                image: DecorationImage(
                                  alignment: Alignment.topLeft,
                                  image: AssetImage('assets/images/up1.png'),
                                ),
                              ),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "${model.loanRequests.where((loanRequest) => loanRequest.status == 'pending').length}",
                                    style: TextStyle(
                                        color: Hexcolor('#120A44'),
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17),
                                  ),
                                  Text(
                                    "Pending",
                                    style: TextStyle(
                                        color: Hexcolor('#120A44'),
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17),
                                  ),
                                ],
                              )),
                            ),
                          ],
                        ),
                      ),
                      verticalSpace15,
                      Container(
                        margin: EdgeInsets.only(top: 5, left: 30),
                        height: 20,
                        child: Text(
                          "History",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Hexcolor('#120A44'),
                            fontSize: 17,
                          ),
                        ),
                      ),
                      verticalSpace15,
                      ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CustomListItem(
                                leadingIcon: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    "https://d1nhio0ox7pgb.cloudfront.net/_img/g_collection_png/standard/512x512/person.png",
                                  ),
                                ),
                                title:
                                    model.loanRequests[index].loanPackage.name,
                                amount: model
                                    .loanRequests[index].loanPackage.amount,
                                date: model.loanRequests[index].createdAt,
                                arrowIconColor: primaryColor);
                          },
                          separatorBuilder: (context, index) {
                            return verticalSpace15;
                          },
                          itemCount: model.loanRequests.length),
                    ],
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
