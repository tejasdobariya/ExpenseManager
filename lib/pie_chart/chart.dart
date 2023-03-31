import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';

class ChartPie extends StatefulWidget {
  UserModel curr_user;
  Map<String, double> dataMap;


  ChartPie({Key? key, required this.curr_user, required  this.dataMap}) : super(key: key);

  @override
  State<ChartPie> createState() => _ChartPieState(curr_user,dataMap);
}

class _ChartPieState extends State<ChartPie> {
  UserModel curr_user;
  Map<String, double> dataMap;

  _ChartPieState(this.curr_user,this.dataMap);


  @override
  void initState()
  {
    super.initState();
  }


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
          child: PieChart(
            dataMap: dataMap,
            animationDuration: Duration(milliseconds: 3000),
            chartLegendSpacing: 20,
            chartRadius: MediaQuery.of(context).size.width / 1.2,
            // colorList: colorList,
            initialAngleInDegree: 180,
            chartType: ChartType.disc,
            ringStrokeWidth: 32,
            // centerText: "HYBRID",
            legendOptions: const LegendOptions(
              showLegendsInRow: true,
              legendPosition: LegendPosition.bottom,
              showLegends: true,
              legendShape: BoxShape.rectangle,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: true,
              showChartValuesOutside: true,
              decimalPlaces: 1,
            ),
          )
      ),
    );
  }
}
