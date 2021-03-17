import 'package:fashiondada/scoped-models/main.dart';
import 'package:fashiondada/widgets/products/products.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class MenP extends StatefulWidget {
  final MainModel model;
  //final int normalFetchIndicator;
  MenP(this.model,/*this.normalFetchIndicator*/);
  @override
  _HomePState createState() => _HomePState();
}

class _HomePState extends State<MenP> {

  Color _colors = Colors.grey;
  Color _selectedColor = Colors.pink[200];
  String selectedButton;
  //String buttons;
  String fetchProductCategory;

   List<String> men;


  @override
  void initState() {
  //   men = [
  //   'Jeans',
  //   'Mashati',
  //   'Suruali/Kadeti',
  //   'Suti/\nMakoti',
  //   'Nguo za\n ndani',
  //   'Viatu vya\n ngozi',
  // ];

  men = [
    'Tisheti',
    'Suruali',
    'Mashati',
    'Bukta',
    'Suti',
    'Boxer',
    'Viatu',
  ];
    
    widget.model.fetchProductCategory('Tisheti',);
    widget.model.fetchProducts();

    setState(() {
      selectedButton = men[0];
    });

    super.initState();
    //_tabController = PageController();
  }

  //when tab is selected
  void onItemSelected(int page) {
    //_tabController.jumpToPage(page);
  }

  Widget _buildCategoryBtns() {
    return ListView.builder(
      itemBuilder: _buildButtonItem,
      itemCount: men.length,
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
                child: Text(men[index]),
                onPressed: () {
                  //model.autoAuthenticate();>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                  _onChanged(men[index]);
                  setState(() {
                    widget.model.fetchProductCategory(men[index]);
                    widget.model.fetchProducts();
                  });
                },
                color: men[index] == selectedButton
                    ? _selectedColor
                    : _colors, //specify background color  of button from our list of colors
              ),
            )); //products is a getter method...
      },
    );
     }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: _buildCategoryBtns(),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  color: Colors.white,
                  child: Products(),
                ),
              ],
            ),
    ),
       )
     ;
   }
  

  _onChanged(button) {
    //update with a new color when the user taps button
    setState(() {
      selectedButton = button;
    });
  }

  void btnForAGivenTab() {
    setState(() {
          selectedButton = men[0]; //to solve problem of color
        });
    
  }

}
