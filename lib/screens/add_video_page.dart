import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

import '../utils/save_video.dart';
import '../utils/utils.dart';

class AddVideoPage extends StatefulWidget {
  const AddVideoPage({Key? key}) : super(key: key);

  @override
  State<AddVideoPage> createState() => _AddVideoPageState();
}

class _AddVideoPageState extends State<AddVideoPage> {
  String? _videoURL;
  VideoPlayerController? _controller;
  String? _downloadVideoURL;
  String? _downloadImageURL;
  File? _image;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _thumbController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _controller?.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _thumbController.dispose();
    super.dispose();
  }
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Videos'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 55.0, // Adjust the height as needed
                child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Text('Add Thumbnail'),
            GestureDetector(
              onTap: _getImageFromGallery,
              child: Container(
                width: 150,
                height: 150,
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
                  size: 50,
                  color: Colors.grey, // Set the icon color
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Container(
            //     height: 55.0, // Adjust the height as needed
            //     child: TextField(
            //       controller: _thumbController,
            //       decoration: InputDecoration(
            //         labelText: 'Add Thumbnail link',
            //         border: OutlineInputBorder(),
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _pickVideo();
                },
                child: Text('Pick Video'),
              ),
            ),
            _videoURL != null ? _videoPreviewWidget() : Text('No Video Selected'),
          ],
        ),
      ),
    );
  }
  void _pickVideo() async {
    _videoURL = await pickVideo();
    _initializeVideoPlayer();
  }
  void _initializeVideoPlayer() {
    _controller = VideoPlayerController.file(File(_videoURL!))
      ..initialize().then((_) {
        setState(() {});
        _controller!.play();
      });

  }
  Widget _videoPreviewWidget() {
    if (_controller != null) {
      return Column(
        children: [
          AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: VideoPlayer(_controller!),
          ),
          ElevatedButton(onPressed: _uploadVideo, child: Text('Upload'))
        ],
      );
    } else {
      return const CircularProgressIndicator();
    }
  }
  void _uploadVideo() async {
    _downloadVideoURL = await StoreData().uploadVideo(_videoURL!);
    _downloadImageURL = await StoreData().uploadImage(_image,'image');
    await StoreData().saveVideoData(
        _downloadVideoURL!,
        _downloadImageURL!,
        _titleController.text);
    setState(() {
      _videoURL = null;
      _image = null;
      _titleController.clear();
    });
  }
}

