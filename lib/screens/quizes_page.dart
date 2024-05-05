import 'package:app/screens/quizes_result_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Example question and answers
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: QuestionAndAnswer(
                      question:
                          '1.	This part of auto insurance covers medical costs and property damage of the other driver if you get in a wreck and it is your fault.',
                      answers: [
                        'Uninsured/Underinsured',
                        'Collision',
                        'Comprehensive',
                        'Liability'
                      ],
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
                      question:
                          '2.	This type of insurance protects against damage to the car OR injury to persons in the car caused by a driver who carries no insurance.',
                      answers: [
                        'Collision',
                        'Comprehensive',
                        'Property',
                        'Uninsured motorists'
                      ],
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
                      question: '3.	A policy is a contract between the',
                      answers: [
                        'Policyholder and the injured person',
                        'Driver and the government',
                        'Consumer and the insurance company',
                        'Consumer and the insurance agent'
                      ],
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
                      question:
                          '4.	Which of the following wouldn\'t save you money on your auto insurance premium?',
                      answers: [
                        'Decrease your deductible',
                        'Reduce or eliminate optional insurance on an older vehicle',
                        'Maintain a good credit history',
                        'Bundle your insurance with other policies'
                      ],
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
                      question:
                          '5.	A type of car insurance that covers damage to your own motor vehicle if involved in a crash with another vehicle, an animal, an object, etc.',
                      answers: [
                        'Collision',
                        'Comprehensive',
                        'Bodily injury',
                        'Uninsured motorist'
                      ],
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
                Navigator.push(
                  context,
                  PageTransition(
                    child: QuizesResultPage(
                      selectedAnswer1: _selectedAnswer1,
                      selectedAnswer2: _selectedAnswer2,
                      selectedAnswer3: _selectedAnswer3,
                      selectedAnswer4: _selectedAnswer4,
                      selectedAnswer5: _selectedAnswer5,
                    ),
                    type: PageTransitionType.bottomToTop,
                  ),
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
              onChanged: onChanged != null
                  ? (int? value) => onChanged!(value)
                  : null, // Check if onChanged is not null before calling it
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
