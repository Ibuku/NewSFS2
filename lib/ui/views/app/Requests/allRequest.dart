import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sfscredit/models/guarantor_request.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/widgets/busy_overlay.dart';
import 'package:sfscredit/ui/widgets/guarantor_request.dart';
import 'package:sfscredit/ui/widgets/menu.dart';
import 'package:sfscredit/viewmodels/guarantor_request_view_model.dart';

class AllRequestScreen extends StatefulWidget {
  static const routeName = '/app/Requests/allRequest';
  @override
  _AllRequestScreenState createState() => _AllRequestScreenState();
}

class _AllRequestScreenState extends State<AllRequestScreen> {
  String _currentStatus = 'all';
  List<GuarantorRequest> _allRequests = [];
  List<GuarantorRequest> _currentRequestsList = [];

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
  Widget build(BuildContext context) {
    return ViewModelProvider<GuarantorRequestViewModel>.withConsumer(
      viewModel: GuarantorRequestViewModel(),
      onModelReady: (model) {
        model.init().then((val) {
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
          body: BusyOverlay(
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
                              vertical: 30, horizontal: 30),
                          height: 120,
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
                                  offset: Offset(0, 10),
                                )
                              ]),
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    mainAxisSize: MainAxisSize.min,
                                    children: buildRequestOptionList())
                              ])),

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
                                request: _currentRequestsList[index], pageContext: context);
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
    );
  }
}
