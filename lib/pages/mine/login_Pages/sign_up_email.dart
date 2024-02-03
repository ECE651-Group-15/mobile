import 'package:flutter/material.dart';
import 'sign_up_name.dart';

class EmailInputScreen extends StatefulWidget {
  @override
  _EmailInputScreenState createState() => _EmailInputScreenState();
}

class _EmailInputScreenState extends State<EmailInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool isValidEmail(String email) {
    // 使用正则表达式来验证电子邮件地址的有效性
    return RegExp(r'^\S+@\S+\.\S+$').hasMatch(email);
  }

  @override
  void dispose() {
    _emailController.dispose(); // 不要忘记释放控制器资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0, // Removes the shadow under the app bar
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              Text(
                "What's your email?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  } else if (!isValidEmail(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              Spacer(),
              ElevatedButton(
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  // 只有当表单验证通过时，才会导航
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NameInputScreen()));
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50), // sets the height of the button
                  backgroundColor: Color(0xFF00008B), // sets the background color of the button
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
