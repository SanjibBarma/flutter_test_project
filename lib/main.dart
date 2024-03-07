import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isPasswordVisible = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _rememberPassword = false;
  bool _switchValue = false;
  String? _usernameError;
  String? _passwordError;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My App",
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Clean button functionality
                            _cleanCache();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Clean',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Spacer(),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _switchValue = !_switchValue;
                            });
                          },
                          child: Container(
                            width: 70.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: _switchValue ? Colors.green : Colors.red,
                            ),
                            child: Row(
                              mainAxisAlignment: _switchValue ? MainAxisAlignment.end : MainAxisAlignment.start,
                              children: <Widget>[
                                _switchValue
                                    ? Padding(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: Text(
                                    'BN',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                                    : SizedBox(),
                                Container(
                                  width: 30.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 20.0,
                                      height: 20.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _switchValue ? Colors.white : Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                !_switchValue
                                    ? Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    'EN',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Image.asset(
                    'assets/ic_ecrm_logo.png',
                    height: 150,
                    width: double.infinity,
                  ),
                ),

                SizedBox(height: 8),

                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                SizedBox(height: 24),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _usernameError = value.isEmpty ? 'Please enter a username' : null;
                          });
                        },
                      ),
                      if (_usernameError != null)
                        Positioned(
                          right: 50,
                          child: Text(
                            _usernameError!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  )
                ),

                SizedBox(height: 16),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _passwordError = value.isEmpty ? 'Please enter a password' : null;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(11),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                          ),
                          child: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                        ),
                      ),
                      if (_passwordError != null)
                        Positioned(
                          right: 50,
                          child: Text(
                            _passwordError!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  ),
                ),


                SizedBox(height: 16),

                Row(
                  children: [
                    Checkbox(
                      value: _rememberPassword,
                      onChanged: (value) {
                        // Checkbox functionality
                        setState(() {
                          _rememberPassword = value!;
                        });
                      },
                    ),
                    Text('Remember Password'),
                  ],
                ),

                SizedBox(height: 24),

                InkWell(
                  onTap: () {
                    // Login button functionality
                    if (_usernameController.text.isEmpty) {
                      _usernameError = 'Please enter a username';
                    } else {
                      _usernameError = null;
                    }

                    if (_passwordController.text.isEmpty) {
                      _passwordError = 'Please enter a password';
                    } else {
                      _passwordError = null;
                    }

                    if (_rememberPassword) {
                      _showToast("Username: ${_usernameController.text}\nPassword: ${_passwordController.text}");
                    } else {
                      _showToast("No username and password");
                    }

                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Colors.blue,
                    child: Container(
                      height: 48,
                      alignment: Alignment.center,
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'V2',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),

                SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '© V2 Technologies Ltd-2020',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



void _cleanCache() async {
  DefaultCacheManager().emptyCache().then((_) {
    _showToast("App cache has been cleared");
  }).catchError((error) {
    print("Error clearing cache: $error");
    _showToast("Failed to clear app cache");
  });
}

void _showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.grey,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
