
import 'package:fashiondada/pages/auth.dart';
import 'package:fashiondada/pages/products_admin.dart';

import 'package:fashiondada/scoped-models/main.dart';
import 'package:flutter/material.dart';
import 'indicator.dart';


class ProductsPage extends StatefulWidget { 
  final MainModel model;
  final bool _isAuthenticated;
  ProductsPage(this.model,this._isAuthenticated);
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  int _selectedIndex = 0;
  bool _isAuthenticated = false;
   List<Widget> _widgetOptions;

  @override
  void initState() {
        widget.model.userSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
    _widgetOptions = <Widget>[
      HomeP(widget.model),
      widget._isAuthenticated?ProductsAdminPage(widget.model):AuthPage(widget.model),
  ];
    super.initState();
  }

  void _onItemTapped(int index) {
   widget.model.fetchEmailPassword();
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
          centerTitle: true,
          title: Text("Smart Fashion", style: TextStyle(color: Colors.black),),
          backgroundColor: Color(0X222222),
          ),
      ),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 20,
          backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Nunua'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            title: Text('Uza'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedLabelStyle: TextStyle(fontFamily: 'Raleway-Bold'),
        selectedItemColor: Color(0XFFEF476F),
        onTap: _onItemTapped,
      ),
      body: Center(
        
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }

}