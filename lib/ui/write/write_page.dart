import 'package:flutter/material.dart';

class WritePage extends StatefulWidget {
  const WritePage({super.key});

  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  TextEditingController writeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    writeController.dispose();
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () {
                final result = formKey.currentState?.validate() ?? false;
              },
              child: Container(
                width: 50,
                height: 50,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  '완료',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: Form(
              key: formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  TextFormField(
                    controller: writeController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(hintText: '작성자'),
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return '작성자를 입력해주세요';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: titleController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(hintText: '제목'),
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return '제목을 입력해주세요';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 200,
                    child: TextFormField(
                      controller: contentController,
                      maxLines: null,
                      expands: true,
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(hintText: '내용'),
                      validator: (value) {
                        if (value?.trim().isEmpty ?? true) {
                          return '내용을 입력해주세요';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey,
                      child: Icon(Icons.image),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
