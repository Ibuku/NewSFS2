import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sfscredit/models/guarantor_request.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/widgets/busy_overlay.dart';
import 'package:sfscredit/ui/widgets/guarantor_request.dart';
import 'package:sfscredit/ui/widgets/menu.dart';
import 'package:sfscredit/ui/widgets/card_item.dart';
import 'package:sfscredit/viewmodels/guarantor_request_view_model.dart';
import '../../../../const.dart';

class AllRequestScreen extends StatefulWidget {
  static const routeName = '/app/Requests/allRequest';
  @override
  _AllRequestScreenState createState() => _AllRequestScreenState();
}

class _AllRequestScreenState extends State<AllRequestScreen> {
  String _currentStatus = 'all';
  List<GuarantorRequest> _allRequests = [];
  List<GuarantorRequest> _currentRequestsList = [];

  bool _isEditingSalary = false;
  TextEditingController _salaryTextController;
  String _salaryValue = "0";

  Map _addSalaryReqData = {};

  bool isEligible(int salary, int packageAmount) {
    return packageAmount < (0.35 * (3 * salary));
  }

  List<Widget> buildRequestOptionList() {
    List<String> statuses = ['all', 'pending', 'approved', 'declined'];
    return statuses.map((status) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _currentStatus = status;
            _currentRequestsList = _allRequests
                .where((guarantorRequest) =>
                    _currentStatus == 'all' ||
                    guarantorRequest.guarantorApproved == _currentStatus)
                .toList();
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          alignment: Alignment.center,
          decoration: _currentStatus == status
              ? BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0),
                )
              : null,
          child: Text(
            "${status[0].toUpperCase()}${status.substring(1)}",
            style: GoogleFonts.mavenPro(
              textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color:
                      _currentStatus == status ? primaryColor : Colors.white),
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  void initState() {
    PaystackPlugin.initialize(publicKey: PAYSTACK_PUBLIC_KEY);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<GuarantorRequestViewModel>.withConsumer(
      viewModel: GuarantorRequestViewModel(),
      onModelReady: (model) {
        Future.wait([model.init(), model.getUsersCards()]).then((val) {
          setState(() {
            _allRequests = model.guarantorRequests;
            _currentRequestsList = _allRequests
                .where((guarantorRequest) =>
                    _currentStatus == 'all' ||
                    guarantorRequest.guarantorApproved == _currentStatus)
                .toList();
          });
        });
      },
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async => await model.onWillPop(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("All Requests"),
            centerTitle: false
          ),
          drawer: MenuDrawer(user: model.user, logout: model.logout),
          backgroundColor: Colors.white,
          body: new GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              if (_isEditingSalary) {
                setState(() {
                  _isEditingSalary = false;
                });
              }
            },
            child: BusyOverlay(
              show: model.loading,
              title: "Loading...",
              child: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 30, horizontal: 15),
                          decoration: BoxDecoration(color: primaryColor),
                          child: Column(
                            children: <Widget>[
                              CardItem(
                                customTitleTextWidget: Text(
                                  "Current Salary",
                                  style: GoogleFonts.mavenPro(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ).copyWith(color: primaryColor),
                                ),
                                customBtnTextWidget: _isEditingSalary
                                    ? TextField(
                                    onChanged: (newValue) {
                                      setState(() {
                                        _salaryValue = newValue;
                                        _addSalaryReqData['guarantor_salary'] =
                                            newValue;
                                      });
                                    },
                                    onSubmitted: (newValue) {
                                      setState(() {
                                        _salaryValue = newValue;
                                        _addSalaryReqData['guarantor_salary'] =
                                            newValue;
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "N ${model.formatNumber(int.parse(_salaryValue))}.00",
                                        style: GoogleFonts.mavenPro(
                                          fontWeight: FontWeight.bold,
                                        ).copyWith(
                                            color: primaryColor, fontSize: 20),
                                      ),
                                      horizontalSpaceTiny,
                                      model.cards.length < 1 ? Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(40),
                                          color: primaryColor
                                        ),
                                        child: IconButton(
                                          icon: Icon(Icons.add),
                                          iconSize: 20,
                                          color: Colors.white,
                                          tooltip: "Add A Card",
                                          onPressed: (){},
                                        )
                                      ) : Container(),
                                    ],
                                  )
                                ),
                                icon: Icons.person,
                                paddingVertical: 30,
                              ),
                              verticalSpace15,
                              Container(
                                height: 50,
                                child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: <Widget>[
                                      Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          mainAxisSize: MainAxisSize.min,
                                          children: buildRequestOptionList())
                                    ])
                              )
                            ],
                          ),
                        ),
                        // History
                        verticalSpace15,
                        Container(
                          margin: EdgeInsets.only(top: 5, left: 30),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "History",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: primaryColor,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                        verticalSpace30,
                        ListView.separated(
                            shrinkWrap: true,
                            itemCount: _currentRequestsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GuarantorRequestWidget(
                                  request: _currentRequestsList[index],
                                  addSalaryReqData: _addSalaryReqData);
                            },
                            separatorBuilder: (context, index) {
                              return verticalSpace15;
                            }),
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
