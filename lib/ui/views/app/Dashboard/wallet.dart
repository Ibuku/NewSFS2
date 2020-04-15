import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sfscredit/models/bank_details.dart';
import 'package:sfscredit/models/wallet_transaction.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/widgets/add_bank_details_modal.dart';
import 'package:sfscredit/ui/widgets/busy_overlay.dart';
import 'package:sfscredit/ui/widgets/custom_list_item.dart';
import 'package:sfscredit/ui/widgets/full_screen_picker.dart';
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

  Future selectBank(ApplicationViewModel model) {
    return Navigator.push(
      model.context,
      MaterialPageRoute(
        builder: (context) => FullScreenPicker(
          title: "Select a bank",
          dataSource:
          model.loading ? [] : model.banks,
        ),
        fullscreenDialog: false,
      ),
    );
  }

  Future<void> showTransactionModal(
      BuildContext pageContext, String type, {BankDetails bankDetails}) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        backgroundColor: Colors.white,
        context: pageContext,
        builder: (builder) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: WalletTransactionModalWidget(
                  parentContext: pageContext, transactionType: type, bankDetails: bankDetails),
            ),
          );
        });
  }

  Future<void> showBankDetailsModal(
      BuildContext pageContext, ApplicationViewModel model,
      {Function callback}) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        backgroundColor: Colors.white,
        context: pageContext,
        builder: (builder) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: BankDetailsModalWidget(
                  parentContext: pageContext, callback: callback, selectBank: selectBank),
            ),
          );
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
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("Total Wallet Balance"),
          centerTitle: false,
        ),
        drawer: MenuDrawer(user: model.user, logout: model.logout),
        body: BusyOverlay(
          show: model.loading || model.busy,
          title: "Loading",
          overlayBackground: Colors.white,
          child: Container(
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
                          onTap: () async {
                            await model.getUsersBankDetails();
                            if (model.bankDetails == null) {
                              await showBankDetailsModal(context, model,
                                  callback: () => showTransactionModal(
                                      context, 'withdraw'));
                            } else {
                              await showTransactionModal(context, 'withdraw', bankDetails: model.bankDetails);
                            }
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
                          onTap: () async {
                            await showTransactionModal(context, 'fund');
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
