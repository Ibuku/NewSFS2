import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider_architecture/provider_architecture.dart';
import '../../../../ui/shared/app_colors.dart';
import '../../../../ui/shared/ui_helpers.dart';
import '../../../../ui/widgets/busy_button.dart';
import '../../../../ui/widgets/busy_overlay.dart';
import '../../../../ui/widgets/custom_card.dart';
import '../../../../ui/widgets/text_link.dart';
import '../../../../viewmodels/forgot_password_view_model.dart';

class ActivatePassword extends StatefulWidget {
  static const routeName = '/auth/verify/activate-password';

  @override
  _ActivatePasswordState createState() => _ActivatePasswordState();
}

class _ActivatePasswordState extends State<ActivatePassword> {
  Map _passwordReset = {};
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ForgotPasswordViewModel>.withConsumer(
      viewModel: ForgotPasswordViewModel(),
      onModelReady: (model) {
        model.init(email: ModalRoute.of(context).settings.arguments);
        _passwordReset['email'] = model.userEmail;
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
        body: BusyOverlay(
          show: model.loading,
          title: "Sending request ...",
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 5),
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
                        PinCodeTextField(
                          length: 6,
                          obsecureText: false,
                          animationType: AnimationType.fade,
                          shape: PinCodeFieldShape.box,
                          animationDuration: Duration(milliseconds: 300),
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          onChanged: (value) {
                            if (value.length == 6) {
                              _passwordReset['otp'] = value;
                            }
                          },
                          activeColor: primaryColor,
                          onCompleted: (value) {
                            if (value.length == 6) {
                              _passwordReset['otp'] = value;
                            }
                          },
                          controller: _otpController,
                        ),

                        verticalSpace20,
                        BusyButton(
                          title: "Reset Password",
                          busy: model.busy,
                          onPressed: () => model.forgotPassword(
                            authData: _passwordReset,
                            otpText: _otpController.text,
                          ),
                        ),
                        verticalSpace(20),
                        TextLink(
                          "Resend OTP",
                          onPressed: () => model.resendOTP2(),
                          color: Colors.red,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
