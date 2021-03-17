import 'package:fashiondada/scoped-models/main.dart';

import 'package:flutter/material.dart';

import 'allTrial1.dart';
import 'allTrial2.dart';
import 'allTrial3.dart';
import 'allTrial4.dart';
import 'allTrial5.dart';
import 'alltrial.dart';

class AllP extends StatefulWidget {
  final MainModel model;
  AllP(this.model);
  @override
  _HomePState createState() => _HomePState();
}

class _HomePState extends State<AllP> {

  String selectedButton;
  //String buttons;
  String fetchProductCategory;
  //List<String> menus;

  List<String> all ;

  @override
  void initState() {
  all = [
    'computer',
    'accessories',
    'zawadi',
    'saa',
    'simu',
    'vipodozi',
  ];


    setState(() {
      selectedButton = all[0];
    });


    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Column(
                children: <Widget>[
                  Text('kompyuta',style: TextStyle(fontWeight: FontWeight.bold),),
                  Container(height: 150,child: AllTrial(widget.model,)),
                ],
              ), //1
              Divider(),
              Divider(),
              Column(
                children: <Widget>[
                   Text('Vifaa',style: TextStyle(fontWeight: FontWeight.bold),),
                   Container(height: 150, child: AllTrial1(widget.model)), //2
                   Divider(),
                   Text('Zawadi',style: TextStyle(fontWeight: FontWeight.bold),),
                   Container(height: 150, child: AllTrial2(widget.model)), //3
                ],
              ),

              
              Divider(),
              Divider(),
              Column(
                children: <Widget>[
                  Text('Saa',style: TextStyle(fontWeight: FontWeight.bold),),
                  Container(height: 150, child: AllTrial3(widget.model)), //4
                  Divider(),
                  Text('Simu',style: TextStyle(fontWeight: FontWeight.bold),),
                  Container(height: 150,child: AllTrial4(widget.model,)), //5
                ],
              ), 
               Divider(),
               Divider(),
              Column(
                children: <Widget>[
                  Text('Vipodozi',style: TextStyle(fontWeight: FontWeight.bold),),
                  Container(height: 150, child: AllTrial5(widget.model)),],), //6
              Divider(),
              
          ],),
      ),

    );
  }

  void btnForAGivenTab() {
    setState(() {
          selectedButton = all[0]; //to solve problem of color
        });
    
  }

}
