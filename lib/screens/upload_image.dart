import 'package:flutter/material.dart';

class UploadImgPage extends StatefulWidget {
  const UploadImgPage({super.key});

  @override
  State<UploadImgPage> createState() => _UploadImgPageState();
}

class _UploadImgPageState extends State<UploadImgPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('data',style: TextStyle(
          fontSize: 50
        ),),
      ),
    );
  }
}
