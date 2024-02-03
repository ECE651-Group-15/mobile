import 'package:flutter/material.dart';

class SignUpPassword extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpPassword> {
  final _formKey = GlobalKey<FormState>();
  bool _agreedToTerms = false;
  bool _agreedToPrivacy = false;

  void _trySubmitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid && _agreedToTerms && _agreedToPrivacy) {
      // If the form is valid and agreements are checked, submit the form
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop(); // 关闭当前页面
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
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.visibility),
                      onPressed: () {
                        // 处理密码可见性
                      },
                    ),
                  ),
                  obscureText: true,
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
                  onPressed: _trySubmitForm,
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