import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sfscredit/services/application_service.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/views/app/Apply/apply1.dart';
import 'package:sfscredit/ui/views/app/Apply/apply2.dart';
import 'package:sfscredit/ui/views/app/Dashboard/dashboard.dart';
//import 'package:sfscredit/ui/views/app/Apply/apply2.dart';
import 'package:sfscredit/ui/views/app/Dashboard/dashboard2.dart';
import 'package:sfscredit/ui/views/app/Loans/loan.dart';
import 'package:sfscredit/ui/views/app/Requests/allRequest.dart';

class ApplyScreen1 extends StatelessWidget {
  static const routeName = '/app/Apply/apply.dart';

  get model => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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



      drawer: new Drawer(
        child: Container(
          color: Hexcolor('#120A44'),
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(

                accountName: new Text(
                  "Allen Joe",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
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


//      body: SingleChildScrollView(
//        padding: EdgeInsets.symmetric(),
//        child: Text(ApplicationService.user.toJson().toString()),
//      ),
//    );
//  }
//}
      body: Container(
        child: SingleChildScrollView(
          child: new Container(
            child: new SingleChildScrollView(
              child: new ConstrainedBox(
                constraints: new BoxConstraints(),
                child: new Column(children: <Widget>[
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Hexcolor('#120A44'),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          height: 50,
                          width: 20,
                          right: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Hexcolor('#120A44'),
                              backgroundBlendMode: BlendMode.color,
                              image: DecorationImage(
                                image: AssetImage('assets/images/avatar.png'),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          height: 50,
                          width: 30,
                          right: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Hexcolor('#120A44'),
                              backgroundBlendMode: BlendMode.color,
                              image: DecorationImage(
                                image: AssetImage('assets/images/avatar.png'),
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          top: 70,
                          left: 30,
                          height: 130,
                          right: 25,
                          child: Container(
                            margin: EdgeInsets.only(top: 10,),
                            padding: EdgeInsets.only(right: 50,bottom: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
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
                                    offset: Offset(0, 10),
                                  )
                                ]),

                            child: Column(

                              textDirection: TextDirection.ltr,
                              children: <Widget>[

                                new Text('Current Salary',
                                  style: GoogleFonts.mavenPro(
                                    textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),

                                ),

                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    new Text('N 0.00',
                                      style: GoogleFonts.mavenPro(
                                        textStyle: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),

                                    ),
//                                    new Text('  is  '),
//                                    new Text('  Row'),
                                  ],
                                ),
//                                new Text('Row'),
                              ],
                            ),

                          ),


                        ),


                      ],
                    ),
                  ),

                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5,),
                    padding: EdgeInsets.only(right: 240),
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          height: 380.0,
                        ),
                        // RaisedButton(
//
//                                shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(20),
//                                ),
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
//
                        // ),

                        //  SizedBox(width: 7.0),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 14),
                    padding: EdgeInsets.only(left: 20, right: 40,bottom: 20),
                    height: 125,
                    width: 345,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Image(image: AssetImage('assets/images/circle2.png',),color: Colors.grey,alignment: Alignment.topLeft,),
                            new Text('Package 1',
                              style: GoogleFonts.mavenPro(
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: primaryColor,
                                ),
                              ),
                            ),

                            RaisedButton(
                              color: Hexcolor('#120A44'),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "See terms ",
                                style: GoogleFonts.mavenPro(
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Dashboard(),
                                  ),
                                );
                              },
                            ),

                            // new Text('N25,000.00 monthly repayment'),
//                                    new Text('  Row'),
                          ],
                        ),
                        //  Image(image: AssetImage('assets/images/icon4.png'),alignment: Alignment.topRight,)

                        new Text('N 400,000.00',
                          style: GoogleFonts.mavenPro(
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: primaryColor,
                            ),
                          ),

                        ),
                        new Text('N 25,000.00 monthly repayment',
                          style: GoogleFonts.mavenPro(
                            textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: primaryColor,
                            ),
                          ),

                        ),


//
//                                new Text('Row'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 14),
                    padding: EdgeInsets.only(left: 20, right: 40,bottom: 20),
                    height: 125,
                    width: 345,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //Image(image: AssetImage('assets/images/circle2.png',),color: Colors.grey,alignment: Alignment.topLeft,),
                            new Text('Package 2',
                              style: GoogleFonts.mavenPro(
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: primaryColor,
                                ),
                              ),

                            ),

                            RaisedButton(
                              color: Hexcolor('#120A44'),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "See terms ",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Dashboard(),
                                  ),
                                );
                              },
                            ),

                            // new Text('N25,000.00 monthly repayment'),
//                                    new Text('  Row'),
                          ],
                        ),
                        //  Image(image: AssetImage('assets/images/icon4.png'),alignment: Alignment.topRight,)

                        new Text('N 800,000.00',
                          style: GoogleFonts.mavenPro(
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),

                        ),
                        new Text('N 25,000.00 monthly repayment',
                          style: GoogleFonts.mavenPro(
                            textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: primaryColor,
                            ),
                          ),

                        ),


//
//                                new Text('Row'),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 30, right: 25,left: 5),
                        padding: EdgeInsets.only(left: 20, ),
                        height: 30,
                        width: 100,
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
                                offset: Offset(0, 10),
                              )
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            // Image(image: AssetImage('assets/images/circle1.png'),alignment: Alignment.topRight,),
                            //  Icon(Icons.radio_button_unchecked, color: Hexcolor('#120A44'),
                            Text(
                              "Cancel ",
                              style: GoogleFonts.mavenPro(
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
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
                        margin: EdgeInsets.only( top: 30,right: 30),
                        padding: EdgeInsets.only(left: 5, ),
                        height: 30,
                        width: 100,
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
                                offset: Offset(0, 10),
                              )
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[

                            // Image(image: AssetImage('assets/images/circle2.png'),alignment: Alignment.topCenter,),
                            //Icon(Icons.radio_button_unchecked, color: Colors.white,),

                            Text(
                              "Continue",
                              style: TextStyle(
                                color: Hexcolor('#120A44'),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
//
                            // ),

                            //  SizedBox(width: 7.0),
                          ],
                        ),


                      ),

                    ],
                  )


                ],
                ),
              ),
            ),
          ),

        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Hexcolor('#120A44'),
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
