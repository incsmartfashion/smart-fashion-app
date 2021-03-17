import 'package:fashiondada/scoped-models/main.dart';
import 'package:flutter/material.dart';

import './product_edit.dart';
import './product_list.dart';

class ProductsAdminPage extends StatelessWidget {
  //final BuildContext contextMain;
  final MainModel model;
  ProductsAdminPage(this.model);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: () {
          //Navigator.pop(context, false);
          Navigator.pushReplacementNamed(context, '/homescreen');
          return Future.value(false);
        },
        child: Scaffold(
          //drawer: _buildSideDrawer(context),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(75.0),
              child: AppBar(
              leading: IconButton(icon:Icon(Icons.arrow_back),
                onPressed:(){
                 Navigator.pushReplacementNamed(context, '/homescreen');
                },),
              backgroundColor: Colors.grey[200],
              bottom: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.create),
                    text: 'Weka Bidhaa',
                    
                  ),
                  Tab(
                    icon: Icon(Icons.list),
                    text: 'Bidhaa Zangu',
                  ),
                ],
              ),
            //   actions: <Widget>[
            //     Column(
            //   children: <Widget>[
            //     IconButton(
            //       icon: Icon(Icons.exit_to_app,), onPressed: (){
            // model.logout();
            // Navigator.pushReplacementNamed(context, '/homescreen');
            //     }
            //     ),
            //     Text('Logout',style: TextStyle(color: Colors.black,fontSize: 7),)
            //   ],
            // ), 
            //   ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ProductEditPage(model),
              ProductListPage(model),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
