
import 'package:fashiondada/scoped-models/main.dart';
import 'package:fashiondada/widgets/products/products.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class WomenP extends StatefulWidget {
  final MainModel model;
  WomenP(this.model);
  @override
  _HomePState createState() => _HomePState();
}

class _HomePState extends State<WomenP> {

  Color _colors = Colors.grey;
  Color _selectedColor = Colors.pink[200];
  String selectedButton;
  //String buttons;
  String fetchProductCategory;
  //List<String> menus;

  List<String> women ;

  @override
  void initState() {
  //   women = [
  //   'jeans',
  //   'nywele',
  //   'vitenge/\nmishono',
  //   'suruali',
  //   'mikoba',
  //   'magauni',
  //   'suti',
  //   'nguo za\n ndani',
  //   'viatu',
  //   'makoti/\nmasweta',
  //   'sketi/\nblauzi',
  // ];
      women = [
    'Nywele',
    'Urembo',
    'Vitenge',
    'Suruali',
    'Mikoba',
    'Magauni',
    'Suti',
    'Chupi',
    'Viatu',
    'Sweta',
    'Sketi',
    'Blauzi'
  ];
    //fetch retuns null
    widget.model.fetchProductCategory('Nywele',);
    widget.model.fetchProducts();

    setState(() {
      selectedButton = women[0];
    });


    super.initState();
    
  }

  

  Widget _buildCategoryBtns() {
    return ListView.builder(
      itemBuilder: _buildButtonItem,
      itemCount: women.length,
    );
  }

  Widget _buildButtonItem(BuildContext context, int index) {
    return ScopedModelDescendant<MainModel>(
      builder: (
        //acquiring data from productModel using
        BuildContext context, //scope model package imported...
        Widget child, //whenever data changes all these code gets excuted..
        MainModel model,
      ) {
        return Container(
            width: MediaQuery.of(context).size.width * 0.24,
            child: Card(
              child: FlatButton(
                child: Text(women[index]),
                onPressed: () {
                  //model.autoAuthenticate();>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                  _onChanged(women[index]);
                  setState(() {
                    widget.model.fetchProductCategory(women[index]);
                    widget.model.fetchProducts();
                  });
                },
                color: women[index] == selectedButton
                    ? _selectedColor
                    : _colors, //specify background color  of button from our list of colors
              ),
            )); //products is a getter method...
      },
    );
     }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  color: Colors.white,
                  child: _buildCategoryBtns(),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  color: Colors.white,
                  child: Products(),
                ),
              ],
            
    )
    );
  }


  _onChanged(button) {
    //update with a new color when the user taps button
    setState(() {
      selectedButton = button;
    });
  }

  void btnForAGivenTab() {
    setState(() {
          selectedButton = women[0]; //to solve problem of color
        });
    
  }

}
