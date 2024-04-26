import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuizesPage extends StatefulWidget {
  const QuizesPage({super.key});

  @override
  State<QuizesPage> createState() => _QuizesPageState();
}

class _QuizesPageState extends State<QuizesPage> {
  int? _selectedAnswer1;
  int? _selectedAnswer2;
  int? _selectedAnswer3;
  int? _selectedAnswer4;
  int? _selectedAnswer5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quizzes",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Answer the following questions and hit the find button, \nwe\'ll recommend the craft that best fits your needs.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Example question and answers
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: QuestionAndAnswer(
                      question: '1.	Which of the following materials are you most interested in working with?',
                      answers: ['Fabric and textiles', 'Wood and metal', 'Beads and gemstones'],
                      selectedAnswer: _selectedAnswer1,
                      onChanged: (index) {
                        setState(() {
                          _selectedAnswer1 = index;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: QuestionAndAnswer(
                      question: '2.	How much experience do you have in crafting?',
                      answers: ['Beginner - I\'m just starting out and looking to learn the basics', 'Intermediate - I have some experience and want to expand my skills', 'Advanced - I\'m looking for more challenging projects to refine my expertise'],
                      selectedAnswer: _selectedAnswer2,
                      onChanged: (index) {
                        setState(() {
                          _selectedAnswer2 = index;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: QuestionAndAnswer(
                      question: '3.	What is your primary motivation for learning a new craft?',
                      answers: ['Relaxation and stress relief', 'Personal expression and creativity', 'Skill development and mastery'],
                      selectedAnswer: _selectedAnswer3,
                      onChanged: (index) {
                        setState(() {
                          _selectedAnswer3 = index;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: QuestionAndAnswer(
                      question: '4.	Are you interested in learning traditional crafts or more contemporary techniques?',
                      answers: ['Traditional', 'Contemporary', 'Both'],
                      selectedAnswer: _selectedAnswer4,
                      onChanged: (index) {
                        setState(() {
                          _selectedAnswer4 = index;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: QuestionAndAnswer(
                      question: '5.	What is your budget for investing in a craft learning package?',
                      answers: ['Low (less than LKR:500)', 'Moderate (LKR:600 - LKR:1500)', 'High (more than LKR:1500)'],
                      selectedAnswer: _selectedAnswer5,
                      onChanged: (index) {
                        setState(() {
                          _selectedAnswer5 = index;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                // Show a dialog when the button is pressed
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Suggestions'),
                      content: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('videos').snapshots(),
                          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator(); // Show a loading indicator while fetching data
                            }
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}'); // Show an error message if snapshot has error
                            }
                            // Extracting data from snapshot
                            final List<DocumentSnapshot> documents = snapshot.data!.docs;
                            return Container(
                              height: 150,
                              child: Column(
                                children: [
                                  if (_selectedAnswer1 == 0 && _selectedAnswer2 == 0) // Check if the first answer is selected
                                    TextButton(
                                      onPressed: () {
                                        // Get.to(const ProductDescriptionPage(), arguments: {'data': documents[1]}); // Close the dialog
                                      },
                                      child: Text('Knitting and Crocheting'),
                                    ),
                                  if (_selectedAnswer1 == 0 && _selectedAnswer2 == 0)
                                    TextButton(
                                      onPressed: () {
                                        // Get.to(const ProductDescriptionPage(), arguments: {'data': documents[2]}); // Close the dialog
                                      },
                                      child: Text('Knitting'),
                                    ),
                                  if (_selectedAnswer1 == 0 && _selectedAnswer2 == 0)
                                    TextButton(
                                      onPressed: () {
                                        // Get.to(const ProductDescriptionPage(), arguments: {'data': documents[4]}); // Close the dialog
                                      },
                                      child: Text('Knitting and Crochetting (Beginner)'),
                                    ),
                                  if (_selectedAnswer1 == 0 && _selectedAnswer2 == 2)
                                    TextButton(
                                      onPressed: () {
                                        // Get.to(const ProductDescriptionPage(), arguments: {'data': documents[3]}); // Close the dialog
                                      },
                                      child: Text('Batik(Advanced)'),
                                    ),
                                  if (_selectedAnswer1 == 1 && _selectedAnswer2 == 2) // Check if the third answer is selected
                                    TextButton(
                                      onPressed: () {
                                        // Get.to(const ProductDescriptionPage(), arguments: {'data': documents[0]}); // Close the dialog
                                      },
                                      child: Text('Jewellery (Advanced)'),
                                    ),
                                ],
                              ),
                            );
                          }
                      ), // Message displayed in the popup
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffebd9b4),
              ),
              child: Text(
                'Find',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionAndAnswer extends StatelessWidget {
  final String question;
  final List<String> answers;
  final int? selectedAnswer;
  final ValueChanged<int?>? onChanged; // Update the type to ValueChanged<int?>?

  const QuestionAndAnswer({
    required this.question,
    required this.answers,
    required this.selectedAnswer,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          children: List.generate(
            answers.length,
                (index) => RadioListTile<int>(
              value: index,
              groupValue: selectedAnswer,
              onChanged: onChanged != null ? (int? value) => onChanged!(value) : null, // Check if onChanged is not null before calling it
              title: Text(
                answers[index],
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
