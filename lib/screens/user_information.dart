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
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(3.0),
                      margin: EdgeInsets.only(
                        right: 10.0,
                      ),
                      child: TextButton.icon(
                          label: Text(
                            'Download Report',
                            style: TextStyle(color: Colors.black),
                          ),
                          icon: Icon(Icons.download),
                          onPressed: _createPDF,
                      ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Future<void> _createPDF() async {

    // PdfDocument document = PdfDocument();
    // final page = document.pages.add();
    //
    // List<int> bytes = document.save() as List<int>;
    // document.dispose();

    // page.graphics.drawString('Welcome to PDF Succinctly!',
    //     PdfStandardFont(PdfFontFamily.helvetica, 30));
    //
    // page.graphics.drawImage(
    //     PdfBitmap(await _readImageData('Pdf_Succinctly.jpg')),
    //     Rect.fromLTWH(0, 100, 440, 550));
    //
    // PdfGrid grid = PdfGrid();
    // grid.style = PdfGridStyle(
    //     font: PdfStandardFont(PdfFontFamily.helvetica, 30),
    //     cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));
    //
    // grid.columns.add(count: 3);
    // grid.headers.add(1);
    //
    // PdfGridRow header = grid.headers[0];
    // header.cells[0].value = 'Roll No';
    // header.cells[1].value = 'Name';
    // header.cells[2].value = 'Class';
    //
    // PdfGridRow row = grid.rows.add();
    // row.cells[0].value = '1';
    // row.cells[1].value = 'Arya';
    // row.cells[2].value = '6';
    //
    // row = grid.rows.add();
    // row.cells[0].value = '2';
    // row.cells[1].value = 'John';
    // row.cells[2].value = '9';
    //
    // row = grid.rows.add();
    // row.cells[0].value = '3';
    // row.cells[1].value = 'Tony';
    // row.cells[2].value = '8';
    //
    // grid.draw(
    //     page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));
    //
    // List<int> bytes = document.save();
    // document.dispose();
    //
    // saveAndLaunchFile(bytes, 'Output.pdf');
  }


  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
