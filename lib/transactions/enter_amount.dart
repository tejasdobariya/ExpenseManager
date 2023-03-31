import 'package:expense_manager/transactions/add_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnterAmount extends StatefulWidget {
  const EnterAmount({Key? key, required this.text, required this.email}) : super(key: key);

  final String email,text;


  @override
  State<EnterAmount> createState() => _EnterAmountState(email);
}

class _EnterAmountState extends State<EnterAmount> {

  int amount=0;
  String email;
  _EnterAmountState(this.email);
  TextEditingController amo = new TextEditingController();

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
        title: Text(widget.text),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              //done

              color: Colors.white,
            ),
            onPressed: () {
              if (amount != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddTransaction(amount:amount,category: widget.text, email: email)),
                );
              } else {
                print("Not all values provided!");
              }
            },
          )
        ],
      ),
      body: Container(
        // padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Container(
              color: Colors.red[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(children: <Widget>[
                    SizedBox(
                      height: 18.0,
                    ),
                    Text(
                      'Category',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      widget.text,
                      style: TextStyle(
                          fontSize: 25
                      ),
                    ),
                  ],),
                  Column(children: <Widget>[
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      'Account',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      "CASH",
                      style: TextStyle(
                          fontSize: 25
                      ),
                    ),
                  ],),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 100, 40, 0),
              child: TextField(
                controller: amo,
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                    hintText: "Enter Amount"
                ),
                onChanged: (val){
                  try{
                    amount=int.parse(val);
                  }catch(e){}
                },
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
              ),
            )
          ],
        ),

      ),
    );
  }
}



