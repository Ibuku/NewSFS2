import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sfscredit/services/application_service.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/views/app/Apply/apply1.dart';
import 'package:sfscredit/ui/views/app/Requests/request.dart';
//import 'package:sfscredit/ui/views/app/Apply/apply2.dart';
import 'package:sfscredit/ui/views/app/Dashboard/dashboard2.dart';

class ApplyScreen2 extends StatelessWidget {
  static const routeName = '/app/Apply/apply2.dart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text("Apply"),
//      ),
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
                      color: Hexcolor('#120A44'),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 30,
                          height: 70,
                          width: 30,
                          right: 30,
                          child: Container(
                            //margin: EdgeInsets.only(top: 20),
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
                          height: 250,
                          right: 25,
                          child: Container(
                            margin: EdgeInsets.only(top: 50,),
                            padding: EdgeInsets.only(right: 50,),
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

                                new Text('Salary',
                                  style: TextStyle(fontSize: 15,color: Colors.indigo[900] ),

                                ),

                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    new Text('N 0.00',
                                      style: TextStyle(fontSize: 25,color: Colors.indigo[900],fontWeight: FontWeight.bold,),

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
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 14),
                    padding: EdgeInsets.only(left: 20, right: 40,bottom: 20),
                    height: 50,
                    width: 345,
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
                            offset: Offset(0, 10),)
                        ]),
                    child: Column(
                      children: <Widget>[

                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //Image(image: AssetImage('assets/images/circle2.png',),color: Colors.grey,alignment: Alignment.topLeft,),
                            new Text('Loan Type',
                              style: TextStyle(fontSize: 15,color: Colors.indigo[900],fontWeight: FontWeight.normal,),

                            ),

                            new Text('Package 1',
                              style: TextStyle(fontSize: 15,color: Colors.indigo[900],fontWeight: FontWeight.normal,),

                            ),

                            // new Text('N25,000.00 monthly repayment'),
//                                    new Text('  Row'),
                          ],
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
                    margin: EdgeInsets.only(top: 5,),
                    padding: EdgeInsets.only(right: 200),
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
                          "Personal Information",
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20, right: 10,left: 20),
                        //padding: EdgeInsets.only(left: 20, ),
                        height: 50,
                        width: 180,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            // Image(image: AssetImage('assets/images/circle1.png'),alignment: Alignment.topRight,),
                            //  Icon(Icons.radio_button_unchecked, color: Hexcolor('#120A44'),
                            Text(
                              "Account Number ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                wordSpacing: 5,
                                color: Hexcolor('#120A44'),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
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
                        margin: EdgeInsets.only( top: 20,right: 5),
                        padding: EdgeInsets.only(left: 5, ),
                        height: 50,
                        width: 120,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[

                            // Image(image: AssetImage('assets/images/circle2.png'),alignment: Alignment.topCenter,),
                            //Icon(Icons.radio_button_unchecked, color: Colors.white,),

                            Text(
                              "Bank Name",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
//
                            // ),

                            //  SizedBox(width: 7.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 14),
                    padding: EdgeInsets.only(left: 20, right: 25,bottom: 20),
                    height: 50,
                    width: 345,
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
                            offset: Offset(0, 10),)
                        ]),
                    child: Column(
                      children: <Widget>[

                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //Image(image: AssetImage('assets/images/circle2.png',),color: Colors.grey,alignment: Alignment.topLeft,),
                            new Text('First Name',
                              style: TextStyle(fontSize: 15,color: Hexcolor('#120A44'),fontWeight: FontWeight.normal,),

                            ),

                          ],
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
                    height: 50,
                    width: 345,
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
                            offset: Offset(0, 10),)
                        ]),
                    child: Column(
                      children: <Widget>[

                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //Image(image: AssetImage('assets/images/circle2.png',),color: Colors.grey,alignment: Alignment.topLeft,),
                            new Text('Guarantor Email',
                              style: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.normal,),

                            ),

                          ],
                        ),


//
//                                new Text('Row'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5,left: 10),
                    padding: EdgeInsets.only(right: 275),
                    height: 50,
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
                          "Add Card",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
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
                    margin: EdgeInsets.only(left: 15, right: 14,bottom: 20),
                    padding: EdgeInsets.only(left: 20, right: 40,),
                    height: 50,
                    width: 345,
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
                            offset: Offset(0, 10),)
                        ]),
                    child: Column(
                      children: <Widget>[

                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //Image(image: AssetImage('assets/images/circle2.png',),color: Colors.grey,alignment: Alignment.topLeft,),
                            new Text('Card',
                              style: TextStyle(fontSize: 15,color: Hexcolor('#120A44'),fontWeight: FontWeight.normal,),

                            ),

                          ],
                        ),
//
//                           new Text('Row'),
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
                              style: TextStyle(
                                wordSpacing: 5,
                                color: Hexcolor('#120A44'),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
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
                        margin: EdgeInsets.only( top: 30,right: 30),
                        padding: EdgeInsets.only(left: 10, ),
                        height: 30,
                        width: 150,
                        child: Center(
                          child: RaisedButton(
                            // padding: EdgeInsets.only(top: 20, left: 1, right: 1),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: Colors.white,

                            //decoration: BoxDecoration(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Finish",
                                  style: TextStyle(color: Hexcolor('#120A44'),
                                      fontSize: 15,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),

//                            onPressed: () {
////                    dialog.reset(context,'Reset Password','Kindly Proceed to your Mail inbox/n'
////                        'to reset your password');
//                              return Alert(
//                                context: context,
//                                style: alertStyle,
//                                // type: AlertType.info,
//                                image: Image.asset(
//                                  'assets/images/pop2.png',
//                                ),
//                                title: "Congratulations",
//                                content: Container(
//                                  margin: EdgeInsets.only(top: 5.0),
//                                  height: 40.0,
//                                  child: Column(
//                                    children: <Widget>[
//                                      Text(
//                                        "Loan Application Submitted",
//                                        style: TextStyle(
//                                          color: Hexcolor('#120A44'),
//                                          fontSize: 14.0,
//                                        ),
//                                        textAlign: TextAlign.center,
//                                      ),
//                                    ],
//                                  ),
//                                ),
////
//                                buttons: [
//                                  DialogButton(
//                                    child: Text(
//                                      "Back",
//                                      style: TextStyle(color: Colors.white, fontSize: 20),
//                                    ),
//                                    onPressed: () => Navigator.pop(context),
//                                    color: Hexcolor('#120A44'),
//                                    radius: BorderRadius.circular(15.0),
//                                  ),
//                                ],
//                              ).show();
//
//                            },
                          ),
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
              builder: (context) => Request1Screen(),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

}
