import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/widgets/busy_button.dart';
import 'package:sfscredit/ui/widgets/custom_card.dart';
import 'package:sfscredit/viewmodels/account_activate_view_model.dart';

class ActivateAccount extends StatefulWidget {
  static const routeName = '/auth/verify/activate-account';

  @override
  _ActivateAccountState createState() => _ActivateAccountState();
}

class _ActivateAccountState extends State<ActivateAccount> {
  Map _verifyData = {};
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<AccountActivateViewModel>.withConsumer(
      viewModel: AccountActivateViewModel(),
      onModelReady: (model) {
        model.init(email: ModalRoute.of(context).settings.arguments);
        _verifyData['email'] = model.userEmail;
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          textTheme: TextTheme(
            title: Theme.of(context)
                .textTheme
                .title
                .copyWith(fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          brightness: Brightness.light,
        ),
        body: SingleChildScrollView(
          // padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/verify.png',
                  height: 60,
                  fit: BoxFit.cover,
                ),
                verticalSpaceSmall,
                Text(
                  "Verification",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mavenPro(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                verticalSpaceSmall,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Text(
                    "Check your email for an OTP. Enter the code here to continue",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                verticalSpace(30),
                CustomCard(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 40),
                  child: Column(
                    children: <Widget>[
                      PinEntryTextField(
                        fields: 6,
                        showFieldAsBox: true,
                        onSubmit: (String pin) {
                          _verifyData['otp'] = pin;
                        },
                      ),
                      verticalSpace20,
                      BusyButton(
                        title: "Verify",
                        busy: model.busy,
                        onPressed: () => model.verifyAccount(authData: _verifyData),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
