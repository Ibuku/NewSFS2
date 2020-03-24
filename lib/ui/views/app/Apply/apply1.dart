import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:sfscredit/models/loan_package.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/views/app/Apply/apply2.dart';
import 'package:sfscredit/ui/widgets/busy_button.dart';
import 'package:sfscredit/ui/widgets/busy_overlay.dart';
import 'package:sfscredit/ui/widgets/card_item.dart';
import 'package:sfscredit/ui/widgets/loan_package_card.dart';
import 'package:sfscredit/ui/widgets/menu.dart';
import 'package:sfscredit/viewmodels/loan_application_view_model.dart';

import '../../../../locator.dart';
import '../../../../services/dialog_service.dart';

class ApplyScreen1 extends StatefulWidget {
  static const routeName = '/app/Apply/apply1';

  ApplyScreen1({Key key}) : super(key: key);

  @override
  _ApplyScreen1State createState() => _ApplyScreen1State();
}

class _ApplyScreen1State extends State<ApplyScreen1> {
  final DialogService _dialogService = locator<DialogService>();
  bool _isEditingSalary = false;
  TextEditingController _salaryTextController;
  String _salaryValue = "0";

  bool isEligible(int salary, int packageAmount) {
    return packageAmount < (0.35 * (3 * salary));
  }

  LoanPackage _selectedPackage;

  List<LoanPackageWidget> buildPackagesContainer(
      BuildContext context, List<LoanPackage> loanPackages) {
    return loanPackages.map((loanPackage) {
      return LoanPackageWidget(package: loanPackage);
    }).toList();
  }

  void selectLoanPackage(LoanPackage loanPackage) {
    setState(() {
      _selectedPackage = loanPackage;
    });
  }

  @override
  void initState() {
    super.initState();
    _salaryTextController = TextEditingController(text: _salaryValue);
  }

  @override
  void dispose() {
    _salaryTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<LoanApplicationViewModel>.withConsumer(
      viewModel: LoanApplicationViewModel(),
      onModelReady: (model) => model.initPackages(),
      builder: (context, model, child) => WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Apply"),
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
          backgroundColor: Colors.white,
          drawer: MenuDrawer(user: model.user, logout: model.logout),
          body: BusyOverlay(
            show: model.loading,
            title: "Loading...",
            child: Container(
              child: SingleChildScrollView(
                child: new ConstrainedBox(
                  constraints: new BoxConstraints(),
                  child: new Column(children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                      decoration: BoxDecoration(color: primaryColor),
                      child: CardItem(
                        customTitleTextWidget: Text(
                          "Current Salary",
                          style: GoogleFonts.mavenPro(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ).copyWith(color: primaryColor),
                        ),
                        customBtnTextWidget: _isEditingSalary
                            ? TextField(
                                onSubmitted: (newValue) {
                                  setState(() {
                                    _salaryValue = newValue;
                                    _isEditingSalary = false;
                                  });
                                },
                                autofocus: true,
                                controller: _salaryTextController,
                                keyboardType: TextInputType.number)
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    _isEditingSalary = true;
                                  });
                                },
                                child: Text(
                                  "N $_salaryValue",
                                  style: GoogleFonts.mavenPro(
                                    fontWeight: FontWeight.bold,
                                  ).copyWith(color: primaryColor, fontSize: 20),
                                ),
                              ),
                        icon: Icons.person,
                        paddingVertical: 30,
                      ),
                    ),
                    verticalSpace15,
                    Container(
                        margin: EdgeInsets.only(
                          top: 15,
                        ),
                        padding: EdgeInsets.only(right: 20, left: 20),
                        child: Column(children: <Widget>[
                          Text(
                            "Loan Options",
                            style: GoogleFonts.mavenPro(
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Column(
                              children: model.loanPackages
                                  .where((loanPackage) => isEligible(
                                      int.parse(_salaryValue),
                                      loanPackage.amount))
                                  .map((loanPackage) => LoanPackageWidget(
                                      package: loanPackage,
                                      selectedPackage: _selectedPackage,
                                      onPressed: this.selectLoanPackage))
                                  .toList()),
                          verticalSpace30,
                          BusyButton(
                            title: "Continue",
                            onPressed: () {
                              if (_selectedPackage == null ||
                                  _salaryValue == "0") {
                                _dialogService.showDialog(
                                    title: 'Warning!',
                                    description:
                                        "Add Your Salary and Select a Loan Package");
                                return;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ApplyScreen2(
                                        loanPackage: _selectedPackage,
                                        currentSalary: _salaryValue)),
                              );
                            },
                            busy: model.busy,
                          ),
                          verticalSpace30
                        ])),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      // color: Colors.white70,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Container(
            height: 500,
            child: PageView(
              controller: PageController(viewportFraction: 0.0),
              scrollDirection: Axis.horizontal,
              pageSnapping: true,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  color: Colors.indigo[900],
                  width: 180,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  color: Colors.indigo[900],
                  width: 180,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  color: Colors.indigo[900],
                  width: 180,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
