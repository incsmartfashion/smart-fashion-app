import 'package:fashiondada/models/product.dart';
import 'package:fashiondada/widgets/products/product_card.dart';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:fashiondada/scoped-models/main.dart';

class AllTrial3 extends StatefulWidget {
  final MainModel model;
  AllTrial3(this.model);
  @override
  _AllTrial createState() => _AllTrial();
}

class _AllTrial extends State<AllTrial3> {

  @override
  void initState()  { 
    widget.model.fetchProductCategory3('saa',);
    widget.model.fetchProducts3();
    super.initState();
    
  }

  
  Widget _buildProductsGridView(List<Product> products) {

    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          Widget productCards;
    if (products.length > 0) {
      productCards = ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: model.allProducts3.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductCard(products[index],3);
          },
          separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 5,),
        );

    } else {
      productCards = Container();
    }
    return productCards;

        });

  }

  //displaying a loading spinner
  Widget _displayProducts(MainModel model) {
    Widget content = Center(
      child: Text('no network.connect to the internent..'),
    );
    if (model.displayedProducts3.length > 0 && !model.isLoading3) {
      //we have  products&not loading..
      content = _buildProductsGridView(model.displayedProducts3);
    } else if (model.isLoading3) {
      content = Center(
        child: CircularProgressIndicator(),
      );
    }
    return RefreshIndicator(
      onRefresh: model.fetchProducts3,
      child: content,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (
        //acquiring data from productModel using
        BuildContext context, //scope model package imported...
        Widget child, //whenever data changes all these code gets excuted..
        MainModel model,
      ) {
        return _displayProducts(model); 
      },
    );
  }
}









