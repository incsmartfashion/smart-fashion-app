import 'package:fashiondada/pages/terms.dart';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';
import '../models/auth.dart';

class AuthPage extends StatefulWidget {
  final MainModel model;
  AuthPage(this.model);
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'email': null,
    'phoneNumber': null,
    'password': null,
    'acceptTerms': false
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();

  AuthMode _authMode = AuthMode.Login;
  String userEmail;
  String userPassword;

  @override
void initState()  {
   userEmail = widget.model.userEmail;
   userPassword = widget.model.userPassword;
   print("....................................................$userPassword");
   print("....................................................$userEmail");
  super.initState();
}

  Widget _buildEmailTextField() {
    return TextFormField(
      initialValue:userEmail,
      decoration: InputDecoration(
          border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        ),),
          labelText: ' Barua Pepe/Email',
          labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
           filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        //begins********************
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      }, //ends******************
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      //initialValue: userPassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        ),),
          labelText: 'Nenosiri', 
          labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
          filled: true, fillColor: Colors.white),
      obscureText: true,
      controller: _passwordTextController,
      validator: (String value) {
        //begins**********
        if (value.isEmpty || value.length < 4) {
          return 'Nenosiri liwe na tarakimu zaidi ya 4';
        }
        return null;
      }, //end********************
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildPasswordConfirmTextField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        ),),
          labelText: 'Hakiki Nenosiri', 
          labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
          filled: true, fillColor: Colors.white),
      obscureText: true,
      validator: (String value) {
        //begins
        if (_passwordTextController.text != value) {
          return 'Umekosea.Rudia!';
        }
        return null;
      }, //ends...
    );
  }

  Widget _buildAcceptSwitch() {
    return Container(
        child: Column(
      children: <Widget>[
        SwitchListTile(
          inactiveTrackColor: Colors.black,
          activeColor: Colors.blue,
          value: _formData['acceptTerms'],
          onChanged: (bool 
          value) {
            setState(() {
              _formData['acceptTerms'] = value;
            });
          },
          title: Text('Nimekubali Vigezo na Masharti'),
        ),
          Row(
            children: <Widget>[
              Text('Onesha'),
              FlatButton(
              onPressed: (){
                Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => Terms()),
                );
              },
              child: Text('Vigezo na Masharti',style: TextStyle(color: Colors.red),
        ),)
            ],
          ),
      ],
    ));
  }

  void _submitForm(Function authenticate) async {
    if (!_formKey.currentState.validate() /*|| !_formData['acceptTerms']*/) {
      //accept terms is neglected....
      return;
    }
    _formKey.currentState.save();
    Map<String, dynamic> successInformation;
    successInformation = await authenticate(
        _formData['email'], _formData['password'], _authMode);

    if (successInformation['success']) {
      Navigator.pushReplacementNamed(context, '/admin');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('An Error Occured!'),
              content: Text(successInformation['message']),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    return WillPopScope(
      onWillPop: () {
        //Navigator.pop(context, false);
        Navigator.pushReplacementNamed(context, '/homescreen');
        return Future.value(false);
      },
      child: Scaffold(


        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[200],
          title: Text(
            'Uza sasa na Smart Fashion',
            style: TextStyle(color: Color(0XFFEF476F),fontWeight: FontWeight.bold),
          ),
        ),


        body:Container(
            decoration: BoxDecoration(
              //image: _buildBackgroundImage(),
            ),
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  width: targetWidth,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildEmailTextField(),
                          SizedBox(
                            height: 20.0,
                          ),
                          _buildPasswordTextField(),
                          SizedBox(
                            height: 10.0,
                          ),
                          _authMode == AuthMode.Signup
                              ? _buildPasswordConfirmTextField()
                              : Container(),
                          _buildAcceptSwitch(),
                          FlatButton(
                            //ni mungu tuu
                            child: Text(
                                '${_authMode == AuthMode.Login ? 'Huna Akaunti? Fungua' : 'Ingia'}'),
                            onPressed: () {
                              setState(() {
                                _authMode = _authMode == AuthMode.Login
                                    ? AuthMode.Signup
                                    : AuthMode.Login;
                              });
                            },
                          ),
                          ScopedModelDescendant(
                            builder: (
                              BuildContext context,
                              Widget child,
                              MainModel model,
                            ) {
                              return model.isLoading
                                  ? CircularProgressIndicator()
                                  : RaisedButton(
                                    color: Color(0XFFFEE440),
                                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                      textColor: Colors.white,
                                      child: Text(_authMode == AuthMode.Login
                                          ? 'INGIA'
                                          : 'FUNGUA',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                      onPressed: () => //widget.model.fetchEmailPassword(),
                                          _submitForm(model.authenticate),
                                    );
                            },
                          ),
                        ],
                      ),
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }
}
