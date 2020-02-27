import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sfscredit/services/application_service.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/views/app/Apply/apply1.dart';
import 'package:sfscredit/ui/views/app/dashboard2.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = '/app/dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      backgroundColor: Colors.white,



//      body: SingleChildScrollView(
//        padding: EdgeInsets.symmetric(),
//        child: Text(ApplicationService.user.toJson().toString()),
//      ),
//    );
//  }
//}
      body: Container(
        child: Wrap(
          children: <Widget>[
            Container(
              //padding: EdgeInsets.only(top: 20),
              height: 200,
              // width:400 ,
              decoration: BoxDecoration(
                //color: randomColor(),
                image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fill),
              ),

              child: Stack(
                children: <Widget>[
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
                    top: 80,
                    left: 20,
                    height: 130,
                    right: 14,
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.only(right: 130),
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
                        children: <Widget>[
                          SizedBox(
                            height: 200.0,
                          ),
                          RaisedButton(
                            color: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "Update KYC ",
                              style: TextStyle(
                                color: Colors.indigo[900],
                                fontSize: 17,
                              ),
                            ),

                          ),

                          Icon(Icons.arrow_forward, color: Colors.indigo[900]),
                          //  SizedBox(width: 7.0),
//
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 150.0,
            ),
            Container(
              margin: EdgeInsets.only(top: 15, left: 10, right: 14),
              padding: EdgeInsets.only(left: 15, right: 125),
              height: 110,
              width: 380,
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
                children: <Widget>[
                  SizedBox(
                    height: 380.0,
                  ),
                  RaisedButton(
                    color: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Your First Loan ",
                      style: TextStyle(
                        color: Colors.indigo[900],
                        fontSize: 17,
                      ),
                    ),

                  ),

                  Icon(Icons.arrow_forward, color: Colors.indigo[900]),
                  //  SizedBox(width: 7.0),
//
                ],

              ),
            ),
          ],
        ),
      ), floatingActionButton: FloatingActionButton(
      backgroundColor: Hexcolor('#120A44'),
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard2Screen(),
          ),
        );
      },
    ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
