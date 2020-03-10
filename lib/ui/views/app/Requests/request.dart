import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sfscredit/services/application_service.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/views/app/Apply/apply1.dart';
import 'package:sfscredit/ui/views/app/Requests/allRequest.dart';
import 'package:sfscredit/ui/views/app/Dashboard/dashboard2.dart';

class Request1Screen extends StatelessWidget {
  static const routeName = '/app/Requests/request.dart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Requests"),
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
                      child: Stack(
                        children: <Widget>[

                          Positioned(
                            height: 40,
                            width: 25,
                            right: 10,
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
                            top: 50,
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

                                  new Text('Total Guaranteed Loans',
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
                            "Requests",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color:Hexcolor('#120A44'),
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
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            padding: EdgeInsets.only(top: 15),
                            decoration: BoxDecoration(
                                color: Hexcolor('#120A44'),
                                image: DecorationImage(
                                  alignment: Alignment.topLeft,
                                  image: AssetImage('assets/images/up1.png'),
                                ),
                                borderRadius: BorderRadius.circular(15.0)
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
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            padding: EdgeInsets.only(top: 25),
                            decoration: BoxDecoration(
                                color: Hexcolor('#70C6FF'),
                                image: DecorationImage(
                                  alignment: Alignment.topLeft,
                                  image: AssetImage('assets/images/up1.png'),
                                ),
                                borderRadius: BorderRadius.circular(15.0)
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
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            //padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Hexcolor('#7787FC'),
                              borderRadius: BorderRadius.circular(15.0),
                              image: DecorationImage(
                                alignment: Alignment.topLeft,
                                image: AssetImage('assets/images/up2.png'),
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
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            //padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Hexcolor('#E2E2E2'),
                              borderRadius: BorderRadius.circular(15.0),
                              image: DecorationImage(
                                alignment: Alignment.topLeft,
                                image: AssetImage('assets/images/up1.png'),
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

                    Container(
                      child: Column(
                        children: <Widget>[

                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              //  Image(image: AssetImage('assets/images/circle2.png',),color: Colors.grey,alignment: Alignment.topLeft,),
                              new Text('History',
                                style: TextStyle(fontSize: 15,color: Colors.indigo[900],fontWeight: FontWeight.normal,),

                              ),

                              RaisedButton(
                                color: Colors.white,
                                elevation: 4,
                                child: Text(
                                  "See All ",
                                  style: TextStyle(
                                    color: Hexcolor('#120A44'),
                                    fontSize: 12,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AllRequestScreen(),
                                    ),
                                  );
                                },
                              ),

                              // new Text('N25,000.00 monthly repayment'),
//                                    new Text('  Row'),
                            ],
                          ),
                          //  Image(image: AssetImage('assets/images/icon4.png'),alignment: Alignment.topRight,)

//
//                                new Text('Row'),
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
                    },itemCount: 10),

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
              builder: (context) => Dashboard(),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

}
