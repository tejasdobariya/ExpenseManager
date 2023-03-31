import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/details.dart';
import '../transactions/view_transaction.dart';

class AllTransactions extends StatefulWidget {
  UserModel curr_user;
  AllTransactions({Key? key, required this.curr_user}) : super(key: key);

  @override
  State<AllTransactions> createState() => _AllTransactionsState(curr_user);
}

class _AllTransactionsState extends State<AllTransactions> {
  UserModel curr_user;
  _AllTransactionsState(this.curr_user);

  Stream<List<Details>> readUsers() => FirebaseFirestore.instance
      .collection('expenses')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Details.fromJson(doc.data())).toList());

  var now = new DateTime.now();
  late var now_1w = now.subtract(Duration(days: 7));
  late var now_1m = new DateTime(now.year, now.month-1, now.day);

  Widget buildUser(Details detil) {
    if (detil.type == 'Income' && curr_user.email == detil.email && detil.selectedDate.compareTo(now_1w)>0) {
      return incomeTile(detil.amount, detil.note, detil);
    } else {
      if (curr_user.email == detil.email && detil.selectedDate.compareTo(now_1w)>0) {
        return expenseTile(detil.amount, detil.note, detil);
      }
    }
    return Container();
  }

  Widget buildUser1(Details detil) {
    if (detil.type == 'Income' && curr_user.email == detil.email && detil.selectedDate.compareTo(now_1m)>0) {
      return incomeTile(detil.amount, detil.note, detil);
    } else {
      if (curr_user.email == detil.email && detil.selectedDate.compareTo(now_1m)>0) {
        return expenseTile(detil.amount, detil.note, detil);
      }
    }
    return Container();
  }

  String days = "day7";

  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 12.0,
              ),
              ChoiceChip(
                label: Text(
                  "Last 7 days",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: days == "day7" ? Colors.white : Colors.black,
                  ),
                ),
                selectedColor: Colors.red,
                selected: days == "day7" ? true : false,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      days = "day7";
                    });
                  }
                },
              ),
              SizedBox(
                width: 12.0,
              ),
              ChoiceChip(
                label: Text(
                  "Last 30 days",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: days == "day30" ? Colors.white : Colors.black,
                  ),
                ),
                selectedColor: Colors.red,
                selected: days == "day30" ? true : false,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      days = "day30";
                    });
                  }
                },
              ),
            ],
          ),
          if (days == "day7") ...[
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
            )
          ] else ...[
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
                        children: txdatas.map(buildUser1).toList(),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            )
          ],
        ],
      ),
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
