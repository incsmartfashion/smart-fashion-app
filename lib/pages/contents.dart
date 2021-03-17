import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';
import '../widgets/products/products.dart';

class ContentsPage extends StatefulWidget {
  final MainModel model;
  final int selectedTab;
  ContentsPage(this.model,this.selectedTab);
  @override
  State<StatefulWidget> createState() {
    return _ContentsPageState();
  }
}

class _ContentsPageState extends State<ContentsPage>
with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  int _currentIndex = 0; 
  List<Widget> _listOfPhotoWidgets; //final removed
  PageController _tabController;
  /*for the buttons*/
  Color _colors = Colors.grey;
  Color _selectedColor = Colors.pink[200];
  String selectedButton;
  String buttons;
  String fetchProductCategory;
  List<String> menus;

  final List<String> women = [
    'jeans',
    'nywele',
    'vitenge/\nmishono',
    'suruali',
    'mikoba',
    'magauni',
    'suti',
    'nguo za\n ndani',
    'viatu',
    'makoti/\nmasweta',
    'sketi/\nblauzi',
  ];
  final List<String> men = [
    'Jeans',
    'Mashati',
    'Suruali/Kadeti',
    'Suti/\nMakoti',
    'Nguo za\n ndani',
    'Viatu vya\n ngozi',
  ];
  final List<String> all = [
    'saa',
    'urembo',
    'matisheti',
    'raba',
    'bukta',
    'mabegi',
    'perfume',
    'lotion',
    'vipodozi',
  ];

  @override
  initState() {
    menus = [
      'saa',
    'urembo',
    'matisheti',
    'raba',
    'bukta',
    'mabegi',
    'perfume',
    'lotion',
    'vipodozi',
    ];
    //fetch retuns null
    widget.model.fetchProductCategory('saa',);
    widget.model.fetchProducts();

    setState(() {
      selectedButton = menus[0];
    });
    //displaying the products according to the tab chosen
    _listOfPhotoWidgets = [
      Products(), // list of pictures
      Products(),
      Products(),
    ];
    super.initState();
    _tabController = PageController();
  }

  //when tab is selected
  void onItemSelected(int page) {
    _tabController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //body: _buildProductsList(),//Products(),
        body: PageView(
          onPageChanged: onTabTapped,
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  color: Colors.white,
                  child: _buildCategoryBtns(),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  color: Colors.white,
                  child: _listOfPhotoWidgets[0],
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  color: Colors.white,
                  child: _buildCategoryBtns(),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  color: Colors.white,
                  child: _listOfPhotoWidgets[1],
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  color: Colors.white,
                  child: _buildCategoryBtns(),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  color: Colors.white,
                  child: _listOfPhotoWidgets[2],
                ),
              ],
            ), //row3
          ],
        ), //_children[_currentIndex]   CategoryButton()
        //bottom navigation
);
  }

  //knowing what tab is chosen
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _tabController.jumpToPage(index);
      //displaying products according to the tab selected
      if (index == 0) {
         widget.model.fetchProductCategory(all[0]);
         widget.model.fetchProducts();
      } else if (index == 1) {
        widget.model.fetchProductCategory(women[0]);
        widget.model.fetchProducts();
      } else if (index == 2) {
        widget.model.fetchProductCategory(men[0]);
        widget.model.fetchProducts();
      }
    });
    btnForAGivenTab();
  }

  /////////////////////////////////////////////////////////////////////
  ///BUTTON
  _onChanged(button) {
    //update with a new color when the user taps button
    setState(() {
      selectedButton = button;
    });
  }

  //putting category buttons according to the tab chosen
  
  void btnForAGivenTab() {
    switch (_currentIndex) {
      case 0:
        setState(() {
          menus = all;
          selectedButton = menus[0]; //to solve problem of color
        });
        break;
      case 1:
        setState(() {
          menus = women;
          selectedButton = menus[0]; //to solve problem of color
        });
        break;
      case 2:
        setState(() {
          menus = men;
          selectedButton = menus[0]; //to solve problem of color
        });
        break;
      default:
        setState(() {
          menus = all;
          selectedButton = menus[0]; //to solve problem of olor
        });
        break;
    }
  }

  //creating buttons according to the tab chosen
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
                child: Text(menus[index]),
                onPressed: () {
                  //model.autoAuthenticate();>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                  _onChanged(menus[index]);
                  setState(() {
                    widget.model.fetchProductCategory(menus[index]);
                    widget.model.fetchProducts();
                  });
                },
                color: menus[index] == selectedButton
                    ? _selectedColor
                    : _colors, //specify background color  of button from our list of colors
              ),
            )); //products is a getter method...
      },
    );
  }

  Widget _buildCategoryBtns() {
    return ListView.builder(
      itemBuilder: _buildButtonItem,
      itemCount: menus.length,
    );
  }
}
