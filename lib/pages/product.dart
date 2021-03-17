import 'dart:async';
import 'package:fashiondada/scoped-models/main.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  final MainModel model;
  ProductPage(this.product,this.model);
  @override
  State<StatefulWidget> createState() {
    return _ProductPageState();
  }
}

class _ProductPageState extends State<ProductPage> {
  int _current = 0;
  //calling widget
  Widget _launchCallButton() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('wasiliana na muuzaji',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black)),

          CircleAvatar(
            backgroundColor: Colors.transparent,
            child:IconButton(
            icon: Icon(Icons.call),
            color: Colors.green,
            onPressed: _launchURL,
          )
          ),
                  
          CircleAvatar(
            backgroundColor:Colors.transparent,
            child:IconButton(
            icon: Icon(Icons.message),
            color: Colors.blue,
            onPressed:(){

           if(widget.product.phoneNumber.startsWith("+255")){
           FlutterOpenWhatsapp.sendSingleMessage("${widget.product.phoneNumber}",  
            "*Smart Fashion* Nahitaji Bidhaa... ");//widget.product.phoneNumber
           }else{
             FlutterOpenWhatsapp.sendSingleMessage("+255"+"${widget.product.phoneNumber.substring(1)}", "*Smart Fashion* Nahitaji Bidhaa...");
           }
           widget.model.countCalls('watsapp');
    
            },
          )
          )
        ]);
  }

  _launchURL() async {
    final url = 'tel:${widget.product.phoneNumber}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
    widget.model.countCalls('phone');
  }

  Widget _buildProductDescription() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Text(
        "${widget.product.description}",
        style: TextStyle(fontSize: 15.0),
      ),
    );
  }

  Widget _buildProductPrice() {
    return Container(
      child: Text(
        "price: ${widget.product.price} tshs",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
                           
  Widget _buildProductLocation() {
    //title field has been changed to location although algorithms simply know title
    return Container(
      child: Text(
        "Location: ${widget.product.title}", //title corresponds to location algorithmically
        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15.0),
      ),
    );
  }
    
  @override
  Widget build(BuildContext context) {
    String imageUrl = widget.product.image;

    List imgList = [imageUrl, imageUrl, imageUrl];

    //for the three dots
    List<T> map<T>(List list, Function handler) {
      List<T> result = [];
      for (var i = 0; i < list.length; i++) {
        result.add(handler(i, list[i]));
      }
      return result;
    }

    return WillPopScope(
        onWillPop: () {        
          Navigator.pop(context, false);
          return Future.value(false);
          
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[200],
            title: Text(
              "DETAILS",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            centerTitle: true,
          ),
          body: Container(
            color: Colors.grey[200],
            child: Column(
              children: <Widget>[
                Card(
                  child: Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CarouselSlider(
                          height: MediaQuery.of(context).size.height*0.45,//250.0
                          initialPage: 0,
                          enlargeCenterPage: true,
                          autoPlay: false,
                          reverse: false,
                          onPageChanged: (index) {
                            setState(() {
                              _current = index;
                            });
                          },
                          items: imgList.map((imgUrl) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,//
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                  ),
                                  child:
                                      Image.network(imgUrl, fit: BoxFit.fill),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: map<Widget>(imgList, (index, url) {
                            return Container(
                              width: 10.0,
                              height: 10.0,
                              margin: EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 2.0,
                              ),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _current == index
                                      ? Colors.redAccent
                                      : Colors.green),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child:ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                    Center(
                      child: _buildProductPrice(),
                    ),
                     Center(
                      child: _buildProductDescription(),
                    ),
                    Center(
                      child: _buildProductLocation(),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Center(
                      child: _launchCallButton(),
                    ),
                  ])
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
