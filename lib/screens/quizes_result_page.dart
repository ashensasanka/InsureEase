import 'package:flutter/material.dart';

class QuizesResultPage extends StatefulWidget {
  final int? selectedAnswer1;
  final int? selectedAnswer2;
  final int? selectedAnswer3;
  final int? selectedAnswer4;
  final int? selectedAnswer5;
  const QuizesResultPage({Key? key, required this.selectedAnswer1, required this.selectedAnswer2, required this.selectedAnswer3, required this.selectedAnswer4, required this.selectedAnswer5}) : super(key: key);

  @override
  State<QuizesResultPage> createState() => _QuizesResultPageState();
}

class _QuizesResultPageState extends State<QuizesResultPage> {
  int? _selectedAnswer1;
  int? _selectedAnswer2;
  int? _selectedAnswer3;
  int? _selectedAnswer4;
  int? _selectedAnswer5;

  @override
  Widget build(BuildContext context) {
    int correctAnswers = 0;
    if (widget.selectedAnswer1 == 3) correctAnswers++;
    if (widget.selectedAnswer2 == 3) correctAnswers++;
    if (widget.selectedAnswer3 == 2) correctAnswers++;
    if (widget.selectedAnswer4 == 0) correctAnswers++;
    if (widget.selectedAnswer5 == 0) correctAnswers++;

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
                  buildQuestionAndAnswer(
                    question: '1.	This part of auto insurance covers medical costs and property damage of the other driver if you get in a wreck and it is your fault.',
                    answers: ['Uninsured/Underinsured', 'Collision', 'Comprehensive', 'Liability'],
                    selectedAnswer: widget.selectedAnswer1,
                    onChanged: (index) {
                      setState(() {
                        _selectedAnswer1 = index;
                      });
                    },
                    activeColorIndex: 3,
                  ),
                  SizedBox(height: 20),
                  buildQuestionAndAnswer(
                    question: '2.	This type of insurance protects against damage to the car OR injury to persons in the car caused by a driver who carries no insurance.',
                    answers: ['Collision', 'Comprehensive', 'Property', 'Uninsured motorists'],
                    selectedAnswer: widget.selectedAnswer2,
                    onChanged: (index) {
                      setState(() {
                        _selectedAnswer2 = index;
                      });
                    },
                    activeColorIndex: 3,
                  ),
                  SizedBox(height: 20),
                  buildQuestionAndAnswer(
                    question: '3.	A policy is a contract between the',
                    answers: ['Policyholder and the injured person', 'Driver and the government', 'Consumer and the insurance company', 'Consumer and the insurance agent'],
                    selectedAnswer: widget.selectedAnswer3,
                    onChanged: (index) {
                      setState(() {
                        _selectedAnswer3 = index;
                      });
                    },
                    activeColorIndex: 2,
                  ),
                  SizedBox(height: 20),
                  buildQuestionAndAnswer(
                    question: '4.	Which of the following wouldn\'t save you money on your auto insurance premium?',
                    answers: ['Decrease your deductible', 'Reduce or eliminate optional insurance on an older vehicle', 'Maintain a good credit history', 'Bundle your insurance with other policies'],
                    selectedAnswer: widget.selectedAnswer4,
                    onChanged: (index) {
                      setState(() {
                        _selectedAnswer4 = index;
                      });
                    },
                    activeColorIndex: 0,
                  ),
                  SizedBox(height: 20),
                  buildQuestionAndAnswer(
                    question: '5.	A type of car insurance that covers damage to your own motor vehicle if involved in a crash with another vehicle, an animal, an object, etc.',
                    answers: ['Collision', 'Comprehensive', 'Bodily injury', 'Uninsured motorist'],
                    selectedAnswer: widget.selectedAnswer5,
                    onChanged: (index) {
                      setState(() {
                        _selectedAnswer5 = index;
                      });
                    },
                    activeColorIndex: 0,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 10, // Set the desired height
            child: LinearProgressIndicator(
              value: correctAnswers / 5, // Assuming there are 5 questions
              backgroundColor: Colors.red,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
          Text('${(correctAnswers / 5)*100} %',style: TextStyle(fontSize: 20),),
          SizedBox(height: 5),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //         context,
                //         PageTransition(
                //           child: const NewClaimRootPage(),
                //           type: PageTransitionType.bottomToTop,
                //         ),
                //       );
                Navigator.pushNamed(context, '/videos');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffF9A130),
              ),
              child: Text(
                'Back to videos',
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

  Widget buildQuestionAndAnswer({
    required String question,
    required List<String> answers,
    required int? selectedAnswer,
    required ValueChanged<int?> onChanged,
    required int activeColorIndex,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: QuestionAndAnswer(
        question: question,
        answers: answers,
        selectedAnswer: selectedAnswer,
        onChanged: onChanged,
        activeColorIndex: activeColorIndex,
      ),
    );
  }
}

class QuestionAndAnswer extends StatelessWidget {
  final String question;
  final List<String> answers;
  final int? selectedAnswer;
  final ValueChanged<int?>? onChanged;
  final int activeColorIndex;

  const QuestionAndAnswer({
    required this.question,
    required this.answers,
    required this.selectedAnswer,
    required this.onChanged,
    required this.activeColorIndex,
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
              onChanged: onChanged != null ? (int? value) => onChanged!(value) : null,
              title: Text(
                answers[index],
                style: TextStyle(fontSize: 16),
              ),
              activeColor: selectedAnswer == activeColorIndex ? Colors.green : Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
