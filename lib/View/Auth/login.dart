import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var selectedType = "Student";
  List types = ["Student", "Driver"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            // SplashScreen
            Container(
              height: MediaQuery.of(context).size.height / 1.6,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      "assets/images/splash_logo.png",
                      scale: 1.5,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "FocusEMS",
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 21,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/splash.png'),
                      fit: BoxFit.fill)),
            ),

            // Login Type
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  // Student
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedType = "Student";
                        });
                      },
                      child: Container(
                        child: Container(
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 5.5),
                                Image.asset("assets/images/login_student.png",
                                    width: 30, height: 30, color: Colors.white),
                                SizedBox(height: 5),
                                Text("Student",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        color: selectedType == "Student"
                            ? Color.fromRGBO(233, 66, 74, 1)
                            : Color.fromRGBO(27, 114, 194, 1),
                        width: MediaQuery.of(context).size.width / 4,
                      ),
                    ),
                  ),
                  //   Driver
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedType = "Driver";
                      });
                    },
                    child: Container(
                      child: Container(
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 5.5),
                              Image.asset("assets/images/login_driver.png",
                                  width: 30, height: 30, color: Colors.white),
                              SizedBox(height: 5),
                              Text("Driver",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      color: selectedType == "Driver"
                          ? Color.fromRGBO(233, 66, 74, 1)
                          : Color.fromRGBO(27, 114, 194, 1),
                      width: MediaQuery.of(context).size.width / 4,
                    ),
                  ),
                ],
              ),
            ),

            // Login Part

            Expanded(
              flex: 2,
              child: Container(
                color: Color.fromRGBO(237, 246, 255, 1),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 19,
                        color: Color.fromRGBO(235, 158, 26, 1),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Color.fromRGBO(237, 246, 255, 1),
                          )),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Email",
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color.fromRGBO(27, 114, 194, 1),
                            )),
                      ),
                      height: 45,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Color.fromRGBO(237, 246, 255, 1),
                          )),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Password",
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color.fromRGBO(27, 114, 194, 1),
                            )),
                      ),
                      height: 45,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      child: Center(
                          child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                      color: Color.fromRGBO(235, 158, 26, 1),
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Center(
                      child: Text(
                    "AppLocalizations.of(context).translate('forgetPassword')",
                    style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                  color: Color.fromRGBO(199, 130, 13, 1),
                  alignment: Alignment.bottomCenter,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
