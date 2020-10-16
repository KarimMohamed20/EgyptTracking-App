import 'package:app/Components/Auth/registerComponents.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(27, 114, 194, 1),
        title: Text('Register'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            RegisterComponents().headerLogo(),
            RegisterComponents().registerFields(),
            RegisterComponents().registerButton(),
          ],
        ),
      ),
    );
  }
}
