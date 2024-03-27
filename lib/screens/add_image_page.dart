import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/home_controller.dart';

class AddImagePage extends StatefulWidget {
  const AddImagePage({Key? key});

  @override
  State<AddImagePage> createState() => _AddImagePageState();
}

class _AddImagePageState extends State<AddImagePage> {
  TextEditingController _textFieldController = TextEditingController();
  File? _image;

  Future<void> _getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) =>
      GetBuilder<HomeController>(builder: (ctrl) {
        return Scaffold(
          body: Center(
            child: Container(
              width: 350,
              height: 600,
              decoration: BoxDecoration(
                color: Colors.grey[300], // Set background color to gray
                borderRadius: BorderRadius.circular(20), // Round the borders
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: _getImageFromGallery,
                    child: Container(
                      width: 300,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white, // Set the background color
                        borderRadius:
                            BorderRadius.circular(20), // Round the borders
                      ),
                      child: _image != null
                          ? Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              Icons
                                  .add_photo_alternate, // Add an icon for image selection
                              size: 100,
                              color: Colors.grey, // Set the icon color
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ctrl.addPost(_image, 'image');
                    },
                    child: Text(
                      '    Submit    ',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(
                        0xff1F36C7,
                      ),
                      side: BorderSide(
                        color: Colors.white,
                      ), // Add border color here
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          20,
                        ), // Add border radius here
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Upload images to support your claim')
                ],
              ),
            ),
          ),
        );
      });

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }
}
