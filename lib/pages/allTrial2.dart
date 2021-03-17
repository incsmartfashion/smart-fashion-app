import 'package:fashiondada/models/product.dart';
import 'package:fashiondada/widgets/products/product_card.dart';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:fashiondada/scoped-models/main.dart';

class AllTrial2 extends StatefulWidget {
  final MainModel model;
  AllTrial2(this.model);
  @override
  _AllTrial createState() => _AllTrial();
}

class _AllTrial extends State<AllTrial2> {

  @override
  void initState()  { 
    widget.model.fetchProductCategory2('zawadi',);
    widget.model.fetchProducts2();
    super.initState();
    
  }
  Widget _buildProductsGridView(List<Product> products) {
    Widget productCards;
    if (products.length > 0) {
      productCards = ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: widget.model.allProducts2.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductCard(products[index],2);
          },
          separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 5,),
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
    if (model.displayedProducts2.length > 0 && !model.isLoading2) {
      //we have  products&not loading..
      content = _buildProductsGridView(model.displayedProducts2);
    } else if (model.isLoading2) {
      content = Center(
        child: CircularProgressIndicator(),
      );
    }
    return RefreshIndicator(
      onRefresh: model.fetchProducts2,
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

