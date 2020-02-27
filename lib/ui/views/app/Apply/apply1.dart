import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sfscredit/services/application_service.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/views/app/Apply/apply1.dart';
//import 'package:sfscredit/ui/views/app/Apply/apply2.dart';
import 'package:sfscredit/ui/views/app/dashboard2.dart';

class ApplyScreen1 extends StatelessWidget {
  static const routeName = '/app/Apply/apply.dart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apply"),
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
                              style: TextStyle(fontSize: 15,color: Colors.indigo[900],fontWeight: FontWeight.normal,),

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

                        new Text('N 400,000.00',
                          style: TextStyle(fontSize: 20,color: Colors.indigo[900],fontWeight: FontWeight.bold ),

                        ),
                        new Text('N 25,000.00 monthly repayment',
                          style: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.normal ),

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
                              style: TextStyle(fontSize: 15,color: Colors.indigo[900],fontWeight: FontWeight.normal,),

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
                          style: TextStyle(fontSize: 20,color: Colors.indigo[900],fontWeight: FontWeight.bold ),

                        ),
                        new Text('N 25,000.00 monthly repayment',
                          style: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.normal ),

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
              builder: (context) => Dashboard2Screen(),
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
