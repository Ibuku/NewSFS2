import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:sfscredit/services/application_service.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/views/app/Apply/apply1.dart';
import 'package:sfscredit/ui/views/app/Apply/apply2.dart';
import 'package:sfscredit/ui/views/app/Dashboard/dashboard2.dart';
//import 'package:sfscredit/ui/views/app/Apply/apply2.dart';
import 'package:sfscredit/ui/views/app/Dashboard/dashboard2.dart';
import 'package:sfscredit/ui/views/app/Loans/loan.dart';
import 'package:sfscredit/ui/views/app/Requests/allRequest.dart';
import 'package:sfscredit/viewmodels/loan_application_view_model.dart';
class NotificationScreen extends StatelessWidget {

  static const routeName = '/app/profile/Notifications';

  get value => null;
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<LoanApplicationViewModel>.withConsumer(
      viewModel: LoanApplicationViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Notifications"),
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

          drawer: new Drawer(
            child: Container(
              color: Hexcolor('#120A44'),
              child: ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(

                    accountName: new Text(
                      "Allen Joe",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17
                      ),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://d1nhio0ox7pgb.cloudfront.net/_img/g_collection_png/standard/512x512/person.png",),
                    ),
                    decoration: new BoxDecoration(
                      color: Hexcolor('#120A44'),
                    ),
                    accountEmail: new Text("babatundeibukun@gmail.com"),
                  ),
                  ListTile(

                    leading: Icon(Icons.dashboard, color: Colors.white,),
                    title: Text("Dashboard",
                      style: TextStyle(
                        color: Colors.white,
                      ),),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.menu, color: Colors.white,),

                    title: Text("Apply",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ApplyScreen1(),
                        ),
                      );
                    },

                  ),
                  ListTile(
                    leading: Icon(
                      Icons.content_paste, color: Colors.white,),
                    title: Text("My Loans",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyLoanScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.save_alt, color: Colors.white,),
                    title: Text("Requests",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllRequestScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.notifications_active, color: Colors.white,),
                    title: Text("Notifications",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.white,),
                    title: Text("Settings",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: IconButton(
                      icon: Icon(FeatherIcons.logOut),
                      onPressed: () async {
                        await model.logout();
                      },
                    ),

                  ),
                ],
              ),
            ),
          ),

          body: Container(
            child: SingleChildScrollView(
              child: new Container(
                child: new SingleChildScrollView(
                  child: new ConstrainedBox(
                    constraints: new BoxConstraints(),
                    child: new Column(children: <Widget>[
                      verticalSpace15,
                      Container(
                        height: 70,
                        width: 340,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: primaryColor,
                        ),
                        child: Column(
                          children: <Widget>[

                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(Icons.notifications_none,  size:20,color: Colors.white,),
                                new Text('Notifications',
                                  style: GoogleFonts.mavenPro(
                                    textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            new Text('Maxi Loan application approved',
                              style: GoogleFonts.mavenPro(
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: primaryColor,
                                ),
                              ),

                            ),
                          ],
                        ),
                      ),
                     verticalSpace15,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 30, right: 15,left: 14),
                            padding: EdgeInsets.only(left: 20, ),
                            height: 30,
                            width: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                // Image(image: AssetImage('assets/images/circle1.png'),alignment: Alignment.topRight,),
                                //  Icon(Icons.radio_button_unchecked, color: Hexcolor('#120A44'),
                                Text(
                                  "Today ",
                                  style: GoogleFonts.mavenPro(
                                    textStyle: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                //
                                // ),


                                //  SizedBox(width: 7.0),
                              ],
                            ),


                          ),
                          Container(
                            margin: EdgeInsets.only( top: 30,right: 10),
                            padding: EdgeInsets.only(left: 5, ),
                            height: 30,
                            width: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                    "18th March, 2020 ",
                                    style: GoogleFonts.mavenPro(
                                      textStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),


                                // Image(image: AssetImage('assets/images/circle2.png'),alignment: Alignment.topCenter,),
                                //Icon(Icons.radio_button_unchecked, color: Colors.white,),


                                //  SizedBox(width: 7.0),
                              ],
                            ),


                          ),

                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 14),
                        padding: EdgeInsets.only(left: 20, right: 40,bottom: 20),
                        height: 70,
                        width: 340,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(
                                  75,
                                  97,
                                  119,
                                  .1,
                                ),
                                blurRadius: 20,
                                offset: Offset(0, 10),)
                            ]),
                        child: Column(
                          children: <Widget>[

                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(Icons.radio_button_checked,  size:20,color: primaryColor,),
                                new Text('Loan Approved',
                                  style: GoogleFonts.mavenPro(
                                    textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            new Text('Maxi Loan application approved',
                              style: GoogleFonts.mavenPro(
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: primaryColor,
                                ),
                              ),

                            ),
                          ],
                        ),
                      ),

                      verticalSpace15,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 30, right: 15,left: 14),
                            padding: EdgeInsets.only(left: 20, ),
                            height: 30,
                            width: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                // Image(image: AssetImage('assets/images/circle1.png'),alignment: Alignment.topRight,),
                                //  Icon(Icons.radio_button_unchecked, color: Hexcolor('#120A44'),
                                Text(
                                  "Yesterday",
                                  style: GoogleFonts.mavenPro(
                                    textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                //
                                // ),


                                //  SizedBox(width: 7.0),
                              ],
                            ),


                          ),
                          Container(
                            margin: EdgeInsets.only( top: 30,right: 10),
                            padding: EdgeInsets.only(left: 5, ),
                            height: 30,
                            width: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  "17th March, 2020 ",
                                  style: GoogleFonts.mavenPro(
                                    textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),


                                // Image(image: AssetImage('assets/images/circle2.png'),alignment: Alignment.topCenter,),
                                //Icon(Icons.radio_button_unchecked, color: Colors.white,),


                                //  SizedBox(width: 7.0),
                              ],
                            ),


                          ),

                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 14),
                        padding: EdgeInsets.only(left: 20, right: 40,bottom: 20),
                        height: 70,
                        width: 340,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(
                                  75,
                                  97,
                                  119,
                                  .1,
                                ),
                                blurRadius: 20,
                                offset: Offset(0, 10),)
                            ]),
                        child: Column(
                          children: <Widget>[

                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(Icons.radio_button_checked,  size:20,color: primaryColor,),
                                new Text('Guarantor Approval',
                                  style: GoogleFonts.mavenPro(
                                    textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            new Text('Felix accepted your request',
                              style: GoogleFonts.mavenPro(
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: primaryColor,
                                ),
                              ),

                            ),
                          ],
                        ),
                      ),

                      verticalSpace15,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 30, right: 15,left: 14),
                            padding: EdgeInsets.only(left: 20, ),
                            height: 30,
                            width: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                // Image(image: AssetImage('assets/images/circle1.png'),alignment: Alignment.topRight,),
                                //  Icon(Icons.radio_button_unchecked, color: Hexcolor('#120A44'),
                                Text(
                                  "Last week ",
                                  style: GoogleFonts.mavenPro(
                                    textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                //
                                // ),


                                //  SizedBox(width: 7.0),
                              ],
                            ),


                          ),
                          Container(
                            margin: EdgeInsets.only( top: 30,right: 10),
                            padding: EdgeInsets.only(left: 5, ),
                            height: 30,
                            width: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  "5th March, 2020 ",
                                  style: GoogleFonts.mavenPro(
                                    textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),


                                // Image(image: AssetImage('assets/images/circle2.png'),alignment: Alignment.topCenter,),
                                //Icon(Icons.radio_button_unchecked, color: Colors.white,),


                                //  SizedBox(width: 7.0),
                              ],
                            ),


                          ),

                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 14),
                        padding: EdgeInsets.only(left: 20, right: 40,bottom: 20),
                        height: 70,
                        width: 340,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(
                                  75,
                                  97,
                                  119,
                                  .1,
                                ),
                                blurRadius: 20,
                                offset: Offset(0, 10),)
                            ]),
                        child: Column(
                          children: <Widget>[

                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(Icons.radio_button_checked,  size:20,color: primaryColor,),
                                new Text('Loan Approved',
                                  style: GoogleFonts.mavenPro(
                                    textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            new Text('Maxi Loan application approved',
                              style: GoogleFonts.mavenPro(
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: primaryColor,
                                ),
                              ),

                            ),
                          ],
                        ),
                      ),
                      verticalSpace15,
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 14),
                        padding: EdgeInsets.only(left: 20, right: 40,bottom: 20),
                        height: 70,
                        width: 340,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(
                                  75,
                                  97,
                                  119,
                                  .1,
                                ),
                                blurRadius: 20,
                                offset: Offset(0, 10),)
                            ]),
                        child: Column(
                          children: <Widget>[

                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(Icons.radio_button_checked,  size:20,color: primaryColor,),
                                new Text('Loan Approved',
                                  style: GoogleFonts.mavenPro(
                                    textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            new Text('Maxi Loan application approved',
                              style: GoogleFonts.mavenPro(
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: primaryColor,
                                ),
                              ),

                            ),
                          ],
                        ),
                      ),


                    ],
                    ),
                  ),
                ),
              ),

            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: primaryColor,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ApplyScreen2(),
                ),
              );
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
          SizedBox(height: 50,),
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
