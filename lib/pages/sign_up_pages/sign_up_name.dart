import 'package:exchange/common/routes/names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';

class NameInputScreen extends StatefulWidget {
  const NameInputScreen({Key? key}) : super(key: key);
  @override
  _NameInputScreenState createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // 移动FormKey到State类
  final TextEditingController _nameController = TextEditingController();
  final SignUpController controller = Get.find<SignUpController>();

  @override
  void dispose() {
    _nameController.dispose(); // 正确地在State类中释放控制器资源
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
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form( // 包裹Column在Form中
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              const Text(
                "What's your name?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextFormField( // 使用TextFormField代替TextField
                controller: _nameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) { // 添加验证逻辑
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name'; // 如果输入为空或只包含空格，则提示错误
                  }
                  else{
                    return null; // 如果输入正确，不返回错误信息
                  }
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    controller.state.name = _nameController.text;
                    Get.toNamed(AppRoutes.signUpPwd);// 验证通过，执行后续操作，比如导航到下一个页面
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  backgroundColor : Color(0xFF00008B),
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
