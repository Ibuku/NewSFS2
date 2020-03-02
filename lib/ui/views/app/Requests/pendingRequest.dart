import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sfscredit/services/application_service.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/views/app/Apply/apply1.dart';
import 'package:sfscredit/ui/views/app/Requests/request.dart';
import 'package:sfscredit/ui/views/app/dashboard2.dart';

class PendingRequestScreen extends StatelessWidget {
  static const routeName = '/app/Requests/pendingRequest.dart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Requests"),
      ),
      backgroundColor: Colors.white,



      body: Container(
        child: SingleChildScrollView(
          child: new Container(
            child: new SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: new ConstrainedBox(
                constraints: new BoxConstraints(),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      //margin: EdgeInsets.only(top: 5,),
                      //padding: EdgeInsets.only(right: 240),
                      height: 100,
                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.circular(20),
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
                              offset: Offset(0, 10),)
                          ]),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Container(
                            width: 140.0,
                              child: Center(
                                child: Text(
                                  "All",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),

                          ),
                          Container(
                            width: 140.0,
                            color: Colors.transparent,
                            child: RaisedButton(
                              // padding: EdgeInsets.only(top: 20, left: 1, right: 1),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PendingRequestScreen(),
                                  ),
                                );
                              },
                              splashColor: Colors.white,
                              //decoration: BoxDecoration(

                              child: Center(
                                child: Text(
                                  "Pending",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                            ),
                          ),

                          Container(
                            width: 140.0,

                            child: Center(
                              child: Text(
                                "Approved",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 17),
                              ),
                            ),
                          ),


                          Container(
                            width: 140.0,

                            child: Center(
                              child: Text(
                                "Declined",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 17),
                              ),
                            ),
                          ),
//
//
//
//
                          // ),

                          //  SizedBox(width: 7.0),
                        ],
                      ),
                    ),
                    // History
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5,left: 30),
                      //padding: EdgeInsets.only(right: 280),
                      height: 40,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
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
                            "History",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Hexcolor('#120A44'),
                              fontSize: 17,
                            ),
                          ),
//
                          // ),

                          //  SizedBox(width: 7.0),
                        ],
                      ),
                    ),

                    // SizedBox(height: 5,),
                    ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          return ListTile(
                            title: Text("Package 1",
                              style: TextStyle(color: Hexcolor('#120A44'),fontSize: 17,fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Date"),
                            trailing: Text("N0.00"),
                          );
                        }, separatorBuilder: (context, index){
                      return Divider(height: 16,);
                    },itemCount: 7),

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

