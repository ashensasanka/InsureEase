import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/firestore.dart';

class UpdateVideoPage extends StatefulWidget {
  const UpdateVideoPage({super.key});

  @override
  State<UpdateVideoPage> createState() => _UpdateVideoPageState();
}

class _UpdateVideoPageState extends State<UpdateVideoPage> {
  final FireStoreService fireStoreService = FireStoreService();
  String _searchText = '';
  late Stream<QuerySnapshot> videosStream;
  bool _ascendingOrder = true;
  final TextEditingController NameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    videosStream = fireStoreService.getVideosStream();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Videos",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xfffef6eb),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: _buildSearchBar(),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: videosStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List videosList = snapshot.data!.docs;
                    if (_searchText.isNotEmpty) {
                      videosList = videosList.where((video) {
                        final String noteText = video['name'];
                        return noteText.toLowerCase().contains(_searchText.toLowerCase());
                      }).toList();
                    }
                    if (!_ascendingOrder) {
                      videosList = videosList.reversed.toList();
                    }
                    return ListView.builder(
                      itemCount: videosList.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = videosList[index];
                        String docID = document.id;

                        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                        String videoName = data['name'];
                        String thumbnail = data['imageURL'] ?? ''; // Get subtext or use empty string if not available

                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.0,left: 8,right: 8), // Add space between items
                          child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                              child: Container(
                                color: Color(0xfff9a130),
                                child: ListTile(
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        videoName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                                      Image.network(thumbnail)
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () => openNoteBox(docID: docID),
                                        icon: Icon(Icons.settings),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _confirmDelete(context, docID);
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text("No Notes!"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  void openNoteBox({String? docID}) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xfffef6eb),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: NameController,
                decoration: InputDecoration(
                  labelText: 'Video Name',
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
                fireStoreService.updateAdminVideo(
                    docID!,
                    NameController.text);
              NameController.clear();
              Navigator.pop(context);
            },
            child: Text(
              "Update",
              style: TextStyle(
                color: Color(0xfff9a130),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildSearchBar() {
    return TextField(
      onChanged: (value) {
        setState(() {
          _searchText = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Search',
        hintText: 'Search supplier...',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
    );
  }
  Future<void> _confirmDelete(BuildContext context, String docID) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this video?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                fireStoreService.deleteVideo(docID);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
