import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/widgets/card_item.dart';
import 'package:sfscredit/viewmodels/application_view_model.dart';

import 'profile/update_kyc.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = '/app/dashboard';

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ApplicationViewModel>.withConsumer(
      viewModel: ApplicationViewModel(),
      onModelReady: (model) {},
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
                  bool doLogout = await model.logout();
                },
              ),
            ],
          ),
          // backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: model.user.profile == null
                ? profileNotSet(model)
                : profileSetup(),
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
          titleText: "Apply for your first loan",
          btnText: "Apply",
          icon: Icons.keyboard_tab,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget profileSetup() {
    return Column(
      children: <Widget>[
        Text("Profile Setup"),
      ],
    );
  }
}
