import 'package:expense_manager/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'set_limit.dart';
import 'login_screen.dart';
import 'package:flutter/material.dart';
import 'package:expense_manager/cards/info_card.dart';


class UserInformation extends StatefulWidget {
  UserModel curr_user;
  UserInformation({Key? key, required this.curr_user}) : super(key: key);
  @override
  State<UserInformation> createState() => _UserInformationState(curr_user);
}

class _UserInformationState extends State<UserInformation> {
  UserModel curr_user;
  _UserInformationState(this.curr_user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
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
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 100),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Color(0xffE6E6E6),
                radius: 60,
                child: Icon(
                  Icons.person,
                  color: Colors.black87,
                  size: 85,
                ),
              ),
              SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              InfoCard(
                  text: curr_user.firstName.toString(),
                  icon: Icons.person_outline,
                  onPressed: () async {}),
              InfoCard(
                  text: curr_user.secondName.toString(),
                  icon: Icons.person_outline,
                  onPressed: () async {}),
              InfoCard(
                  text: curr_user.email.toString(),
                  icon: Icons.email,
                  onPressed: () async {}),
              InfoCard(
                  text: curr_user.mobile.toString(),
                  icon: Icons.phone,
                  onPressed: () async {}),

              Row(
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(3.0),
                      margin: EdgeInsets.only(
                        left: 10.0,
                      ),
                      child: TextButton.icon(
                          label: Text(
                            'Set Maximum Limits',
                            style: TextStyle(color: Colors.black),
                          ),
                          icon: Icon(Icons.add_alert),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SetLimits(curr_user: curr_user),
                              ),
                            );
                            print('Pressed');
                          })),
                  SizedBox(
                    width: 30,
                  ),

                ],
              ),
            ],
          ),
        ));
  }


  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
