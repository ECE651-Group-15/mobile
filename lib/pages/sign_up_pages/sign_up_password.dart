import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'controller.dart';

class SignUpPassword extends StatefulWidget {
  // final args = Get.arguments as Map<String, dynamic>;
  SignUpPassword({Key? key}) : super(key: key);
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final SignUpController controller = Get.find<SignUpController>();
  bool _agreedToTerms = false;
  bool _agreedToPrivacy = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _passwordController.dispose(); // 正确地释放控制器资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children:<Widget> [
                const Padding(
                  padding: EdgeInsets.all(20.0),
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
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.visibility),
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
                    title: const Text("I understand and agree to the Terms of Use."),
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
                    title: const Text(
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      controller.state.pwd = _passwordController.text;
                      try {
                        // 假设 registerUser 是一个异步函数，我们使用 await 等待其完成
                        bool isSuccess = await controller.registerUser();
                        if (isSuccess) {
                          // 注册成功，执行成功操作，例如显示成功对话框或导航到下一个页面
                          // EasyLoading.showSuccess('sign up success');
                          controller.showSuccessDialog(context);
                        } else {
                         EasyLoading.showError('sign up failed');
                        }
                      } catch (e) {
                        // 捕获异常并显示错误提示
                        EasyLoading.showError('sign up failed : $e');
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor : const Color(0xFF00008B), // match_parent width
                  ),
                  child: const Text(
                      'Sign up',
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