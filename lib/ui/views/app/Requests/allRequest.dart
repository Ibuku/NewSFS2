import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sfscredit/services/application_service.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/views/app/Apply/apply1.dart';
import 'package:sfscredit/ui/views/app/Dashboard/dashboard2.dart';
import 'package:sfscredit/ui/views/app/Loans/loan.dart';
import 'package:sfscredit/ui/views/app/Requests/approvedRequest.dart';
import 'package:sfscredit/ui/views/app/Requests/request.dart';
import 'package:sfscredit/ui/views/app/Dashboard/dashboard2.dart';

class AllRequestScreen extends StatelessWidget {
  static const routeName = '/app/Requests/allRequest.dart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text("All Requests"),
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
                    var model;
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
                            color: Colors.transparent,
                            width: 140.0,
                            child: RaisedButton(
                              // padding: EdgeInsets.only(top: 20, left: 1, right: 1),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AllRequestScreen(),
                                  ),
                                );
                              },
                              splashColor: Colors.white,
                              //decoration: BoxDecoration(

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
                          ),
                          Container(
                            width: 140.0,

                            child: Center(
                              child: Text(
                                "Pending",
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
              builder: (context) => ApprovedRequestScreen(),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

}

