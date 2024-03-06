import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                        Switch(
                          value: false,
                          onChanged: (value) {
                            // Switch functionality
                          },
                        ),
                        Text('EN'),
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
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),

                SizedBox(height: 16),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            ),
                          ),
                        ),
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
                    if(_rememberPassword){
                      _showToast("Username: ${_usernameController.text}\nPassword: ${_passwordController.text}");
                    }else{
                      _showToast("No name and password");

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
