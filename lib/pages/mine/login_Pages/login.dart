import 'package:exchange/pages/mine/login_Pages/sign_up_email.dart';
import 'package:flutter/material.dart';
import 'sign_up_email.dart';
class LoginScreen extends StatelessWidget {
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Log in",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // Email 输入框
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            // 密码输入框
            TextField(
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
            ),
            SizedBox(height: 24),
            // 登录按钮
            // 忘记密码链接
            TextButton(
              child: Text('Forgot password?'),
              onPressed: () {
                // 处理忘记密码逻辑
              },
            ),
            // 注册新账号链接
            TextButton(
              child: Text('Don\'t have an account? Sign up'),
              onPressed: () {
               Navigator.push(context,
                   MaterialPageRoute(builder: (context)=>EmailInputScreen()),
               ); // 处理注册逻辑
              },
            ),
            Spacer(),
            ElevatedButton(
              child: Text(
                  'Log in',
              style: TextStyle(
                color: Colors.white,
              ),
              ),
              onPressed: () {
                // 处理登录逻辑
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50), // sets the height of the button
                backgroundColor : Color(0xFF00008B), // sets the background color of the button
              ),
            ),
          ],
        ),
      ),
    );
  }
}
