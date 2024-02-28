import 'package:exchange/common/routes/names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';

class EmailInputScreen extends StatefulWidget {
  const EmailInputScreen({Key? key}) : super(key: key);

  @override
  _EmailInputScreenState createState() => _EmailInputScreenState();
}

class _EmailInputScreenState extends State<EmailInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final SignUpController controller = Get.find<SignUpController>(); // 通过Get.find()获取SignUpController实例

  @override
  void dispose() {
    _emailController.dispose(); // 在这里正确释放 TextEditingController 资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: (){
            Get.back();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              const Text("What's your email?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'Email', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address'; // 验证失败，返回错误消息
                  } else if (!controller.isValidEmail(value)) {
                    return 'Please enter a valid email address'; // 验证失败，返回错误消息
                  }
                  return null; // 验证成功，返回 null
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    controller.state.email = _emailController.text;
                    Get.toNamed(AppRoutes.signUpName);// 验证通过，执行后续操作，比如导航到下一个页面
                  }
                },
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50), backgroundColor: const Color(0xFF00008B)),
                child: const Text('Continue', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


