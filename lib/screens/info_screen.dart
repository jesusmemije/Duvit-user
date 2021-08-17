import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // we won't use appBar here
      // appBar: AppBar(
      //   title: Text("Full screen page"),
      //   backgroundColor: Colors.purple,
      // ),
      // might need to set this flag, 
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        top: false,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/background_login.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text('',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}