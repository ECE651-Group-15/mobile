import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../view.dart';
import 'login.dart';
class SignUpPassword extends StatefulWidget {
  late final String email;
  late final String name ;
  SignUpPassword({Key? key, required this.email,required this.name}) : super(key: key);
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  late final String pwd ;
  bool _agreedToTerms = false;
  bool _agreedToPrivacy = false;
  bool _isPasswordVisible = false;
  // String email = _emailController.text;
  @override
  void dispose() {
    _passwordController.dispose(); // 释放控制器资源
    super.dispose();
  }
  void _trySubmitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid && _agreedToTerms && _agreedToPrivacy) {
      // If the form is valid and agreements are checked, submit the form
    }
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('registration success'),
          content: Text('Congratulations, you have successfully registered as a user'),
          actions: <Widget>[
            TextButton(
              child: Text('Return to login interface'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );// 关闭对话框
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            // Navigator.of(context).pop();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MinePage()));// 关闭当前页面
          },
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children:<Widget> [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Set a password",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });// 处理密码可见性
                      },
                    ),
                  ),
                  obscureText: !_isPasswordVisible,
                  validator: (value) {
                    // Add your own validation logic
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password.';
                    }
                    // Add checks for the number of characters, symbols, etc.
                    return null;
                  },
                ),
                // Add password requirements indicators
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CheckboxListTile(
                    title: Text("I understand and agree to the Terms of Use."),
                    value: _agreedToTerms,
                    onChanged: (newValue) {
                      setState(() {
                        _agreedToTerms = newValue ?? false;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CheckboxListTile(
                    title: Text(
                        "I understand and agree that my personal information will be processed in accordance with the Privacy Policy."),
                    value: _agreedToPrivacy,
                    onChanged: (newValue) {
                      setState(() {
                        _agreedToPrivacy = newValue ?? false;
                      });
                    },
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed:() async {
                    pwd = _passwordController.text;
                    var headers = {
                      'User-Agent': 'Apifox/1.0.0 (https://apifox.com)',
                      'Content-Type': 'application/json'
                    };
                    var request = http.Request('POST', Uri.parse('http://ec2-18-222-250-106.us-east-2.compute.amazonaws.com:8080/v1/api/profile/create-profile'));
                    request.body = json.encode({
                      "email": widget.email,
                      "name": widget.name,
                      "password": pwd
                    });
                    request.headers.addAll(headers);

                    http.StreamedResponse response = await request.send();

                    if (response.statusCode == 200) {
                      print(await response.stream.bytesToString());
                      showSuccessDialog(context);
                    }
                    else {
                      print(response.reasonPhrase);
                    }
                  },
                  child: Text(
                      'Sign up',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor : Color(0xFF00008B), // match_parent width
                  ),
                ),
              ],
            ),
          ),
        ),

    );
  }
}