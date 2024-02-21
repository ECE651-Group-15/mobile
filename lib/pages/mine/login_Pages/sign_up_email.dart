import 'package:flutter/material.dart';
import 'sign_up_name.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EmailInputScreen extends StatefulWidget {
  const EmailInputScreen({super.key});
  @override
  _EmailInputScreenState createState() => _EmailInputScreenState();
}
class EmailCheckResult {
  final bool isAvailable;
  final String? errorMessage;

  EmailCheckResult({required this.isAvailable, this.errorMessage});
}

class _EmailInputScreenState extends State<EmailInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  late final String email;
  bool isValidEmail(String email) {
    // 使用正则表达式来验证电子邮件地址的有效性
    return RegExp(r'^\S+@\S+\.\S+$').hasMatch(email);
  }

  @override
  void dispose() {
    _emailController.dispose(); // 不要忘记释放控制器资源
    super.dispose();
  }

  Future<EmailCheckResult> checkEmailAvailable(String email) async {
    var headers = {
      'User-Agent': 'Apifox/1.0.0 (https://apifox.com)',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://ec2-3-145-145-71.us-east-2.compute.amazonaws.com:8080/v1/api/profile/check-email'));
    request.body = json.encode({"email": email});
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
        // 如果状态码为200，解析响应体判断电子邮箱是否已被使用
        var decodedResponse = json.decode(responseBody);
        if (decodedResponse['code'] == 4001) { // 假设代码 4001 表示电子邮件已存在
          return EmailCheckResult(isAvailable: false, errorMessage: decodedResponse['message']);
        } else {
          return EmailCheckResult(isAvailable: true);
        }
    } catch (e) {
      // 捕获请求过程中的异常
      print(e.toString());
      return EmailCheckResult(isAvailable: true, errorMessage: 'Failed to check email availability. Please try again later.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0, // Removes the shadow under the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              const Text(
                "What's your email?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value)  {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  } else if (!isValidEmail(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      EmailCheckResult result = await checkEmailAvailable(_emailController.text);
                      if (!mounted) return;
                        if (_formKey.currentState!.validate()) {
                          if (result.isAvailable){
                            email=_emailController.text;
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => NameInputScreen( email: email)));
                          }
                          else {
                            // Show snackbar or UI indication that email is in use
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('This email address is already in use.'))
                            );
                          }
                        }
                        // Navigate or perform actions if email is not in use

                    } catch (e) {
                      if (!mounted) return;
                      // Show snackbar or UI indication of error
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString()))
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50), // sets the height of the button
                  backgroundColor: Color(0xFF00008B), // sets the background color of the button
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
