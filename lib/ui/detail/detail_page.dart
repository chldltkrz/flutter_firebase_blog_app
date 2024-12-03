import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog_app/ui/write/write_page.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            iconButton(Icons.delete, () {}),
            iconButton(Icons.edit, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WritePage(),
                ),
              );
            }),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.only(bottom: 500),
          children: [
            Image.network(
              'https://picsum.photos/200/300',
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TIU",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 14),
                  Text(
                    "작성자: TIU",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "2024-12-03",
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    "Flutter Google Firebase Blog App" * 100,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget iconButton(IconData icon, void Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        color: Colors.transparent,
        child: Icon(icon),
      ),
    );
  }
}
