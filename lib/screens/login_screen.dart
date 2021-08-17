import 'package:duvit/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //Global Keys
  final formKey     = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  //Provider
  final loginProvider = new LoginProvider();

  //Variables
  String _username = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        key: scaffoldKey,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/background_login.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height/4.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/3.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 80.0,
                        backgroundImage: AssetImage('assets/icon.png'),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
    
              Form(
                key: formKey,
                child: Container(
                  height: MediaQuery.of(context).size.height/2.5,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 42),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width/1.2,
                        height: 45,
                        padding: EdgeInsets.only(
                          top: 4,left: 16, right: 16, bottom: 4
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50)
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5
                            )
                          ]
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none, 
                            icon: Icon(Icons.person,
                                color: Colors.red,
                            ),
                            hintText: 'Username',
                            
                          ),
                          onSaved: (value) => _username = value.toString(),
                        ),
                      ),
                      
                      Container(
                        width: MediaQuery.of(context).size.width/1.2,
                        height: 45,
                        margin: EdgeInsets.only(top: 16),
                        padding: EdgeInsets.only(
                            top: 4,left: 16, right: 16, bottom: 4
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(50)
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5
                              )
                            ]
                        ),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.vpn_key,
                              color: Colors.red,
                            ),
                            hintText: 'Password',
                          ),
                          onSaved: (value) => _password = value.toString(),
                        ),
                      ),
                  
                      /*Spacer(),*/
                  
                      InkWell(
                          onTap: validate,
                          child: Container(
                          height: 45,
                          margin: EdgeInsets.only(top: 32),
                          width: MediaQuery.of(context).size.width/1.2,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.redAccent,
                                Colors.red,
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50)
                            )
                          ),
                          child: Center(
                            child: Text('Login'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),       
            ],
          ),
        ),
      ),
    );
  }

  void validate() async {

    FocusScope.of(context).unfocus();

    var form = formKey.currentState;
    form!.save();

    if ( _username.isEmpty || _password.isEmpty ) {
      showMessage( 'El usuario y la contraseña son requeridos' );
    } else {

      showMessage( 'Espere mientras validamos sus datos ...' );

      Map response = await loginProvider.loginValidate(_username, _password);

      //await Future.delayed(Duration(seconds: 2));

      if ( response['code'] == '201' ) {

        var name        = response['name'];
        var email       = response['email'];
        var idUser      = response['idUser'];
        var idStaff     = response['idStaff'];
        var idGender    = response['idGender'];
        var lat         = response['lat'];
        var long        = response['long'];
        var validateGPS = response['validateGPS'];

        if ( validateGPS == "1" ) {
          if ( lat.toString().isEmpty || long.toString().isEmpty ) {
            showMessage( 'No se ha registrado ubicación de trabajo' );
          } else {
            Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/home'));
          }
        } else {
          Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/home'));
        }

      } else {
        showMessage( response['message'] );
      }
    }

  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle( fontSize: 15 )
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }
}