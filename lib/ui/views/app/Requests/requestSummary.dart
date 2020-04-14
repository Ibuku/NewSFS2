import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class RequestSummaryScreen extends StatelessWidget {
  static const routeName = '/app/Requests/allRequest.dart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Summary"),
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
                  children: <Widget>[
                    Container(
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
                              offset: Offset(0, 10),
                            )
                          ]),
                    ),

                    // History
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 30),
                      //padding: EdgeInsets.only(right: 280),
                      height: 40,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            height: 380.0,
                          ),
                          Text(
                            "History",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Hexcolor('#120A44'),
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              "Package 1",
                              style: TextStyle(
                                  color: Hexcolor('#120A44'),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Date"),
                            trailing: Text("N0.00"),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 16,
                          );
                        },
                        itemCount: 7),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
