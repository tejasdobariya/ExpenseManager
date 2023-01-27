import 'package:flutter/material.dart';

import 'add_transaction.dart';

class SelectCategory extends StatelessWidget {
  String email;

  SelectCategory({Key? key, required this.email}) : super(key: key);
  final mycontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Category"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              //row 1
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Icon(Icons.fastfood, size: 70),
                      ElevatedButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddTransaction(text: 'Food', email: email),
                            ),
                          )
                        },
                        child: Text('Food'),
                      ),
                    ]),
                    Column(children: <Widget>[
                      Icon(Icons.shopping_cart, size: 70),
                      ElevatedButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddTransaction(
                                  text: "Shopping", email: email),
                            ),
                          )
                        },
                        child: Text('Shopping'),
                      ),
                    ]),
                    Column(children: <Widget>[
                      Icon(Icons.medical_services, size: 70),
                      ElevatedButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddTransaction(text: "Medical", email: email),
                            ),
                          )
                        },
                        child: Text('Medical'),
                      ),
                    ]),
                  ]),
              SizedBox(
                height: 40,
              ),
              //row 2
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Icon(Icons.child_friendly, size: 70),
                      ElevatedButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddTransaction(text: "Kids", email: email),
                            ),
                          )
                        },
                        child: Text('Kids'),
                      ),
                    ]),
                    Column(children: <Widget>[
                      Icon(Icons.person, size: 70),
                      ElevatedButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddTransaction(
                                  text: "Entertainment", email: email),
                            ),
                          )
                        },
                        child: Text('Entertainment'),
                      ),
                    ]),
                    Column(children: <Widget>[
                      Icon(Icons.car_rental, size: 70),
                      ElevatedButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddTransaction(text: "Vehicle", email: email),
                            ),
                          )
                        },
                        child: Text('Vehicle'),
                      ),
                    ]),
                  ]),
              SizedBox(
                height: 40,
              ),
              //row 3
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Icon(Icons.house, size: 70),
                      ElevatedButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddTransaction(text: "Housing", email: email),
                            ),
                          )
                        },
                        child: Text('Housing'),
                      ),
                    ]),
                    Column(children: <Widget>[
                      Icon(Icons.shopping_basket, size: 70),
                      ElevatedButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddTransaction(
                                  text: "Groceries", email: email),
                            ),
                          )
                        },
                        child: Text('Groceries'),
                      ),
                    ]),
                    Column(children: <Widget>[
                      Icon(Icons.shopping_cart, size: 70),
                      ElevatedButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddTransaction(text: "General", email: email),
                            ),
                          )
                        },
                        child: Text('General'),
                      ),
                    ]),
                  ]),
              SizedBox(
                height: 40,
              ),
              //row 4
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
                  Widget>[
                Column(children: <Widget>[
                  Icon(Icons.payment, size: 70),
                  ElevatedButton(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddTransaction(text: "Bills", email: email),
                        ),
                      )
                    },
                    child: Text('Bills'),
                  ),
                ]),
                Column(children: <Widget>[
                  Icon(Icons.attach_money, size: 70),
                  ElevatedButton(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddTransaction(text: "Investment", email: email),
                        ),
                      )
                    },
                    child: Text('Investment'),
                  ),
                ]),
                Column(children: <Widget>[
                  Icon(Icons.note_alt, size: 70),
                  ElevatedButton(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddTransaction(text: "Education", email: email),
                        ),
                      )
                    },
                    child: Text('Education'),
                  ),
                ]),
              ]),
            ],
          ),
        ));
  }
}

//food,shopping,medical ,entertainment, investments, vehicle, groceries,kids, housing, bills, Education,general
