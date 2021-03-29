import 'package:fashiondada/pages/All.dart';
import 'package:fashiondada/pages/Women.dart';
import 'package:fashiondada/scoped-models/main.dart';
import 'package:flutter/material.dart';

import 'Men.dart';

class HomeP extends StatefulWidget {
  final MainModel model;
  HomeP(this.model);
  @override
  _HomePState createState() => _HomePState();
}

class _HomePState extends State<HomeP> {

  int _currentIndex = 0; 
  PageController _tabController;

  @override
  void initState() {

    super.initState();
    _tabController = PageController();
  }

  //when tab is selected
  void onItemSelected(int page) {
    _tabController.jumpToPage(page);
  }

  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
            backgroundColor: Colors.white,
             bottom: TabBar(
               onTap: onItemSelected,
               labelColor: Colors.black,
               indicatorWeight: 4,
               indicatorColor: Color(0XFF4CAF50),
                tabs: [
                  Tab(text: 'ALL',),
                  Tab(text: 'MEN',),
                  Tab(text: 'WOMEN'),
                ],
              ),
          ),
        ),
        body:TabBarView(
        children: 
    [
               AllP(widget.model),
               MenP(widget.model),
               WomenP(widget.model),
    ]
    ),
         ))
     ;
   }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _tabController.jumpToPage(index);
      
    });
  }
  
  }
