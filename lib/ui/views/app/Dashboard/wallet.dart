import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sfscredit/models/wallet_transaction.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/widgets/custom_list_item.dart';
import 'package:sfscredit/ui/widgets/menu.dart';
import 'package:sfscredit/ui/widgets/wallet_transaction_modal.dart';
import 'package:sfscredit/viewmodels/application_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:sfscredit/viewmodels/payment_view_model.dart';

class WalletScreen extends StatefulWidget {
  static const routeName = '/app/Dashboard/wallet';
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  get value => null;
  List<WalletTransaction> _transactions = [];

  Future<void> showTransactionModal(BuildContext pageContext) async {
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        backgroundColor: Colors.white,
        context: pageContext,
        builder: (builder) {
          return WalletTransactionModalWidget(parentContext: pageContext);
        });
  }


  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<PaymentViewModel>.withConsumer(
      viewModel: PaymentViewModel(),
      onModelReady: (model) {
        model.initWallet().then((val) {
          setState(() {
            _transactions = List.from(model.walletTransactions);
          });
        });
      },
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async => await model.onWillPop(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Total Wallet Balance"),
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
          body: Container(
            constraints: BoxConstraints.expand(),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.3, 1],
                    colors: [primaryColor, blueColor])),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/images/wallet.png'),
                            alignment: Alignment.topRight,
                          ),
                          horizontalSpaceSmall,
                          Text(
                            "N ${model.walletBalance}.00",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            print("Withdraw");
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 20, left: 15),
                            padding: EdgeInsets.only(bottom: 20, top: 10),
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white70,
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SvgPicture.asset("assets/svgs/withdraw.svg",
                                    alignment: Alignment.topCenter, width: 40),
                                verticalSpace15,
                                Text(
                                  "Withdraw",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print("Fund");
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 15),
                            padding: EdgeInsets.only(bottom: 20, top: 10),
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white70,
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SvgPicture.asset("assets/svgs/fund.svg",
                                    alignment: Alignment.topCenter, width: 40),
                                verticalSpace15,
                                Text(
                                  "Fund",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    verticalSpace15,
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 15),
                      height: 40,
                      child: Text(
                        "Transactions",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    _transactions.length > 0
                        ? ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              String type = _transactions[index].type;
                              String svgName =
                                  type == "credit" ? 'fund' : 'withdraw';
                              return CustomListItem(
                                leadingIcon: SvgPicture.asset(
                                    "assets/svgs/$svgName.svg",
                                    alignment: Alignment.topCenter,
                                    width: 40),
                                title:
                                    "${type[0].toUpperCase()}${type.substring(1)}",
                                amount: _transactions[index].amount,
                                color: Colors.white,
                                date: _transactions[index].createdAt,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                height: 16,
                              );
                            },
                            itemCount: _transactions.length)
                        : Container()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
