import 'package:fashiondada/scoped-models/main.dart';
import 'package:flutter/material.dart';

import './product_edit.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatefulWidget {
  final MainModel model;
  ProductListPage(this.model);
  @override
  State<StatefulWidget> createState() {
    return _ProductListPage();
  }
}

class _ProductListPage extends State<ProductListPage>
    with AutomaticKeepAliveClientMixin<ProductListPage> {
  @override
  initState() {
    //method that fetches data for a given seller
    widget.model.fetchProductsForSeller();
    super.initState();
  }

  Widget _buildEditButton(BuildContext context, int index, MainModel model) {
    return Container(
      child:IconButton(
      icon: Icon(Icons.delete_sweep),
      onPressed: () {
        //set the category by which the product will be updated...100 ways
        model.selectProduct(model.allProducts[index].id);
        model.deleteProduct(model.allProducts[index].productCategory);
        model.selectProduct(model.allProducts[index].id);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              //passing the category required to update the product on database

              return ProductEditPage( model,
                  updateProductCategory:
                      (model.allProducts[index].productCategory));
            },
          ),
        
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(builder: (
      BuildContext context,
      Widget child,
      MainModel model,
    ) {
      //is it loading
      return //model.isLoading
          //?
//return refresh indicator
          //Center(
            //  child: CircularProgressIndicator(),
            //)
          //:
          //it is not loading
          //products are present and done fetching data
          //((model.displayedProducts.length > 0 && !model.isLoading)
              /*?*/ ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            model.selectProduct(model.allProducts[index].id);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  //passing the category required to update the product on database

                                  return ProductEditPage(model,
                                      updateProductCategory: (model
                                          .allProducts[index].productCategory),dispalayCategory: false,);
                                },
                              ),
                            );
                          },
                          child: 
                        Dismissible(
                          key: Key(model.allProducts[index].title),//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                          onDismissed: (DismissDirection direction) {
                            if (direction == DismissDirection.endToStart ||
                                direction == DismissDirection.startToEnd) {
                              model.selectProduct(model.allProducts[index].id);
                              model.deleteProduct(
                                  model.allProducts[index].productCategory);
                                  
                            }
                          },
                          background: Container(color: Colors.green[300]),
                          child: ListTile(
                             leading: CircleAvatar(
                               backgroundImage:
                                   NetworkImage(model.allProducts[index].image),
                             ),
                            //title: Text(model.allProducts[index].title),//location
                            subtitle: Text(
                                'Tshs ${model.allProducts[index].price.toString()}'),//
                            trailing:
                            _buildEditButton(context, index, model)
                          ),
                        ),
                        ),
                        Divider(),
                      ],
                    );
                  },
                  itemCount: model.allProducts.length,
                );//>>;
              //: //no products and done fetching data
              //Center(
                //  child: Text('no products posted..'),
                //));
    });
  }

//keep the tab alive
  @override
  bool get wantKeepAlive => true;
}
