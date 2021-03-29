import 'package:flutter/material.dart';
import 'dart:io';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/helpers/ensure_visible.dart';
import '../widgets/form_inputs/image.dart';
import '../models/product.dart';
import '../scoped-models/main.dart';

class ProductEditPage extends StatefulWidget {
  final MainModel model;
  final String updateProductCategory;
  final bool dispalayCategory;
  ProductEditPage(this.model,{this.updateProductCategory, this.dispalayCategory = true});
  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': null,
    'phoneNumber': null
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _titleTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  final _priceTextController = TextEditingController();
  final _phoneNumberTextController = TextEditingController();

  Widget _buildTitleTextField(Product product) {
    if (product == null && _titleTextController.text.trim() == '') {
      _titleTextController.text = '';
    } else if (product != null && _titleTextController.text.trim() == '') {
      _titleTextController.text = product.title;
    } else if (product != null && _titleTextController.text.trim() != '') {
      _titleTextController.text = _titleTextController.text;
    } else if (product == null && _titleTextController.text.trim() != '') {
      _titleTextController.text = _titleTextController.text;
    } else {
      _titleTextController.text = '';
    }
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        decoration: InputDecoration(labelText: 'Eneo'),
        controller: _titleTextController,
        // initialValue: product == null ? '' : product.title,
        validator: (String value) {
          // if (value.trim().length <= 0) {
          if (value.isEmpty || value.length < 3) {
            return 'Jaza Eneo.';
          }
          return null;
        },
        onSaved: (String value) {
          _formData['title'] = value;
        },
      ),
    );
  }

  Widget _buildDescriptionTextField(Product product) {
    if (product == null && _descriptionTextController.text.trim() == '') {
      _descriptionTextController.text = '';
    } else if (product != null &&
        _descriptionTextController.text.trim() == '') {
      _descriptionTextController.text = product.description;
    }
    return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusNode,
      child: TextFormField(
        focusNode: _descriptionFocusNode,
        maxLines: 4,
        decoration: InputDecoration(labelText: 'Maelezo ya Bidhaa'),
        // initialValue: product == null ? '' : product.description,
        controller: _descriptionTextController,
        validator: (String value) {
          // if (value.trim().length <= 0) {
          if (value.isEmpty || value.length < 4) {
            return 'Elezea Bidhaa yako.';
          }
          return null;
        },
        onSaved: (String value) {
          _formData['description'] = value;
        },
      ),
    );
  }

  Widget _buildPriceTextField(Product product) {
    if (product == null && _priceTextController.text.trim() == '') {
      _priceTextController.text = '';
    } else if (product != null && _priceTextController.text.trim() == '') {
      _priceTextController.text = product.price.toString();
    }
    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
        focusNode: _priceFocusNode,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'Bei ya Bidhaa tshs'),
        controller: _priceTextController,
        //initialValue: product == null ? '' : product.price.toString(),
        validator: (String value) {
          // if (value.trim().length <= 0) {
          if (value.isEmpty ||
              value.length > 7 || //bei kubwa milion 9
              !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
            return 'Jaza Bei.';
          }
          return null;
        },
        onSaved: (String value) {
          _formData['price'] = double.parse(value);
        },
      ),
    );
  }

  Widget _buildPhoneNumberTextField(Product product) {
    if (product == null && _phoneNumberTextController.text.trim() == '') {
      _phoneNumberTextController.text = '';
    } else if (product != null &&
        _phoneNumberTextController.text.trim() == '') {
      _phoneNumberTextController.text = product.phoneNumber; //.toString()
    }
    return EnsureVisibleWhenFocused(
      focusNode: _phoneNumberFocusNode,
      child: TextFormField(
        focusNode: _phoneNumberFocusNode,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelText: 'Nambari Ya Simu'),
        controller: _phoneNumberTextController,
        //initialValue: product == null ? '' : product.price.toString(),
        validator: (String value) {
          // if (value.trim().length <= 0) {
          if (value.isEmpty || value.length != 10 || !value.startsWith("0")
              /*!RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)*/) {
            return 'Jaza Nambari ya Simu.';
          }
          return null;
        },
        onSaved: (String value) {
          _formData['phoneNumber'] = value; //int.parse(value)
        },
      ),
    );
  }

  ////////////////////////////////////////////////////////////////////////////////
  ///I DDONT KNOW THE LOGIC BUT THE OUTPUT IS CORRECT
  String saveToGivenCategory;
  bool saveToGivenCategoryController = true;
  bool error = true;

  List<Company> _companies = Company.getHomeCat;
  List<Company> _companies1 = Company.getWomenCat;
  List<Company> _companies2 = Company.getMenCat;
  //**********/
  List<DropdownMenuItem<Company>> _dropdownMenuItems;
  List<DropdownMenuItem<Company>> _dropdownMenuItems1;
  List<DropdownMenuItem<Company>> _dropdownMenuItems2;
  //**********/
  Company _selectedCompany;
  Company _selectedCompany1;
  Company _selectedCompany2;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    ////////////////////////////
    _dropdownMenuItems1 = buildDropdownMenuItems(_companies1);
    _selectedCompany1 = _dropdownMenuItems1[0].value;
    ////////////////////////
    _dropdownMenuItems2 = buildDropdownMenuItems(_companies2);
    _selectedCompany2 = _dropdownMenuItems2[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
      saveToGivenCategory = selectedCompany.name;
    });
  }

  onChangeDropdownItem1(Company selectedCompany) {
    setState(() {
      _selectedCompany1 = selectedCompany;
      saveToGivenCategory = selectedCompany.name;
    });
  }

  onChangeDropdownItem2(Company selectedCompany) {
    setState(() {
      _selectedCompany2 = selectedCompany;
      saveToGivenCategory = selectedCompany.name;
    });
  }

  Widget _dropdownMenu(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            saveToGivenCategoryController
                ? Text("Chagua Kundi")
                : (error
                    ? Text(
                        "Sahihisha Kundi..!",
                        style: TextStyle(color: Colors.greenAccent),
                      )
                    : Text("Imehifadhiwa")),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                DropdownButton(
                  value: _selectedCompany,
                  items: _dropdownMenuItems,
                  onChanged: onChangeDropdownItem,
                ),

                // SizedBox(
                //   width: 5.0,
                // ),
                DropdownButton(
                  value: _selectedCompany1,
                  items: _dropdownMenuItems1,
                  onChanged: onChangeDropdownItem1,
                ),

                // SizedBox(
                //   child: Container(color:Colors.red),
                //   width: 5.0,
                // ),
                DropdownButton(
                  value: _selectedCompany2,
                  items: _dropdownMenuItems2,
                  onChanged: onChangeDropdownItem2,
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }

////////////////*************SUBMIT BUTTON****************//////////
  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(child: CircularProgressIndicator())
            : RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                color: Color(0XFFFEE440),
                child: Text(
                  'Weka Bidhaa',
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                ),
                textColor: Colors.black, //'/products'
                onPressed: () {
                  //refining the categories
                  print(saveToGivenCategory);
                  print('Savetttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt');
                  print(widget.updateProductCategory);
                  if (saveToGivenCategory == "ALL" ||//kote
                      saveToGivenCategory == "MEN" ||//
                      saveToGivenCategory == "WOMEN" ||
                      (saveToGivenCategory == null && widget.updateProductCategory == null)) {
                    /****DO NOTHING******/
                    setState(() {
                      saveToGivenCategoryController = false;
                      error=true;//......................................
                    });
                  } else if(widget.updateProductCategory != null){
                    // model.setProductCategory(saveToGivenCategory);
                   _submitForm(model.addProduct, model.updateProduct,
                       model.selectProduct, model.selectedProductIndex);
                  }
                  else {
                    setState(() {
                      saveToGivenCategoryController = false;//..................
                      error=false;
                    });
                    model.setProductCategory(saveToGivenCategory);
                    _submitForm(model.addProduct, model.updateProduct,
                        model.selectProduct, model.selectedProductIndex);
                  }
                  // model.setProductCategory(saveToGivenCategory);
                  // _submitForm(model.addProduct, model.updateProduct,
                  //     model.selectProduct, model.selectedProductIndex);
                });
      },
    );
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildPageContent(BuildContext contextbuild, Product product) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    //widget.dispalayCategory=false;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildPhoneNumberTextField(product),
              _buildDescriptionTextField(product),
              _buildPriceTextField(product),
              _buildTitleTextField(
                  product), //title has been changed to location

              SizedBox(
                height: 10.0,
              ),
              SizedBox(height: 10.0),
              ImageInput(_setImage, product),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Divider(),
              widget.dispalayCategory == true
                  ? _dropdownMenu(context)
                  : Container(),
              SizedBox(
                height: 20.0,
              ),
              _buildSubmitButton(),
              SizedBox(
                height: 20.0,
              ),
              FloatingActionButton(
                backgroundColor: Colors.blue,
                child: Text("Logout"),
                onPressed:(){
                 widget.model.logout();
            Navigator.pushReplacementNamed(context, '/homescreen');
              }
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setImage(File image) {
    _formData['image'] = image;
  }

//adding or updating product
  void _submitForm(
      Function addProduct, Function updateProduct, Function setSelectedProduct,
      [int selectedProductIndex]) {
    //if not validated or no image is present and product is not selected quit
    if (!_formKey.currentState.validate() ||
        (_formData['image'] == null && selectedProductIndex == -1)) {
      return;
    }
    _formKey.currentState.save();
    if (selectedProductIndex == -1) {
      addProduct(
              _titleTextController.text, //location
              _descriptionTextController.text,
              _formData['image'],
              double.parse(_priceTextController.text),
              _phoneNumberTextController.text)
          .then((bool success) {
        if (success) {
          Navigator.pushReplacementNamed(context, '/homescreen') //'/products'
              .then((_) => setSelectedProduct(null));
          //Navigator.of(context).pop();
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Something went wrong...'),
                  content: Text('check network connection and try again!'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Okay'),
                    )
                  ],
                );
              });
        }
      });
    } else {
      updateProduct(
              _titleTextController.text,
              _descriptionTextController.text,
              _formData['image'],
              double.parse(_priceTextController.text),
              _phoneNumberTextController.text,
              widget.updateProductCategory)
          .then((bool success) async {
        //acheni masihala>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        if (success) {
          Navigator.of(context).pop();
          await Future.delayed(
              Duration(milliseconds: 500), () => setSelectedProduct(null));
        }
      }); //.then((bool success) {
      //if(success){
      //setSelectedProduct(null);
      //}
      //});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent =
            _buildPageContent(context, model.selectedProduct);
        return model.selectedProductIndex == -1
            ? pageContent
            : Scaffold(
                body: WillPopScope(
                    onWillPop: () {
                      //kama unavyoona...
                      Navigator.pop(context, false);
                      model.selectProduct(null);
                      return Future.value(false);
                    },
                    child: Scaffold(
                      appBar: AppBar(
                        iconTheme: IconThemeData(color: Colors.black),
                        backgroundColor: Colors.grey[200],
                        title: Text(
                          'Badili Maelezo',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      body: pageContent,
                    )));
      },
    );
  }
}

////No AY OUT THE WORK HAS TO BE COMPLETED
class Company {
  String name;

  Company(this.name);

  static List<Company> getHomeCat = <Company>[
    Company('ALL'),
    Company('computer'),
    Company('accessories'),
    Company('zawadi'),
    Company('saa'),
    Company('simu'),
    Company('vipodozi'),
  ];

  static List<Company> getWomenCat = <Company>[
    //start with small letters
    Company('WOMEN'),
    Company('Nywele'),
    Company('Urembo'),
    Company('Vitenge'),
    Company('Suruali'),
    Company('Mikoba'),
    Company('Magauni'),
    Company('Suti'),
    Company('Chupi'),
    Company('Viatu'),
    Company('Sweta'),
    Company('Sketi'),
    Company('Blauzi'),
  ];

  static List<Company> getMenCat = <Company>[
    //start with capital letters
    Company('MEN'),
    Company('Tisheti'),
    Company('Suruali'),
    Company('Mashati'),
    Company('Bukta'),
    Company('Suti'),
    Company('Boxer'),
    Company('Viatu'),
  ];
}
