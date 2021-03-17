import 'package:fashiondada/scoped-models/main.dart';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import '../../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productCategory;

  ProductCard(this.product,[this.productCategory]);

  Widget _buildProductPrice() {
    return Text(
      '${product.price.toString()}/=',
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

                                                                           
  Widget _buildProductImage() {
    return Image.network(
      product.image,
      fit: BoxFit.cover,
    );
  }



  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return GestureDetector(
        //modify the look now...
        onTap: () {
            model.selectProduct(product.id); 
            /*navigate according to the list of productssssss*/
            if(productCategory == null){//normal flow for men and women
            Navigator.pushNamed<bool>(context, '/product/'+ product.id+'/normalFlow/')
          .then((_) {
          model.selectProduct(null);
          });
            }
            if(productCategory == 0){
          Navigator.pushNamed<bool>(context, '/product/'+ product.id +'/0/')
           .then((_) {
            model.selectProduct(null);
          });
            }
            else if(productCategory == 1){
            Navigator.pushNamed<bool>(context, '/product/'+ product.id +'/1/')
          .then((_) {
          model.selectProduct(null);
          });
            }
            else if(productCategory == 2){
          Navigator.pushNamed<bool>(context, '/product/'+ product.id +'/2/')
          .then((_) {
            model.selectProduct(null);
          });
            }
          else if(productCategory == 3){
          Navigator.pushNamed<bool>(context, '/product/'+ product.id +'/3/')
          .then((_) {
            model.selectProduct(null);
          });
            }
            else if(productCategory == 4){
          Navigator.pushNamed<bool>(context, '/product/'+ product.id +'/4/')
          .then((_) {
            model.selectProduct(null);
          });
            }
         else if(productCategory == 5){
          Navigator.pushNamed<bool>(context, '/product/'+ product.id +'/5/')
          .then((_) {
            model.selectProduct(null);
          });
            }
        },
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAlias,
           child:Column(
                    children: <Widget>[
                      Container(height:100,
                      child: _buildProductImage(),),
                      
                      SizedBox(height: 10,),
                      _buildProductPrice()
                    ],
                  ),
        ),
      );
    });
  }
}