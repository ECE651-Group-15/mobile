import 'package:flutter/material.dart';
import 'sign_up_password.dart'; // 确保这个文件存在并且路径正确
class NameInputScreen extends StatefulWidget {
  final String email;
  NameInputScreen({Key? key, required this.email}) : super(key: key);
  @override
  _NameInputScreenState createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // 移动FormKey到State类
  final TextEditingController _nameController = TextEditingController();
  late final String name ;

  @override
  void dispose() {
    _nameController.dispose(); // 正确地在State类中释放控制器资源
    super.dispose();
  }
// class NameInputScreen extends StatefulWidget {
//   final _formKey = GlobalKey<FormState>(); // 添加一个FormKey用于验证
//   TextEditingController _nameController = TextEditingController();
//   @override
//   void dispose() {
//     _nameController.dispose(); // 释放控制器资源
//     super.dispose();
//   }
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
              Text(
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
                decoration: InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) { // 添加验证逻辑
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name'; // 如果输入为空或只包含空格，则提示错误
                  }
                  return null; // 如果输入正确，不返回错误信息
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
                  if (_formKey.currentState!.validate()) {
                    name = _nameController.text;// 当点击按钮时，验证表单
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPassword(email: widget.email,name: name,)),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  backgroundColor : Color(0xFF00008B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
