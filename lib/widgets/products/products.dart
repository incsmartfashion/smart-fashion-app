import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import '../../models/product.dart';
import './product_card.dart';
import 'package:fashiondada/scoped-models/main.dart';

class Products extends StatelessWidget {

  Widget _buildProductsGridView(List<Product> products) {
    Widget productCards;
    if (products.length > 0) {
      productCards = GridView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ProductCard(products[index]),
        itemCount: products.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      );
    } else {
      productCards = Container();
    }
    return productCards;
  }
  //displaying a loading spinner
  Widget _displayProducts(MainModel model) {
    Widget content = Center(
      child: Text('no network.connect to the internent..'),
    );
    if (model.displayedProducts.length > 0 && !model.isLoading) {
      //we have  products&not loading..
      content = _buildProductsGridView(model.displayedProducts);
    } else if (model.isLoading) {
      content = Center(
        child: CircularProgressIndicator(),
      );
    }
    return RefreshIndicator(
      onRefresh: model.fetchProducts,
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
