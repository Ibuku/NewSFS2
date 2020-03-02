import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sfscredit/services/application_service.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/views/app/Apply/apply1.dart';
import 'package:sfscredit/ui/views/app/dashboard.dart';

class Dashboard2Screen extends StatelessWidget {
  static const routeName = '/app/dashboard2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Dashboard"),
    ),
    backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: new Container(
            child: new SingleChildScrollView(
              child: new ConstrainedBox(
                constraints: new BoxConstraints(),
                child: new Column(children: <Widget>[
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
                            margin: EdgeInsets.only(top: 10,),
                            padding: EdgeInsets.only(right: 60,bottom: 50),
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
//                              RaisedButton(
//
//                                onPressed: () {
//                                  Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                      builder: (context) => LoanPage(),
//                                    ),
//                                  );
//                                },
//                              ),
                                Text(
                                  "Active Loans ",
                                  style: TextStyle(
                                    color: Colors.indigo[900],
                                    fontSize: 17,
                                  ),
                                ),

                                Icon(Icons.arrow_forward, color: Colors.indigo[900]),
                                Image(image: AssetImage('assets/images/icon3.png'),alignment: Alignment.topRight,),

                                //color: randomColor(),
                                //  SizedBox(width: 7.0),
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
                    margin: EdgeInsets.only(left: 15, right: 14),
                    padding: EdgeInsets.only(left: 20, right: 40,bottom: 40),
                    height: 110,
                    width: 350,
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
                        Text(
                          "Guaranteed Loans ",
                          style: TextStyle(
                            color: Colors.indigo[900],
                            fontSize: 17,
                          ),
                        ),
//
                        // ),

                        Icon(Icons.arrow_forward, color: Colors.indigo[900],),
                        Image(image: AssetImage('assets/images/icon4.png'),alignment: Alignment.topRight,),

                        //  SizedBox(width: 7.0),
                      ],
                    ),


                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 5,),
                    padding: EdgeInsets.only(right: 210),
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
                          "Wallet Balance ",
                          style: TextStyle(
                            color: Colors.indigo[900],
                            fontSize: 17,
                          ),
                        ),
//
                        // ),

                        //  SizedBox(width: 7.0),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    margin: EdgeInsets.only( left: 10, ),
                    padding: EdgeInsets.only( right: 120),
                    height: 50,
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          height: 380.0,
                        ),

                        Image(image: AssetImage('assets/images/icon1.png'),alignment: Alignment.topRight,),

                        SizedBox(
                          height: 380.0,
                        ),
                        // RaisedButton(
//
//                                shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(20),
//                                ),
                        Text(
                          "N 0.00",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo[900],
                            fontSize: 30,
                          ),
                        ),
//

//                RaisedButton(
//                  color: Colors.white,
//                  elevation: 4,
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(20),
//                  ),
//                  child: Text(
//                    "Active Loans ",
//                    style: TextStyle(
//                      color: Colors.indigo[900],
//                      fontSize: 17,
//                    ),
//                  ),
//                  onPressed: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) => NavMenuPage(),
//                      ),
//                    );
//                  },
//                ),
                        //  SizedBox(width: 7.0),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 5,),
                    padding: EdgeInsets.only(right: 225),
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        //  SizedBox(width: 7.0),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 10, left: 15, right: 14),
                    height: 50,
                    child: Center(
                      child: RaisedButton(
                        // padding: EdgeInsets.only(top: 20, left: 1, right: 1),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        color: Hexcolor('#120A44'),

//
                        //  child: Text('Submit'),

                        onPressed: () {

                        },

//                  onPressed: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) => VerificationPage(email: email),
//                      ),
//                    );
//                  },
                        splashColor: Colors.white,
                        //decoration: BoxDecoration(

                        child: RaisedButton.icon(
                          color: Hexcolor('#120A44'),
                          icon: Icon(Icons.call_made,color: Colors.white,),
                          label: Text('My Wallet',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white,),
                          ),
                          //`Icon` to display
                          //`Text` to display
                          onPressed: () {
                            //Code to execute when Floating Action Button is clicked
                            //...
                          },
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 5,),
                    padding: EdgeInsets.only(right: 225),
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
                          "Active Loans",
                          style: TextStyle(
                            color: Colors.indigo[900],
                            fontSize: 17,
                          ),
                        ),
//
                        // ),

                        //  SizedBox(width: 7.0),
                      ],
                    ),
                  ),


                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    margin: EdgeInsets.only( left: 10,),
                    padding: EdgeInsets.only( right: 25,top:5 ),
                    height: 150,
                    width: 300,
                    child: Row(


                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        SizedBox(
                          height: 5.0,
                        ),
                        new CircularPercentIndicator(
                          radius: 130.0,
                          lineWidth: 15.0,
                          animation: true,
                          percent: 0.7,
                          center: new Text(
                            "70.0%",
                            style:
                            new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0,color: Colors.indigo),
                          ),

                          backgroundColor: Colors.white,
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: Colors.lightBlueAccent,
                        ),


                        //Image(image: AssetImage('assets/images/icon2.png'),alignment: Alignment.topRight,height: 70.0,width: 90.0),
//                 CustomPaint(
//                    foregroundPainter:CircleProgress(),
//                    child: Container(
//                      width: 200,
//                      height: 200,
//                      child: Text("100%"),
//                    ),
//
//                ),

                        SizedBox(
                          height: 5.0,
                        ),


                        // RaisedButton(
//
//                                shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(20),
//                                ),
                        Text(
                          "N 0.00",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo[900],
                            fontSize: 30,
                          ),
                        ),
//
                        //  SizedBox(width: 7.0),
                      ],
                    ),
                  ),
                  SizedBox(height:1.0),
                  Container(
                    margin: EdgeInsets.only(right: 30.0,top: 5),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[


                        RaisedButton(
                          color: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Timeline",
                            style: TextStyle(
                              color: Colors.indigo[900],
                              fontSize: 17,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Dashboard2Screen(),
                              ),
                            );
                          },
                        ),

                        //Icon(Icons.arrow_forward, color: Colors.indigo[900]),
                        //  SizedBox(width: 7.0),
//
                      ],

                    ),
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15, left: 20,),
                    padding: EdgeInsets.only(right: 220),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        // RaisedButton(
//
//                                shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(20),
//                                ),
                        Text(
                          "Overview ",
                          style: TextStyle(
                            color: Colors.indigo[900],
                            fontSize: 17,
                          ),
                        ),
//
                        // ),

                        //  SizedBox(width: 7.0),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only( right: 10,left: 15),
                        padding: EdgeInsets.only(right: 35, ),
                        height: 100,
                        width: 150,
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
                            Image(image: AssetImage('assets/images/circle1.png'),alignment: Alignment.topRight,),
                            //  Icon(Icons.radio_button_unchecked, color: Hexcolor('#120A44'),
                            Text(
                              "Loans ",
                              style: TextStyle(
                                wordSpacing: 5,
                                color: Hexcolor('#120A44'),
                                fontSize: 17,
                                //fontFamily: 'Nunito-Light',
                              ),
                            ),
//
                            // ),


                            //  SizedBox(width: 7.0),
                          ],
                        ),


                      ),
                      Container(
                        //margin: EdgeInsets.only( right: 10),
                        padding: EdgeInsets.only(right: 15, ),
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[

                            Image(image: AssetImage('assets/images/circle2.png'),alignment: Alignment.topCenter,),
                            //Icon(Icons.radio_button_unchecked, color: Colors.white,),

                            Text(
                              "Requests ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
//
                            // ),
                            Text(
                              "20",
                              style: TextStyle(
                                color: Colors.indigo[900],
                                fontSize: 17,
                              ),
                            ),
//
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
              builder: (context) =>ApplyScreen1(),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
