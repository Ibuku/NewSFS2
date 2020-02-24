import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/widgets/busy_button.dart';
import 'package:sfscredit/ui/widgets/custom_text_field.dart';
import 'package:sfscredit/ui/widgets/full_screen_picker.dart';
import 'package:sfscredit/viewmodels/signup_view_model.dart';

class SelectCompany extends StatelessWidget {
  static const routeName = '/auth/signup/select-company';
  final _companyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SignUpViewModel>.withConsumer(
      viewModel: SignUpViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("Select Company"),
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
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/new_images/select_company.png'),
                verticalSpaceSmall,
                Text(
                  "Select Company",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mavenPro(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                verticalSpaceTiny,
                Text(
                  "Choose a Company",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
                verticalSpace20,
                Card(
                  elevation: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                    child: Column(
                      children: <Widget>[
                        verticalSpaceMedium,
                        CustomTextField(
                          hintText: model.loading
                              ? "Loading Companies ..."
                              : model.selectedCompany != null
                                  ? model.selectedCompany.display
                                  : "Select a company",
                          textController: _companyController,
                          validator: (value) {
                            if (value == null || value == "") {
                              return "Please select a company";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            print(value);
                            model.setSelectedCompany(value);
                          },
                          readOnly: true,
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullScreenPicker(
                                  title: "Select a company",
                                  dataSource:
                                      model.loading ? [] : model.companies,
                                ),
                                fullscreenDialog: false,
                              ),
                            ).then((value) {
                              if (value != null) {
                                // _companyController.text = value.name;
                                model.setSelectedCompany(value);
                              }
                            });
                          },
                        ),
                        verticalSpace30,
                        BusyButton(
                          title: "Continue",
                          onPressed: () {},
                          busy: false,
                        ),
                        verticalSpaceSmall
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
