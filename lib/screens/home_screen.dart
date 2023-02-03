import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });

  }

  int budget = 10000;
  int expen=5900;
  late double perc=expen/budget;
  late double pe=perc*100;

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

  Stream<List<Details>> readUsers() => FirebaseFirestore.instance
      .collection('expenses')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => Details.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Welcome"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                //done
                color: Colors.white,
              ),
              onPressed: () {
                logout(context);
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
            )
                .whenComplete(() {
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
          padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
          child: ListView(
              children: <Widget>[
                Container(
                  child: CircularPercentIndicator(
                    radius: 250,
                    lineWidth: 30,
                    percent: perc,
                    center: Text(
                      '$pe%',
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
                    progressColor: Colors.greenAccent,
                    backgroundColor: Colors.blue,
                    animation: true,
                    animationDuration: 5000,
                  ),
                ),
                Container(
                  child: StreamBuilder<List<Details>>(
                      stream: readUsers(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final txdatas = snapshot.data!;

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



Widget expenseTile(int value, String note, Details detil) {
  return Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(
      18.0,
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
            fontSize: 24.0,
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
      18.0,
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
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}


}
