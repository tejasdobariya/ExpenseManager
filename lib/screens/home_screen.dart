import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/model/notification_api.dart';
import 'package:expense_manager/pie_chart/chart.dart';
import 'package:expense_manager/screens/all_transactions.dart';
import 'package:expense_manager/screens/user_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../model/user_model.dart';
import '../transactions/select_category.dart';
import '../transactions/view_transaction.dart';
import 'login_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../model/details.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  late int i;

  NotificationApi notificationApi = NotificationApi();
  @override
  void initState() {
    super.initState();
notificationApi.initialiseNotifications();

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
      balance();
    });



    notificationApi.scheduleNotification('Hey '+loggedInUser.firstName.toString(), 'Have you add your today\s expenses or not!! ');
    i=0;
  }

  num totalBalance = 0;
  num totalIncome = 0;
  num totalExpense = 0;

  num food=0;
  num shopping=0;
  num medical=0;
  num kids=0;
  num entertainment=0;
  num vehicle=0;
  num housing=0;
  num groceries=0;
  num general=0;
  num bills=0;
  num investment=0;
  num education=0;
  // num budget = 10000;
  // num expen=5900;
  late double perc=0;
  late double pe=0;
  late MaterialAccentColor color=Colors.greenAccent;

  Widget buildUser(Details detil) {

      if (detil.type == 'Income' && loggedInUser.email == detil.email) {
        return incomeTile(detil.amount, detil.note, detil);
      } else {
        if (loggedInUser.email == detil.email) {
          return expenseTile(detil.amount, detil.note, detil);
        }
      }

    return Container();
  }

  balance() async {
    await FirebaseFirestore.instance
        .collection('expenses')
        .where('email', isEqualTo: loggedInUser.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print("hello");
        if (doc["type"] == 'Income' && loggedInUser.email == doc["email"]) {
          totalBalance += doc["amount"];
          totalIncome += doc["amount"];
          print("totalBalance :- $totalBalance");
          print("totalincome :- $totalIncome");
        } else {
          if (loggedInUser.email == doc["email"]) {
            totalBalance -= doc["amount"];
            totalExpense += doc["amount"];
            print("totalBalance :- $totalBalance");
            print("totalexpense :- $totalExpense");
          }
        }

        if (doc["category"] == 'Food' && loggedInUser.email == doc["email"]) {
          food+=doc["amount"] ;
        } else if (doc["category"] == 'Shopping' && loggedInUser.email == doc["email"]){
          shopping+=doc["amount"] ;
        }else if (doc["category"] == 'Medical' && loggedInUser.email == doc["email"]){
          medical+=doc["amount"] ;
        }else if (doc["category"] == 'Kids' && loggedInUser.email == doc["email"]){
          kids+=doc["amount"] ;
        }else if (doc["category"] == 'Entertainment' && loggedInUser.email == doc["email"]){
          entertainment+=doc["amount"] ;
        }else if (doc["category"] == 'Vehicle' && loggedInUser.email == doc["email"]){
          vehicle+=doc["amount"] ;
        }else if (doc["category"] == 'Housing' && loggedInUser.email == doc["email"]){
          housing+=doc["amount"] ;
        }else if (doc["category"] == 'Groceries' && loggedInUser.email == doc["email"]){
          groceries+=doc["amount"] ;
        }else if (doc["category"] == 'General' && loggedInUser.email == doc["email"]){
          general+=doc["amount"] ;
        }else if (doc["category"] == 'Bills' && loggedInUser.email == doc["email"]){
          bills+=doc["amount"] ;
        }else if (doc["category"] == 'Investment' && loggedInUser.email == doc["email"]){
          investment+=doc["amount"] ;
        }else if (doc["category"] == 'Education' && loggedInUser.email == doc["email"]){
          education+=doc["amount"] ;
        }
      });
    });
    setState(() {});
    perc=(totalExpense/totalIncome);
    pe=perc*100;
  }


  Stream<List<Details>> readUsers() => FirebaseFirestore.instance
      .collection('expenses')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => Details.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.person,
                //done
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserInformation(curr_user:loggedInUser),
                  ),
                );
              },
            )
          ],
        ),
        backgroundColor: const Color(0xffe2e7ef),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) =>
                    SelectCategory(email: "$loggedInUser.email"),
              ),
            ).whenComplete(() {
              setState(() {});
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              16.0,
            ),
          ),
          child: const Icon(
            Icons.add,
            size: 32.0,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: ListView(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: EdgeInsets.all(
                    12.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black54,
                          Colors.blueAccent,
                        ],
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(24.0),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 15.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Total Balance',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          totalBalance.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                            8.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              cardIncome(
                                totalIncome.toString(),
                              ),
                              cardExpense(
                                totalExpense.toString(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: CircularPercentIndicator(
                    radius: 200,
                    lineWidth: 25,
                    percent: perc,
                    center: Text(
                      pe.toStringAsFixed(0)+'%',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    footer: Padding(
                      padding: const EdgeInsets.all(8.0),
                      // child: Text(
                      //   'Point Score This week',
                      //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      // ),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: color,
                    backgroundColor: Colors.blue,
                    animation: true,
                    animationDuration: 5000,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.black54)
                      )
                  ),
                ),
                Row(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(3.0),
                        margin: EdgeInsets.only(
                          left: 10.0,
                        ),

                        child: TextButton.icon(
                            label: Text('Show more'),
                            icon: Icon(Icons.clear_all_outlined),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AllTransactions(curr_user:loggedInUser),
                                ),
                              );
                              print('Pressed');
                            }
                        )
                    ),
                    SizedBox(width: 100,),
                    Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.all(3.0),
                        margin: EdgeInsets.only(
                          right: 10.0,
                        ),
                        child: TextButton.icon(
                            label: Text('Detailed Analysis'),
                            icon: Icon(Icons.pie_chart),
                            onPressed: () {
                              Map<String, double> dataMap = {
                                "food":food/totalExpense,
                                "shopping":shopping /totalExpense,
                                "medical":medical /totalExpense,
                                "kids":kids /totalExpense,
                                "entertainment":entertainment /totalExpense,
                                "vehicle":vehicle /totalExpense,
                                "housing":housing /totalExpense,
                                "groceries":groceries /totalExpense,
                                "general":general /totalExpense,
                                "bills":bills /totalExpense,
                                "investment":investment /totalExpense,
                                "education" :education/totalExpense
                              };
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChartPie(curr_user:loggedInUser,dataMap:dataMap),
                                ),
                              );
                              print('Pressed');
                            }
                        )
                    ),
                  ],
                ),
                Container(
                  child: StreamBuilder<List<Details>>(
                      stream: readUsers(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final txdatas = snapshot.data!.reversed;



                          return ListView(
                            shrinkWrap: true,
                            children: txdatas.map(buildUser).toList(),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ),



          ]),
        ));
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }


  Widget cardIncome(String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(
              20.0,
            ),
          ),
          padding: EdgeInsets.all(6.0),
          child: Icon(
            Icons.arrow_downward,
            size: 22.0,
            color: Colors.green[700],
          ),
          margin: EdgeInsets.only(
            right: 9.0,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Income',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white70,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget cardExpense(String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(
              20.0,
            ),
          ),
          padding: EdgeInsets.all(6.0),
          child: Icon(
            Icons.arrow_upward,
            size: 22.0,
            color: Colors.red[700],
          ),
          margin: EdgeInsets.only(
            right: 9.0,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Expense',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white70,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ],
    );
  }


Widget expenseTile(int value, String note, Details detil) {
  return Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(
      8.0,
    ),
    decoration: BoxDecoration(
      color: Color(
        0xffced4eb,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_circle_up_outlined,
              ),
              iconSize: 28,
              color: Colors.red[700],
              onPressed: () {
                print(detil.note);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ViewTransaction(tdetail: detil),
                  ),
                );
              },
            ),
            SizedBox(
              width: 4.0,
            ),
            Text(
              note,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        Text(
          "-$value",
          style: TextStyle(
            fontSize: 21.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}


Widget incomeTile(int value, String note, Details detil) {
  return Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(
      8.0,
    ),
    decoration: BoxDecoration(
      color: Color(
        0xffced4eb,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_circle_down_outlined,
              ),
              iconSize: 28,
              color: Colors.green[700],
              onPressed: () {
                print(detil.note);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ViewTransaction(tdetail: detil),
                  ),
                );
              },
            ),
            SizedBox(
              width: 4.0,
            ),
            Text(
              note,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        Text(
          "$value",
          style: TextStyle(
            fontSize: 21.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}


}
