import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTransaction extends StatefulWidget {
  final String text;
  final String email;
  const AddTransaction({Key? key, required this.text, required this.email})
      : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState(text, email);
}

class _AddTransactionState extends State<AddTransaction> {
  String txid(DateTime td) {
    String id = "S";
    id += td.day.toString() + td.month.toString() + td.year.toString();
    id += td.second.toString();
    return id;
  }

  String text;
  String email;
  _AddTransactionState(this.text, this.email);
  int amount = 0;
  String note = "";
  String type = "Income";
  DateTime selectedDate = DateTime.now();
  String txnid = "";

  TextEditingController amo = new TextEditingController();
  TextEditingController nt = new TextEditingController();

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2021),
        lastDate: DateTime(2100));

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Transaction"),
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          elevation: 0.00,
          backgroundColor: Colors.red[400],
        ),
        backgroundColor: Color(0xffe2e7ef),
        body: ListView(
          padding: EdgeInsets.all(
            12.0,
          ),
          children: [
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: EdgeInsets.all(
                    12.0,
                  ),
                  child: Icon(
                    Icons.category,
                    size: 24.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: EdgeInsets.all(
                    12.0,
                  ),
                  child: Icon(
                    Icons.attach_money,
                    size: 24.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: TextField(
                    controller: amo,
                    decoration: InputDecoration(
                      hintText: "0",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                    onChanged: (val) {
                      try {
                        amount = int.parse(val);
                      } catch (e) {}
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: EdgeInsets.all(
                    12.0,
                  ),
                  child: Icon(
                    Icons.description,
                    size: 24.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: TextField(
                    controller: nt,
                    decoration: InputDecoration(
                      hintText: "Note",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                    onChanged: (val) {
                      note = val;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: EdgeInsets.all(
                    12.0,
                  ),
                  child: Icon(
                    Icons.moving_sharp,
                    size: 24.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                ChoiceChip(
                  label: Text(
                    "Income",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: type == "Income" ? Colors.white : Colors.black,
                    ),
                  ),
                  selectedColor: Colors.indigo,
                  selected: type == "Income" ? true : false,
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        type = "Income";
                      });
                    }
                  },
                ),
                SizedBox(
                  width: 12.0,
                ),
                ChoiceChip(
                  label: Text(
                    "Expense",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: type == "Expense" ? Colors.white : Colors.black,
                    ),
                  ),
                  selectedColor: Colors.indigo,
                  selected: type == "Expense" ? true : false,
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        type = "Expense";
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 50.0,
              child: TextButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.zero,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(
                            16.0,
                          ),
                        ),
                        padding: EdgeInsets.all(
                          12.0,
                        ),
                        child: Icon(
                          Icons.date_range,
                          size: 24.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Text(
                        "${selectedDate.day} ${months[selectedDate.month - 1]}",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 50.0,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)
                          )
                      )
                  ),
                onPressed: () {
                  if (amount != null && note.isNotEmpty) {
                    txnid = txid(selectedDate);
                    print(txnid);
                    // final docUser =
                    //     FirebaseFirestore.instance.collection('expenses').doc();
                    // print(docUser.id);
                    // Map<String, dynamic> data = {
                    //   "id": docUser.id,
                    //   "amount": amo.text,
                    //   "category": text,
                    //   "date": selectedDate,
                    //   "email": email,
                    //   "note": nt.text,
                    //   "txnid": txnid,
                    //   "type": type
                    // };
                    // docUser.set(data);

                    //add transaction details to db code
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => HomePage(email: email,),
                    //   ),
                    // );
                  } else {
                    print("Not all values provided!");
                  }
                },
                child: Text(
                  "Add",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
