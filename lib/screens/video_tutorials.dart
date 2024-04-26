import 'package:app/screens/play_video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VideoTutorialPage extends StatefulWidget {
  const VideoTutorialPage({super.key});

  @override
  State<VideoTutorialPage> createState() => _VideoTutorialPageState();
}

class _VideoTutorialPageState extends State<VideoTutorialPage> {
  late TextEditingController _searchController;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Video Tutorials',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {}); // Refresh the UI when the text changes
                  },
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          30.0), // Adjust the radius as needed
                    ),
                  ),
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('videos')
                    .where('name',
                    isGreaterThanOrEqualTo: _searchController.text)
                    .where('name', isLessThan: _searchController.text + 'z')
                    .snapshots(),
                builder: (context, snapshot) {
                  List<Widget> videoWidgets = [];
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    final videos = snapshot.data?.docs.reversed.toList();
                    for (var video in videos!) {
                      final videoWidget = Column(
                        children: [
                          SizedBox(height: 16), // Add space between rows
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      width: 180,
                                      height: 115,
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.network(
                                              video['imageURL'],
                                              fit: BoxFit.cover,
                                              width: double.maxFinite,
                                              height: 110,
                                            ),
                                          ),
                                          Positioned(
                                            top: 25, // Adjust the position of the icon as needed
                                            left: 55,
                                            child: IconButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (_) {
                                                        return PlayVideo(
                                                          videoName: video['name'],
                                                          videoURL: video['videoURL'],
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.play_circle_fill, // Choose the icon you want
                                                  size: 50, // Adjust the size of the icon as needed
                                                  color: Colors.white, // Adjust the color of the icon as needed
                                                )
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          video['name'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold, // Make the text bold
                                            fontSize: 13, // Increase the font size
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                      videoWidgets.add(videoWidget);
                    }
                  }
                  return Expanded(
                    child: ListView(
                      children: videoWidgets,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
