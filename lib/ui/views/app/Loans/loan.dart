
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/views/app/Apply/apply1.dart';
import 'package:sfscredit/ui/views/app/Dashboard/dashboard.dart';
import 'package:sfscredit/ui/views/app/Requests/allRequest.dart';
import 'package:sfscredit/ui/views/app/profile/update_kyc.dart';
import 'package:sfscredit/ui/widgets/card_item.dart';
import 'package:sfscredit/ui/widgets/text_link.dart';
import 'package:sfscredit/viewmodels/application_view_model.dart';
import 'package:flutter/widgets.dart';

//import 'profile/update_kyc.dart';
//import 'package:sfscredit/ui/views/app/profile/settings.dart';
//import 'package:settings_ui/settings_ui.dart';


class MyLoanScreen extends StatelessWidget {

  static const routeName = '/app/Loans/loan';

  get value => null;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ApplicationViewModel>.withConsumer(
      viewModel: ApplicationViewModel(),
      //onModelReady: (model) => model.init(),
      builder: (context, model, child) =>
          WillPopScope(
            onWillPop: () async => await model.onWillPop(),
            child: Scaffold(
              appBar: AppBar(
                title: Text("My Loans"),
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

              // backgroundColor: Colors.white,
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
                              //padding: EdgeInsets.only(top: 20),
                              height: 200,
                              // width:400 ,
                              decoration: BoxDecoration(
                                //color: randomColor(),
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/background.png'),
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
                                          image: AssetImage(
                                              'assets/images/avatar.png'),
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
                                          image: AssetImage(
                                              'assets/images/avatar.png'),
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
                                      padding: EdgeInsets.only(
                                          right: 50, bottom: 50),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              15),
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
                                            style: TextStyle(fontSize: 15,
                                                color: Colors.indigo[900]),

                                          ),

                                          new Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            children: <Widget>[
                                              new Text('N 0.00',
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.indigo[900],
                                                  fontWeight: FontWeight.bold,),

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
                              margin: EdgeInsets.only(top: 5, left: 30),
                              //padding: EdgeInsets.only(right: 280),
                              height: 40,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
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
                                    "Loans",
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

//
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20.0),
                              height: 150,
//                    width: 250,
                              child: ListView(
                                // controller: PageController(viewportFraction: 0.0),
                                scrollDirection: Axis.horizontal,
                                // pageSnapping: true,
                                children: <Widget>[
                                  Container(
                                    width: 150,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    padding: EdgeInsets.only(top: 15),
                                    decoration: BoxDecoration(
                                        color: Hexcolor('#120A44'),
                                        image: DecorationImage(
                                          alignment: Alignment.topLeft,
                                          image: AssetImage(
                                              'assets/images/up1.png'),
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            15.0)
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Active",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 17),
                                      ),
                                    ),

                                  ),
                                  Container(
                                    width: 150,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    padding: EdgeInsets.only(top: 25),
                                    decoration: BoxDecoration(
                                        color: Hexcolor('#70C6FF'),
                                        image: DecorationImage(
                                          alignment: Alignment.topLeft,
                                          image: AssetImage(
                                              'assets/images/up1.png'),
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            15.0)
                                    ),
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
                                    width: 150,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    //padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Hexcolor('#7787FC'),
                                      borderRadius: BorderRadius.circular(15.0),
                                      image: DecorationImage(
                                        alignment: Alignment.topLeft,
                                        image: AssetImage(
                                            'assets/images/up2.png'),
                                      ),
                                    ),
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
                                  Container(
                                    width: 150,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    //padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Hexcolor('#E2E2E2'),
                                      borderRadius: BorderRadius.circular(15.0),
                                      image: DecorationImage(
                                        alignment: Alignment.topLeft,
                                        image: AssetImage(
                                            'assets/images/up1.png'),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Pending",
                                        style: TextStyle(
                                            color: Hexcolor('#120A44'),
                                            fontWeight: FontWeight.normal,
                                            fontSize: 17),
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
                              margin: EdgeInsets.only(top: 5, left: 30),
                              //padding: EdgeInsets.only(right: 280),
                              height: 40,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
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
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text("Package 1",
                                      style: TextStyle(
                                          color: Hexcolor('#120A44'),
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text("Date"),
                                    trailing: Text("N0.00"),
                                  );
                                }, separatorBuilder: (context, index) {
                              return Divider(height: 16,);
                            }, itemCount: 10),

                          ],
                        ),
                      ),
                    ),
                  ),

                ),
              ),
            ),
          ),
    );
  }
}
