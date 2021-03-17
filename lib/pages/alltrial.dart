import 'package:fashiondada/models/product.dart';
import 'package:fashiondada/widgets/products/product_card.dart';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:fashiondada/scoped-models/main.dart';

class AllTrial extends StatefulWidget {
  final MainModel model;
  AllTrial(this.model);
  @override
  _AllTrial createState() => _AllTrial();
}

class _AllTrial extends State<AllTrial> {

  @override
  void initState()  {
    widget.model.fetchProductCategory('computer',);
    widget.model.fetchProducts();
    super.initState();
    
  }
  Widget _buildProductsGridView(List<Product> products) {
    Widget productCards;
    if (products.length > 0) {
      productCards = ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: widget.model.allProducts.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductCard(products[index],0);
            // Card(
            //     semanticContainer: true,
            //     clipBehavior: Clip.antiAlias,
            //     child:Column(
            //         children: <Widget>[
            //           Image.network(products[index].image,height: 110,fit: BoxFit.fitWidth,),
            //           SizedBox(height: 10,),
            //           Text('${products[index].price}')
            //         ],
            //       ),
            // );
          
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

// import 'package:fashiondada/models/product.dart';
// import 'package:flutter/material.dart';

// import 'package:scoped_model/scoped_model.dart';
// import 'package:fashiondada/scoped-models/main.dart';

// class AllTrial extends StatelessWidget {
//   final MainModel model;
//   AllTrial(this.model);
//   Widget _buildProductsGridView(List<Product> products) {
//     Widget productCards;
//     if (products.length > 0) {
//       productCards = ListView.separated(
//           scrollDirection: Axis.horizontal,
//           itemCount: model.allProducts.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Card(
//                 semanticContainer: true,
//                 clipBehavior: Clip.antiAlias,
//                 child:Column(
//                     children: <Widget>[
//                       Image.network(products[index].image,height: 110,fit: BoxFit.fitWidth,),
//                       SizedBox(height: 10,),
//                       Text('${products[index].price}')
//                     ],
//                   ),
//             );
          
//           },
//           separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 5,),
//         );

//     } else {
//       productCards = Container();
//     }
//     return productCards;
//   }

//   //displaying a loading spinner
//   Widget _displayProducts(MainModel model) {
//     Widget content = Center(
//       child: Text('no network.connect to the internent..'),
//     );
//     if (model.displayedProducts.length > 0 && !model.isLoading) {
//       //we have  products&not loading..
//       content = _buildProductsGridView(model.displayedProducts);
//     } else if (model.isLoading) {
//       content = Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//     return RefreshIndicator(
//       onRefresh: model.fetchProducts,
//       child: content,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<MainModel>(
//       builder: (
//         //acquiring data from productModel using
//         BuildContext context, //scope model package imported...
//         Widget child, //whenever data changes all these code gets excuted..
//         MainModel model,
//       ) {
//         return _displayProducts(model); 
//       },
//     );
//   }
// }

