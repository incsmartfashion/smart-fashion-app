import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:workmanager/workmanager.dart';
import './pages/products_admin.dart';
import './pages/products.dart';
import './pages/product.dart';
import 'scoped-models/main.dart';
import './models/product.dart';
import 'splash.dart';

void main() { 
	
// needed if you intend to initialize in the `main` function 
WidgetsFlutterBinding.ensureInitialized(); 
Workmanager.initialize( 
	
	// The top level function, aka callbackDispatcher 
	callbackDispatcher, 
	
	// If enabled it will post a notification whenever 
	// the task is running. Handy for debugging tasks 
	isInDebugMode: false
); 
// Periodic task registration 
Workmanager.registerPeriodicTask( 
	"2", 
	
	//This is the value that will be 
	// returned in the callbackDispatcher 
	"simplePeriodicTask", 
	
	// When no frequency is provided 
	// the default 15 minutes is set. 
	// Minimum frequency is 15 min. 
	// Android will automatically change 
	// your frequency to 15 min 
	// if you have configured a lower frequency. 
	frequency: Duration(hours: 12), 
); 
runApp(MyApp()); 
} 

void callbackDispatcher() { 
Workmanager.executeTask((task, inputData) { 
	
	// initialise the plugin of flutterlocalnotifications. 
	FlutterLocalNotificationsPlugin flip = new FlutterLocalNotificationsPlugin(); 
	
	// app_icon needs to be a added as a drawable 
	// resource to the Android head project. 
	var android = new AndroidInitializationSettings('@mipmap/launcher_icon'); 
	var iOS = new IOSInitializationSettings(); 
	
	// initialise settings for both Android and iOS device. 
	var settings = new InitializationSettings(android: android, iOS: iOS); 
	flip.initialize(settings); 
	_showNotificationWithDefaultSound(flip); 
	return Future.value(true); 
}); 
} 

Future _showNotificationWithDefaultSound(flip) async { 
	
// Show a notification after every 15 minute with the first 
// appearance happening a minute after invoking the method 
var androidPlatformChannelSpecifics = new AndroidNotificationDetails( 
	'your channel id', 
	'your channel name', 
	'your channel description', 
	importance: Importance.max, 
	priority: Priority.high 
); 
var iOSPlatformChannelSpecifics = new IOSNotificationDetails(); 
	
// initialise channel platform for both Android and iOS device. 
var platformChannelSpecifics = new NotificationDetails( 
	android: androidPlatformChannelSpecifics, 
	iOS: iOSPlatformChannelSpecifics 
); 
await flip.show(0, 'Smart Fashion', 
	'Click for new deals', 
	platformChannelSpecifics, payload: 'Default_Sound'
); 
} 

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  bool _isAuthenticated = false;
 String title; 
  @override


  void initState() {
    _model.autoAuthenticate();
    _model.userSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
    _model.authenticateAgain();
    _model.fetchEmailPassword();
    super.initState();
  }

  @override
  Widget build(BuildContext contextMain) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        title: 'Smart Fashion',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Raleway',
            brightness: Brightness.light,
            primarySwatch: Colors.pink, 
            accentColor: Colors.black,
            buttonColor: Colors.grey),

         home: SplashScreen(title: 'Smart Fashion',),
        routes: {
          '/homescreen': (BuildContext context) =>
              /*!_isAuthenticated ? AuthPage() :*/ ProductsPage(_model,_isAuthenticated),//no need for aunthentication
          '/admin': (BuildContext context) =>
              /*!_isAuthenticated ? AuthPage() :*/ ProductsAdminPage(_model), /*******uncomment********** */
        },
        onGenerateRoute: (RouteSettings settings) {
          if (/*!_isAuthenticated &&*/ settings.name == null) {
            return MaterialPageRoute<bool>(
                //builder: (BuildContext context) => AuthPage());
                builder: (BuildContext context) => ProductsPage(_model,_isAuthenticated));
          }
          if(/*!_isAuthenticated &&*/ settings.name != null){//there is a certain nameSetting
            final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }/*******modification never ceases********/
          if (pathElements[1] == 'product') {
            final String productId =
                pathElements[2];
                     /***before modification***/
             /*final Product product =
              _model.allProducts1.firstWhere((Product product) {
              return product.id == productId;
            });*/ 
            Product product;
            /***when cards at men/women are called ***/
            // if(pathElements[3] == null){
            //      product =
            //     _model.allProducts.firstWhere((Product product) {
            //   return product.id == productId;
            // });
            // }
            if(pathElements[3] == '0'){
                 product =
                _model.allProducts.firstWhere((Product product) {
              return product.id == productId;
            });
            }
            else if(pathElements[3] == '1'){
                 product =
                _model.allProducts1.firstWhere((Product product) {
              return product.id == productId;
            });
            }
            else if(pathElements[3] == '2'){
                 product =
                _model.allProducts2.firstWhere((Product product) {
              return product.id == productId;
            });
            }
            else if(pathElements[3] == '3'){
                 product =
                _model.allProducts3.firstWhere((Product product) {
              return product.id == productId;
            });
            }
            else if(pathElements[3] == '4'){
                 product =
                _model.allProducts4.firstWhere((Product product) {
              return product.id == productId;
            });
            }
            else if(pathElements[3] == '5'){
                 product =
                _model.allProducts5.firstWhere((Product product) {
              return product.id == productId;
            });
            }
            else if(pathElements[3] == "normalFlow"){
            /**when cards at women or men are called*normal flow*/
                 product =
                _model.allProducts.firstWhere((Product product) {
              return product.id == productId;
            });
            }
            
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
                  /*!_isAuthenticated ? AuthPage() :*/ ProductPage(product,_model),
            );

            }
         }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) =>
                 /* !_isAuthenticated ? AuthPage() :*/ ProductsPage(_model,_isAuthenticated));
        },
      ),);
  }
}