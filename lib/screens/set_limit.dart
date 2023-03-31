import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/model/categories.dart';
import 'package:expense_manager/model/user_model.dart';
import 'package:expense_manager/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SetLimits extends StatefulWidget {
  UserModel curr_user;
  SetLimits({Key? key, required this.curr_user}) : super(key: key);

  @override
  State<SetLimits> createState() => _SetLimitsState(curr_user);
}

class _SetLimitsState extends State<SetLimits> {
  UserModel curr_user;
  _SetLimitsState(this.curr_user);

  num food = 0;
  num shopping = 0;
  num medical = 0;
  num kids = 0;
  num entertainment = 0;
  num vehicle = 0;
  num housing = 0;
  num groceries = 0;
  num general = 0;
  num bills = 0;
  num investment = 0;
  num education = 0;

  TextEditingController foodcontroller = new TextEditingController();
  TextEditingController shoppingcontroller = new TextEditingController();
  TextEditingController medicalcontroller = new TextEditingController();
  TextEditingController kidscontroller = new TextEditingController();
  TextEditingController entercontroller = new TextEditingController();
  TextEditingController vehiclecontroller = new TextEditingController();
  TextEditingController housingcontroller = new TextEditingController();
  TextEditingController groceriescontroller = new TextEditingController();
  TextEditingController generalcontroller = new TextEditingController();
  TextEditingController billscontroller = new TextEditingController();
  TextEditingController investmentcontroller = new TextEditingController();
  TextEditingController educationcontroller = new TextEditingController();

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
        body: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(
                  height: 12.0,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:  <Widget>[
                      Flexible(
                        child:  TextField(
                          controller: foodcontroller,
                            textAlign: TextAlign.center,
                            decoration:   const InputDecoration(
                              alignLabelWithHint: true,
                                border: OutlineInputBorder(),
                                labelText: "Food",
                                hintText:  "0",
                                contentPadding: EdgeInsets.all(10)
                            ),
                          onChanged: (val){
                            try{
                              food=int.parse(val);
                            }catch(e){}
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ), Flexible(
                        child:  TextField(
                          controller: shoppingcontroller,
                            textAlign: TextAlign.center,
                            decoration:  const InputDecoration(
                              alignLabelWithHint: true,
                                border: OutlineInputBorder(),
                                labelText: "Shopping",
                                hintText: "0",
                                contentPadding: EdgeInsets.all(10)
                            ),
                          onChanged: (val){
                            try{
                              shopping=int.parse(val);
                            }catch(e){}
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ), Flexible(
                        child:  TextField(
                          controller: medicalcontroller,
                            textAlign: TextAlign.center,
                            decoration:  const InputDecoration(
                              alignLabelWithHint: true,
                                border: OutlineInputBorder(),
                                labelText: "Medical",
                                hintText: "0",
                                contentPadding: EdgeInsets.all(10)
                            ),
                          onChanged: (val){
                            try{
                              medical=int.parse(val);
                            }catch(e){}
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                    ]),
                SizedBox(height: 20,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:  <Widget>[
                      Flexible(
                        child:  TextField(
                          controller: kidscontroller,
                            textAlign: TextAlign.center,
                            decoration:  const InputDecoration(
                              alignLabelWithHint: true,
                                border: OutlineInputBorder(),
                                labelText: "Kids",
                                hintText: "0",
                                contentPadding: EdgeInsets.all(10)
                            ),
                          onChanged: (val){
                            try{
                              kids=int.parse(val);
                            }catch(e){}
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ), Flexible(
                        child:  TextField(
                          controller: entercontroller,
                            textAlign: TextAlign.center,
                            decoration:  const InputDecoration(
                              alignLabelWithHint: true,
                                border: OutlineInputBorder(),
                                labelText: "Entertainment",
                                hintText: "0",
                                contentPadding: EdgeInsets.all(10)
                            ),
                          onChanged: (val){
                            try{
                              entertainment=int.parse(val);
                            }catch(e){}
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ), Flexible(
                        child:  TextField(
                          controller: vehiclecontroller,
                            textAlign: TextAlign.center,
                            decoration:  const InputDecoration(
                              alignLabelWithHint: true,
                                border: OutlineInputBorder(),
                                labelText: "Vehicle",
                                hintText: "0",
                                contentPadding: EdgeInsets.all(10)
                            ),
                          onChanged: (val){
                            try{
                              vehicle=int.parse(val);
                            }catch(e){}
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                    ]),
                SizedBox(height: 20,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:  <Widget>[
                      Flexible(
                        child:  TextField(
                          controller: housingcontroller,
                            textAlign: TextAlign.center,
                            decoration:  const InputDecoration(
                              alignLabelWithHint: true,
                                border: OutlineInputBorder(),
                                labelText: "Housing",
                                hintText: "0",
                                contentPadding: EdgeInsets.all(10)
                            ),
                          onChanged: (val){
                            try{
                              housing=int.parse(val);
                            }catch(e){}
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ), Flexible(
                        child:  TextField(
                          controller: groceriescontroller,
                            textAlign: TextAlign.center,
                            decoration:  const InputDecoration(
                              alignLabelWithHint: true,
                                border: OutlineInputBorder(),
                                labelText: "Groceries",
                                hintText: "0",
                                contentPadding: EdgeInsets.all(10)
                            ),
                          onChanged: (val){
                            try{
                              groceries=int.parse(val);
                            }catch(e){}
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ), Flexible(
                        child:  TextField(
                          controller: generalcontroller,
                            textAlign: TextAlign.center,
                            decoration:  const InputDecoration(
                              alignLabelWithHint: true,
                                border: OutlineInputBorder(),
                                labelText: "General",
                                hintText: "0",
                                contentPadding: EdgeInsets.all(10)
                            ),
                          onChanged: (val){
                            try{
                              general=int.parse(val);
                            }catch(e){}
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                    ]),
                SizedBox(height: 20,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:  <Widget>[
                      Flexible(
                        child:  TextField(
                          controller: billscontroller,
                            textAlign: TextAlign.center,
                            decoration:  const InputDecoration(
                              alignLabelWithHint: true,
                                border: OutlineInputBorder(),
                                labelText: "Bills",
                                hintText: "0",
                                contentPadding: EdgeInsets.all(10)
                            ),
                          onChanged: (val){
                            try{
                              bills=int.parse(val);
                            }catch(e){}
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ), Flexible(
                        child:  TextField(
                          controller: investmentcontroller,
                            textAlign: TextAlign.center,
                            decoration:  const InputDecoration(
                              alignLabelWithHint: true,
                                border: OutlineInputBorder(),
                                labelText: "Investment",
                                hintText: "0",
                                contentPadding: EdgeInsets.all(10)
                            ),
                          onChanged: (val){
                            try{
                              investment=int.parse(val);
                            }catch(e){}
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ), Flexible(
                        child:  TextField(
                          controller: educationcontroller,
                            textAlign: TextAlign.center,
                            decoration:  const InputDecoration(
                              alignLabelWithHint: true,
                                border: OutlineInputBorder(),
                                labelText: "Education",
                                hintText: "0",
                                contentPadding: EdgeInsets.all(10)
                            ),
                          onChanged: (val){
                            try{
                              education=int.parse(val);
                            }catch(e){}
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                    ]
                ),
                 SizedBox(height: 20,),
                 FlatButton(
                  child: Text('Update', style: TextStyle(fontSize: 20.0),),
                  color: Colors.redAccent,
                  textColor: Colors.white,
                  onPressed: () async {
                    Categories cat=Categories();
                    String id;
                    Map<String,dynamic> newData={
                      'email': curr_user.email,
                      'uid':curr_user.uid,
                      'food': food,
                      'shopping': shopping,
                      'medical': medical,
                      'kids': kids,
                      'entertainment': entertainment,
                      'vehicle': vehicle,
                      'housing': housing,
                      'groceries': groceries,
                      'general': general,
                      'bills': bills,
                      'investment': investment,
                      'education': education
                    };

                     await FirebaseFirestore.instance.collection('limits').where("uid" ,isEqualTo:curr_user.uid)
                        .get().then((QuerySnapshot querysnapshot) {

                          cat = Categories.fromMap(querysnapshot.docs.first.data());
                          print(querysnapshot.docs.first.data());
                    });

                    print(1);
                    print(cat.email);
                    print(cat.id);

                    FirebaseFirestore.instance.collection('limits').doc(cat.id) // <-- Doc ID where data should be updated.
                        .update(newData);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );

                  },
                ),
              ],

            )
        )
    );
  }
}
