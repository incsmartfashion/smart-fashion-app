import 'dart:convert'; //encoding or decoding data
import 'dart:async'; //one thing at a time
import 'dart:io'; //file system
import 'package:scoped_model/scoped_model.dart'; //passes reactive model to children
import 'package:rxdart/subjects.dart'; // btn selected other deactivates
import 'package:http/http.dart' as http; //http requests
import 'package:http_parser/http_parser.dart'; //data formatting
import 'package:shared_preferences/shared_preferences.dart'; //storing data
import 'package:mime/mime.dart'; //mime type of files
import '../models/auth.dart';
import '../models/product.dart';
import '../models/user.dart';

//file of products for a given user
mixin ConnectedProductsModel on Model {
  List<Product> _products = []; //list of products posted by authenticated user
  List<Product> _products1 = [];
  List<Product> _products2 = [];
  List<Product> _products3 = [];
  List<Product> _products4 = [];
  List<Product> _products5 = [];
  String _selProductId; //selected product id

  User _authenticatedUser;
  bool _isLoading = false; //loader is off
  bool _isLoading1 = false; //loader is off
  bool _isLoading2 = false;
  bool _isLoading3 = false;
  bool _isLoading4 = false;
  bool _isLoading5 = false;
}

mixin ProductsModel on ConnectedProductsModel {
  bool _showFavorites = false; //favorites are not shown

  //returning copy of the list called all products
  List<Product> get allProducts {
    return List.from(_products);
  }
    List<Product> get allProducts1 {
    return List.from(_products1);
  }
    List<Product> get allProducts2 {
    return List.from(_products2);
  }
    List<Product> get allProducts3 {
    return List.from(_products3);
  }
    List<Product> get allProducts4 {
    return List.from(_products4);
  }
    List<Product> get allProducts5 {
    return List.from(_products5);
  }

  //send product in a given category in database
  String _productCategory;
  //method to specify a category of a product to be added in data base
  void setProductCategory(String productCategoryChosen) {
    if(productCategoryChosen != null){
      _productCategory = productCategoryChosen.replaceAll('/','').replaceAll('\n','')
    .replaceAll(' ','');
    }
  }//send product in a given category in database

  String _fetchProductCategory;
  String _fetchProductCategory1;
  String _fetchProductCategory2;
  String _fetchProductCategory3;
  String _fetchProductCategory4;
  String _fetchProductCategory5;
  //mmethod to specify a category of a product to be added in data base
  void fetchProductCategory(String fetchProductCategory) {
    if(fetchProductCategory != null){
    _fetchProductCategory = fetchProductCategory.replaceAll('/','').replaceAll('\n','')
    .replaceAll(' ','');
    }
  }
    void fetchProductCategory1(String fetchProductCategory) {
    if(fetchProductCategory != null){
    _fetchProductCategory1 = fetchProductCategory.replaceAll('/','').replaceAll('\n','')
    .replaceAll(' ','');
    }
  }
      void fetchProductCategory2(String fetchProductCategory) {
    if(fetchProductCategory != null){
    _fetchProductCategory2 = fetchProductCategory.replaceAll('/','').replaceAll('\n','')
    .replaceAll(' ','');
    }
  }
      void fetchProductCategory3(String fetchProductCategory) {
    if(fetchProductCategory != null){
    _fetchProductCategory3 = fetchProductCategory.replaceAll('/','').replaceAll('\n','')
    .replaceAll(' ','');
    }
  }
      void fetchProductCategory4(String fetchProductCategory) {
    if(fetchProductCategory != null){
    _fetchProductCategory4 = fetchProductCategory.replaceAll('/','').replaceAll('\n','')
    .replaceAll(' ','');
    }
  }
      void fetchProductCategory5(String fetchProductCategory) {
    if(fetchProductCategory != null){
    _fetchProductCategory5 = fetchProductCategory.replaceAll('/','').replaceAll('\n','')
    .replaceAll(' ','');
    }
  }
  //products being displayed
  List<Product> get displayedProducts {
    //retun favourited products
    /*if (_showFavorites) {
      //displaying favourites
      return _products.where((Product product) => product.isFavorite).toList();
    }*/

    //return a copy of products
    return List.from(_products); //displaying all
  }
  List<Product> get displayedProducts1 {
    //retun favourited products
    /*if (_showFavorites) {
      //displaying favourites
      return _products.where((Product product) => product.isFavorite).toList();
    }*/

    //return a copy of products
    return List.from(_products1); //displaying all
  }
    List<Product> get displayedProducts2 {
    //retun favourited products
    /*if (_showFavorites) {
      //displaying favourites
      return _products.where((Product product) => product.isFavorite).toList();
    }*/

    //return a copy of products
    return List.from(_products2); //displaying all
  }
    List<Product> get displayedProducts3 {
    //retun favourited products
    /*if (_showFavorites) {
      //displaying favourites
      return _products.where((Product product) => product.isFavorite).toList();
    }*/

    //return a copy of products
    return List.from(_products3); //displaying all
  }
    List<Product> get displayedProducts4 {
    //retun favourited products
    /*if (_showFavorites) {
      //displaying favourites
      return _products.where((Product product) => product.isFavorite).toList();
    }*/

    //return a copy of products
    return List.from(_products4); //displaying all
  }
   List<Product> get displayedProducts5 {
    //retun favourited products
    /*if (_showFavorites) {
      //displaying favourites
      return _products.where((Product product) => product.isFavorite).toList();
    }*/

    //return a copy of products
    return List.from(_products5); //displaying all
  }

  int get selectedProductIndex {
    print("selected product index");
    //index of the selected product
    return _products.indexWhere((Product product) {
      return product.id == _selProductId;
    });
  }



  String get selectedProductId {
    //id of the selected product
    return _selProductId;
  }


  Product get selectedProduct {
    print("selectedProduct");
    if (selectedProductId == null) {
      return null;
    }
    return _products.firstWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }
  String _userPassword,_userEmail;

   String get userPassword {
    return _userPassword;
  }
  String get userEmail {
    return _userEmail;
  }

    void  fetchEmailPassword() async {//authenticate(userEmail,userPassword,AuthMode.Login);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String  userEmail =  prefs.getString("userEmail");
    final String userPassword = prefs.getString("userPassword");
    print("mmmmmmmmmmmmmmm>>>>>>>>>>>>>>>>>>>>>>>>>>> $userEmail");
    print("mmmmmmmmmmmmmmm>>>>>>>>>>>>>>>>>>>>>>>>>>> $userPassword");
    _userEmail = userEmail;
    _userPassword = userPassword;
    
  }

//uploading image to storage
  Future<Map<String, dynamic>> uploadImage(File image,
      {String imagePath}) async {
    final mimeTypeData =
        lookupMimeType(image.path).split('/'); //image/jpg=>'image' & 'jpg'
    final imageUploadRequest = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://us-central1-fashionmantainance.cloudfunctions.net/storeImage')); 

    final file = await http.MultipartFile.fromPath("image", image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

    imageUploadRequest.files.add(file);
    if (imagePath != null) {
      imageUploadRequest.fields['imagePath'] = Uri.encodeComponent(imagePath);
    }
    imageUploadRequest.headers['Authorization'] =
        'Bearer ${_authenticatedUser.token}';
    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200 && response.statusCode != 201) {
        print('Something went wrong');
        _isLoading =false;//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        print(json.decode(response.body));
        return null;
      }
      final responseData = json.decode(response.body);
      return responseData;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future countCalls(String connection) async {
    // await http.post(
    //      'https://fashionmantainance.firebaseio.com/Connections/PhonecallsConections/.json',
    //      body: json.encode(1));

    if(connection == 'watsapp'){
                  return http
        .get('https://fashionmantainance.firebaseio.com/Connections/WatsappConections.json')
        .then<Map<String, dynamic>>((http.Response response) {
      Map<String,dynamic> currentNumOfCalls = json.decode(response.body);
      currentNumOfCalls.forEach((String id, dynamic number) { 
        print(currentNumOfCalls[id]);
        currentNumOfCalls[id]++;
          http.put(//
          //products
          'https://fashionmantainance.firebaseio.com/Connections/WatsappConections/$id.json', //updating my product data..
          body: json.encode(currentNumOfCalls[id])); //3333
      //here updating is done
      
      });
            return;
        });

    }
    if(connection == 'phone'){
                        return http
        .get('https://fashionmantainance.firebaseio.com/Connections/PhonecallsConections.json')
        .then<Map<String, dynamic>>((http.Response response) {
      Map<String,dynamic> currentNumOfCalls = json.decode(response.body);
      currentNumOfCalls.forEach((String id, dynamic number) { 
        print(currentNumOfCalls[id]);
        currentNumOfCalls[id]++;
          http.put(//
          //products
          'https://fashionmantainance.firebaseio.com/Connections/PhonecallsConections/$id.json', //updating my product data..
          body: json.encode(currentNumOfCalls[id])); //3333
      //here updating is done
      
      });
            return;
        });
    }
  }

  //storing information in the data base
  Future<bool> addProduct(
      String title, String description, File image, double price,String phoneNumber) async {
    _isLoading = true; //before sending data
    notifyListeners();
    //upload image
    final uploadData = await uploadImage(image);

    if (uploadData == null) {
      _isLoading = false;//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      print('Upload failed!');
      return false;
    }

    final Map<String, dynamic> productData = {
      'title': title,//location algorithmically
      'description': description,
      'price': price,
      'phoneNumber':phoneNumber,
      "productCategory": _productCategory,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id,
      'imagePath': uploadData['imagePath'],
      'imageUrl': uploadData['imageUrl'],
    };
    try {
      //sending products data to the server
      final http.Response response = await http.post(
          'https://fashionmantainance.firebaseio.com/$_productCategory.json?auth=${_authenticatedUser.token}',
          body: json.encode(productData)); 
      print(_productCategory);
      //handling accessibility before posting data..
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners(); //notify Changes in spinner stopping rotating
        return false;
      }
      //fetching data
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Product newProduct = Product(
          id: responseData['name'], 
          title: title,
          description: description,
          image: uploadData['imageUrl'], 
          imagePath:
              uploadData['imagePath'],
          price: price,
          phoneNumber: phoneNumber,
          productCategory: _productCategory,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);
      _products.add(newProduct);
      _isLoading = false; //data is sent
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false; //data is not sent
      notifyListeners();
      return false;
    }
  } 

  Future<bool> updateProduct(
      String title, String description, File image, double price, String phoneNumber,
       String updateProductCategory) async {
    _isLoading = true;
    notifyListeners();
    String imageUrl = selectedProduct.image;
    String imagePath = selectedProduct.imagePath;
    if (image != null) {
      final uploadData = await uploadImage(image);

      if (uploadData == null) {
        print('Upload failed!');
        return false;
      }
      imageUrl = uploadData['imageUrl'];
      imagePath = uploadData['imagePath'];
    }
    //data to be updated...
    Map<String, dynamic> updateData = {
      //data from user...
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'imagePath': imagePath,
      'price': price,
      'phoneNumber':phoneNumber,
      'productCategory':updateProductCategory,//>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      'userEmail': selectedProduct.userEmail,
      'userId': selectedProduct.userId
    };
    try {
      //updating data to server
      //final http.Response response = 
      
    print("$updateProductCategory updateeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      await http.put(//
          //products
          'https://fashionmantainance.firebaseio.com/$updateProductCategory/${selectedProduct.id}.json?auth=${_authenticatedUser.token}', //updating my product data..
          body: json.encode(updateData)); //3333
      //here updating is done
      _isLoading = false;//.>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      final Product updatedProduct = Product(
          id: selectedProduct.id, //taking id of the existing product...
          title: title,
          description: description,
          image: imageUrl,
          imagePath: imagePath,
          price: price,
          phoneNumber: phoneNumber,
          productCategory: updateProductCategory,
          userEmail: selectedProduct.userEmail,
          userId: selectedProduct.userId,);
      //operating by using Id's
      _products[selectedProductIndex] = updatedProduct; //call by reference
      notifyListeners(); //to be sure of the change
      return true;
    } catch (error) {
      _isLoading = false; //data is sent
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteProduct(String productCategory) {
    _isLoading = true;
    final deletedProductId = selectedProduct.id;
    //operating by using Ids//selectedProductIndex is method referenced by reference.
    _products.removeAt(selectedProductIndex);
    _selProductId = null; //no selected product...
    notifyListeners();
    return http
        .delete(//deleting data to server//products
            'https://fashionmantainance.firebaseio.com/$productCategory/$deletedProductId.json?auth=${_authenticatedUser.token}')
        .then((http.Response response) {
      //done deleting
      _isLoading = false;

      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false; //data is sent
      notifyListeners();
      return false;
    });
  }
   
   /*THE METHOD THAT FETCHES DATA POSTED BY A GIVEN USER*/
   Future<Null> fetchProductsForSeller({onlyForUser = true}) {
     print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    _isLoading = true; //b4 getting data..
    _products = [];
    notifyListeners();
    //token goes to access data with the request of data access
    return printFileContent()
        .then<Null>((Map<String, dynamic> productListData) {
      //5555
      //fetcing the data
      final List<Product> fetchedProductList = [];
      //when there is no data
      if (productListData == null) {
        _isLoading = false; //no need to kep loading
        notifyListeners();
        return;
      }
      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            image: productData['imageUrl'],
            imagePath: productData['imagePath'],
            price: productData['price'],
            productCategory: productData['productCategory'],
            phoneNumber : productData['phoneNumber'],
            userEmail: productData['userEmail'],
            userId: productData['userId'],
            //productCategory : productData['productCategory'],

            isFavorite: productData['wishlistUsers'] == null
                ? false
                : (productData['wishlistUsers'] as Map<String, dynamic>)
                    .containsKey(_authenticatedUser.id));
                    
        fetchedProductList.add(product);
      });

      _products = onlyForUser
          ? fetchedProductList.where((Product product) {
              return product.userId == _authenticatedUser.id;
            }).toList()
          : fetchedProductList;
          print("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
      _isLoading = false; //after getting data.
      notifyListeners();
      _selProductId = null;
      
      return;
    }).catchError((error) {
      print("errrrrrrrrrrrrrrrrrrrrrrrrrrrrror is thereeeeeeeeeeeeeeeeeeeeeeeeee");
      _isLoading = false; 
      notifyListeners();
      return false;
    });
  }
  
      //using the downloaded values{combining all maps}
  Future<Map<String, dynamic>> printFileContent() {
  
    List<String> categories = [
      /*******all*******/
    'computer',
    'accessories',
    'zawadi',
    'saa',
    'simu',
    'vipodozi',
      /****women*****/
    'Nywele',
    'Urembo'
    'Vitenge',
    'Suruali',
    'Mikoba',
    'Magauni',
    'Suti',
    'Chupi',
    'Viatu',
    'Sweta',
    'Sketi',
    'Blauzi'
      /******men*****/
    'Tisheti',
    'Suruali',
    'Mashati',
    'Bukta',
    'Suti',
    'Boxer',
    'Viatu',
    ];

    Map<String, dynamic> allProducts = {};
    Future<Map<String, dynamic>> fileContent;
    categories.forEach( ( f )  {
      f=(f.replaceAll('/','').replaceAll('\n','').replaceAll(' ',''));
      fileContent = downloadFile(f);
      fileContent.then((resultString) {
        if(fileContent == null){print("file content null/////////////////////////////////////////////////");}
        //combining maps of products
        allProducts.addAll(resultString);
      });
    });
    print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
    return fileContent.then((fileContent){
      //print("$allProducts  as you can see>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      return allProducts;
    });
  }

//downloading..........return map for one category
  Future<Map<String, dynamic>> downloadFile(String fetchProductCategory) {
    print("beginsssssssssssssssssssssssssssssssssssssssss");
    return http
        .get('https://fashionmantainance.firebaseio.com/$fetchProductCategory.json?auth=${_authenticatedUser.token}')
        .then<Map<String, dynamic>>((http.Response response) {
          print("beginssssssssssss");
      final Map<String, dynamic> productListData = json.decode(response.body);
       //map of one category...ternary function
       if(productListData == null){
         print("productListData is null    >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> category not in database");
         return productListData;
       }
       //return productListData;
       else{
         print("productListData is NOT NUL    >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> CATEGORY IN DATABASE");
         return productListData;
       }
    }).catchError((onError){
      print("Error has Occurred >>>>>>>>>>>>>>>>>>>>>>>>>>  $onError");
      print("connect to the internent");
    },
    );
  }
  //////////////////////////////////////////////////////////////////////////
/*METHOD TO FETCH PRODUCT FOR CUSTOMER*/
  Future<Null> fetchProducts({onlyForUser = false}) {
    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    _isLoading = true; //b4 getting data..
    _products = [];
    notifyListeners();
    return http //token goes to access data with the request of data access
        .get(//products
            'https://fashionmantainance.firebaseio.com/$_fetchProductCategory.json')//?auth=${_authenticatedUser.token}
        .then<Null>((http.Response response) {
      //5555
      //fetcing the data
      final List<Product> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      //when there is no data
      if (productListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      if (productListData == null) {
        _isLoading = false; //no need to kep loading
        notifyListeners();
        return;
      }
      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
            id: productId,
            title: productData['title'],//location
            description: productData['description'],
            image: productData['imageUrl'],
            imagePath: productData['imagePath'],
            price: productData['price'],
            phoneNumber: productData['phoneNumber'],
            userEmail: productData['userEmail'],
            userId: productData['userId'],
            productCategory : productData['productCategory'],
            isFavorite: productData['wishlistUsers'] == null
                ? false
                : (productData['wishlistUsers'] as Map<String, dynamic>)
                    .containsKey(_authenticatedUser.id));
        fetchedProductList.add(product);
      });
    
      _products = onlyForUser
          ? fetchedProductList.where((Product product) {
              return product.userId == _authenticatedUser.id;
            }).toList()
            //last to be posted first to be seen
          : new List.from(fetchedProductList.reversed);//fetchedProductList;
          
      _isLoading = false; //after getting data..
      notifyListeners();
      _selProductId = null;
      return;
    }).catchError((error) {
      _isLoading = false; //data is sent
      notifyListeners();
      return false;
    });
  }
  /********************************************************/
  Future<Null> fetchProducts1({onlyForUser = false}) {
    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    _isLoading1 = true; //b4 getting data..
    _products1 = [];
    notifyListeners();
    return http //token goes to access data with the request of data access
        .get(//products
            'https://fashionmantainance.firebaseio.com/$_fetchProductCategory1.json')//?auth=${_authenticatedUser.token}
        .then<Null>((http.Response response) {
      //5555
      //fetcing the data
      final List<Product> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      //when there is no data

      if (productListData == null) {
        _isLoading1 = false; //no need to kep loading
        notifyListeners();
        return;
      }
      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
            id: productId,
            title: productData['title'],//location
            description: productData['description'],
            image: productData['imageUrl'],
            imagePath: productData['imagePath'],
            price: productData['price'],
            phoneNumber: productData['phoneNumber'],
            userEmail: productData['userEmail'],
            userId: productData['userId'],
            productCategory : productData['productCategory'],
            isFavorite: productData['wishlistUsers'] == null
                ? false
                : (productData['wishlistUsers'] as Map<String, dynamic>)
                    .containsKey(_authenticatedUser.id));
        fetchedProductList.add(product);
      });
    
      _products1 = onlyForUser
          ? fetchedProductList.where((Product product) {
              return product.userId == _authenticatedUser.id;
            }).toList()
            //last to be posted first to be seen
          : new List.from(fetchedProductList.reversed);//fetchedProductList;
          
      _isLoading1 = false; //after getting data..
      notifyListeners();
      _selProductId = null;
      return;
    }).catchError((error) {
      _isLoading1 = false; //data is sent
      notifyListeners();
      return false;
    });
  }

  Future<Null> fetchProducts2({onlyForUser = false}) {
    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    _isLoading2 = true; //b4 getting data..
    _products2 = [];
    notifyListeners();
    return http //token goes to access data with the request of data access
        .get(//products
            'https://fashionmantainance.firebaseio.com/$_fetchProductCategory2.json')//?auth=${_authenticatedUser.token}
        .then<Null>((http.Response response) {
      //5555
      //fetcing the data
      final List<Product> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      //when there is no data
      if (productListData == null) {
        _isLoading2 = false; //no need to kep loading
        notifyListeners();
        return;
      }
      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
            id: productId,
            title: productData['title'],//location
            description: productData['description'],
            image: productData['imageUrl'],
            imagePath: productData['imagePath'],
            price: productData['price'],
            phoneNumber: productData['phoneNumber'],
            userEmail: productData['userEmail'],
            userId: productData['userId'],
            productCategory : productData['productCategory'],
            isFavorite: productData['wishlistUsers'] == null
                ? false
                : (productData['wishlistUsers'] as Map<String, dynamic>)
                    .containsKey(_authenticatedUser.id));
        fetchedProductList.add(product);
      });
    
      _products2 = onlyForUser
          ? fetchedProductList.where((Product product) {
              return product.userId == _authenticatedUser.id;
            }).toList()
            //last to be posted first to be seen
          : new List.from(fetchedProductList.reversed);//fetchedProductList;
          
      _isLoading2 = false; //after getting data..
      notifyListeners();
      _selProductId = null;
      return;
    }).catchError((error) {
      _isLoading2 = false; //data is sent
      notifyListeners();
      return false;
    });
  }
   
   Future<Null> fetchProducts3({onlyForUser = false}) {
    _isLoading3 = true; //b4 getting data..
    _products3 = [];
    notifyListeners();
    return http //token goes to access data with the request of data access
        .get(//products
            'https://fashionmantainance.firebaseio.com/$_fetchProductCategory3.json')//?auth=${_authenticatedUser.token}
        .then<Null>((http.Response response) {
      //5555
      //fetcing the data
      final List<Product> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      //when there is no data
      if (productListData == null) {
        _isLoading3 = false; //no need to kep loading
        notifyListeners();
        return;
      }
      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
            id: productId,
            title: productData['title'],//location
            description: productData['description'],
            image: productData['imageUrl'],
            imagePath: productData['imagePath'],
            price: productData['price'],
            phoneNumber: productData['phoneNumber'],
            userEmail: productData['userEmail'],
            userId: productData['userId'],
            productCategory : productData['productCategory'],
            isFavorite: productData['wishlistUsers'] == null
                ? false
                : (productData['wishlistUsers'] as Map<String, dynamic>)
                    .containsKey(_authenticatedUser.id));
        fetchedProductList.add(product);
      });
    
      _products3 = onlyForUser
          ? fetchedProductList.where((Product product) {
              return product.userId == _authenticatedUser.id;
            }).toList()
            //last to be posted first to be seen
          : new List.from(fetchedProductList.reversed);//fetchedProductList;
          
      _isLoading3 = false; //after getting data..
      notifyListeners();
      _selProductId = null;
      return;
    }).catchError((error) {
      _isLoading3 = false; //data is sent
      notifyListeners();
      return false;
    });
  }
   
   Future<Null> fetchProducts4({onlyForUser = false}) {
    _isLoading4 = true; //b4 getting data..
    _products4 = [];
    notifyListeners();
    return http //token goes to access data with the request of data access
        .get(//products
            'https://fashionmantainance.firebaseio.com/$_fetchProductCategory4.json')//?auth=${_authenticatedUser.token}
        .then<Null>((http.Response response) {
      //5555
      //fetcing the data
      final List<Product> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      //when there is no data
      if (productListData == null) {
        _isLoading4 = false; //no need to kep loading
        notifyListeners();
        return;
      }
      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
            id: productId,
            title: productData['title'],//location
            description: productData['description'],
            image: productData['imageUrl'],
            imagePath: productData['imagePath'],
            price: productData['price'],
            phoneNumber: productData['phoneNumber'],
            userEmail: productData['userEmail'],
            userId: productData['userId'],
            productCategory : productData['productCategory'],
            isFavorite: productData['wishlistUsers'] == null
                ? false
                : (productData['wishlistUsers'] as Map<String, dynamic>)
                    .containsKey(_authenticatedUser.id));
        fetchedProductList.add(product);
      });
    
      _products4 = onlyForUser
          ? fetchedProductList.where((Product product) {
              return product.userId == _authenticatedUser.id;
            }).toList()
            //last to be posted first to be seen
          : new List.from(fetchedProductList.reversed);//fetchedProductList;
          
      _isLoading4 = false; //after getting data..
      notifyListeners();
      _selProductId = null;
      return;
    }).catchError((error) {
      _isLoading4 = false; //data is sent
      notifyListeners();
      return false;
    });
  }
   
   Future<Null> fetchProducts5({onlyForUser = false}) {
    _isLoading5 = true; //b4 getting data..
    _products5 = [];
    notifyListeners();
    return http //token goes to access data with the request of data access
        .get(//products
            'https://fashionmantainance.firebaseio.com/$_fetchProductCategory5.json')//?auth=${_authenticatedUser.token}
        .then<Null>((http.Response response) {
      //5555
      //fetcing the data
      final List<Product> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      //when there is no data
      if (productListData == null) {
        _isLoading5 = false; //no need to kep loading
        notifyListeners();
        return;
      }
      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
            id: productId,
            title: productData['title'],//location
            description: productData['description'],
            image: productData['imageUrl'],
            imagePath: productData['imagePath'],
            price: productData['price'],
            phoneNumber: productData['phoneNumber'],
            userEmail: productData['userEmail'],
            userId: productData['userId'],
            productCategory : productData['productCategory'],
            isFavorite: productData['wishlistUsers'] == null
                ? false
                : (productData['wishlistUsers'] as Map<String, dynamic>)
                    .containsKey(_authenticatedUser.id));
        fetchedProductList.add(product);
      });
    
      _products5 = onlyForUser
          ? fetchedProductList.where((Product product) {
              return product.userId == _authenticatedUser.id;
            }).toList()
            //last to be posted first to be seen
          : new List.from(fetchedProductList.reversed);//fetchedProductList;
          
      _isLoading5 = false; //after getting data..
      notifyListeners();
      _selProductId = null;
      return;
    }).catchError((error) {
      _isLoading5 = false; //data is sent
      notifyListeners();
      return false;
    });
  }
   
  /***********************************************************/
/*METHOD TO FETCH PRODUCT FOR CUSTOMER BEFORE MODIFICATION*/

    /*Future<Null> fetchProducts({onlyForUser = false}) {
    print(_fetchProductCategory);
    _isLoading = true; //b4 getting data..
    _products = [];
    notifyListeners();
    return http //token goes to access data with the request of data access
        .get(//products
            'https://fashionmantainance.firebaseio.com/$_fetchProductCategory.json?auth=${_authenticatedUser.token}')
        .then<Null>((http.Response response) {
      //5555
      //fetcing the data
      final List<Product> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      //when there is no data
      if (productListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      if (productListData == null) {
        _isLoading = false; //no need to kep loading
        notifyListeners();
        return;
      }
      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            image: productData['imageUrl'],
            imagePath: productData['imagePath'],
            price: productData['price'],
            userEmail: productData['userEmail'],
            userId: productData['userId'],
            isFavorite: productData['wishlistUsers'] == null
                ? false
                : (productData['wishlistUsers'] as Map<String, dynamic>)
                    .containsKey(_authenticatedUser.id));
        fetchedProductList.add(product);
      });
      _products = onlyForUser
          ? fetchedProductList.where((Product product) {
              return product.userId == _authenticatedUser.id;
            }).toList()
          : fetchedProductList;
      _isLoading = false; //after getting data..
      notifyListeners();
      _selProductId = null;
      return;
    }).catchError((error) {
      _isLoading = false; //data is sent
      notifyListeners();
      return false;
    });
  }*/

//toggling between the favourites and the non favourutes

//managing favourite products
  // void toggleProductFavoriteStatus() async {
  //   final bool isCurrentlyFavorite =
  //       selectedProduct.isFavorite; //default status
  //   final bool newFavoriteStatus =
  //       !isCurrentlyFavorite; //new status is against previous status
  //   final Product updatedProduct = Product(
  //       //accessing the product...
  //       id: selectedProduct.id,
  //       title: selectedProduct.title,
  //       description: selectedProduct.description,
  //       price: selectedProduct.price,
  //       phoneNumber: selectedProduct.phoneNumber,
  //       image: selectedProduct.image,
  //       imagePath: selectedProduct.imagePath, 
  //       userEmail: selectedProduct.userEmail,
  //       userId: selectedProduct.userId,
  //       isFavorite: newFavoriteStatus);
  //   //replace product in list with this new product
  //   _products[selectedProductIndex] = updatedProduct;
  //   notifyListeners(); //to be sure of the change

  //   http.Response response;

  //   if (newFavoriteStatus) {
  //     response = await http.put(
  //         //products
  //         'https://fashionmantainance.firebaseio.com/products/${selectedProduct.id}/wishlistUsers/${_authenticatedUser.id}.json?auth=${_authenticatedUser.token}',
  //         body: json.encode(true)); //6666
  //   } else {
  //     response = await http.delete(//products
  //         'https://fashionmantainance.firebaseio.com/products/${selectedProduct.id}/wishlistUsers/${_authenticatedUser.id}.json?auth=${_authenticatedUser.token}');
  //   } //7777
  //   if (response.statusCode != 200 && response.statusCode != 201) {
  //     final Product updatedProduct = Product(
  //         //accessing the product...
  //         id: selectedProduct.id,
  //         title: selectedProduct.title,//changed to location
  //         description: selectedProduct.description,
  //         price: selectedProduct.price,
  //         phoneNumber: selectedProduct.phoneNumber,
  //         image: selectedProduct.image,
  //         imagePath: selectedProduct.imagePath,
  //         userEmail: selectedProduct.userEmail,
  //         userId: selectedProduct.userId,
  //         isFavorite: !newFavoriteStatus);
  //     //replace product in list with this new product
  //     _products[selectedProductIndex] = updatedProduct;
  //     notifyListeners(); //to be sure of the change
  //   }
  //   _selProductId = null;
  // }

  void selectProduct(String productId) {
    _selProductId = productId;
    if (productId != null) {
      notifyListeners();
    }
  }
//toggling the favourited products(display all or chosen products)
  /*void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }*/
}

mixin UserModel on ConnectedProductsModel {
  Timer _authTimer;
  PublishSubject<bool> _userSubject = PublishSubject();


  User get user {
    return _authenticatedUser;
  }

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }


  Future<Map<String, dynamic>> authenticate(String email, String password,
      [AuthMode authMode = AuthMode.Login]) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      //jiongeze//
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
    http.Response response;
    if (authMode == AuthMode.Login) {
      print("loginnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
      response = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDyL0EWFO7B0UOFVr3O0VQJrTGz6-gQSmY',
        body: json.encode(authData), //8888
        headers: {'Content-Type': 'application/json'},
      );
      
    } else {
      response = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDyL0EWFO7B0UOFVr3O0VQJrTGz6-gQSmY',
        body: json.encode(authData), //9999
        headers: {'Content-Type': 'application/json'},
      );
      print(json.decode(response.body));
    }
    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Something went wrong!';

    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication Succeeded!';
      //creating a new user for every token...
      _authenticatedUser = User(
          //a user with token,email,Id who can access the authentication
          id: responseData['localId'],
          email: email,
          token: responseData['idToken']);
      setAuthTimeout(int.parse(responseData['expiresIn']));
      _userSubject.add(true);
      final DateTime now = DateTime.now(); //present
      final DateTime expiryTime = now.add(
          Duration(seconds: int.parse(responseData['expiresIn']))); //future
      //storing the token in the devicce...
      final SharedPreferences prefs =
          await SharedPreferences.getInstance(); //access to storage
      //storing token//email//id  to memory//they authenticateUser...
      prefs.setString('token', responseData['idToken']);
      prefs.setString('userEmail', email);
      prefs.setString('userPassword', password);
      prefs.setString('userId', responseData['localId']);
      prefs.setString(
        'expiryTime',
        expiryTime.toIso8601String(),
      );
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'This email was not found.';
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'This email is taken.';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'The Password is invalid.';
    }
    _isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  void authenticateAgain() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userPassword = prefs.getString("userPassword");
    final String userEmail = prefs.getString("userEmail");
    authenticate(userEmail,userPassword,AuthMode.Login);
  }

  void autoAuthenticate() async {
    //access to the preferences(storage)
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //getting the token
    final String token = prefs.getString('token');
    final String expiryTimeString = prefs.getString('expiryTime');
    if (token != null) {
      //token is present
      final DateTime now = DateTime.now(); //ssasahivi
      final parsedExpiryTime =     
          DateTime.parse(expiryTimeString); //int dat ka format
          print("token ends at   $parsedExpiryTime");

      if (parsedExpiryTime.isBefore(now)) {
        _authenticatedUser = null;
        notifyListeners();
        return;
      }

      final String userEmail = prefs.getString('userEmail');
      final String userId = prefs.getString('userId');
      final int tokenLifeSpan = parsedExpiryTime.difference(now).inSeconds;//<<<>><><><><><><>
      //pass details to user
      _authenticatedUser = User(id: userId, email: userEmail, token: token);
      _userSubject.add(true);
      setAuthTimeout(tokenLifeSpan);
      print("$tokenLifeSpan .......... > > > > > > > > > > > > > >"); 
      notifyListeners();
    }
  }

  void logout() async {
    _authenticatedUser = null; //no auth user
    _authTimer.cancel(); //logout clear time
    _userSubject.add(false); //not authenticated
    _selProductId = null; 
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.remove('token');
    //prefs.remove('userEmail');
    //prefs.remove('userId');
    
  }

  void setAuthTimeout(int time) {
    //time=3600(1hr)
    _authTimer = Timer(Duration(minutes:time), logout);//3600 minutes
  }
}

mixin UtilityModel on ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
    bool get isLoading1 {
    return _isLoading1;
  }
    bool get isLoading2 {
    return _isLoading2;
  }
    bool get isLoading3 {
    return _isLoading3;
  }
    bool get isLoading4 {
    return _isLoading4;
  }
    bool get isLoading5 {
    return _isLoading5;
  }

}
