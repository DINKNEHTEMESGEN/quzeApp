import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizPage()),
                );
              },
              child: const Text('Start Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Question> questions = [
    Question(
      '(3*2)+5',
      ['21', '30', '16'],
      1,
    ),
    Question(
      'what is FDMA?',
      [
        'Frequency division multiple access',
        'Feasibility division multiple access',
        'Frequency division mobile access'
      ],
      0,
    ),
    Question(
      'What is flutter?',
      [
        ' an open-source UI (User Interface) toolkit created by Google',
        ' an open-source UI (User Interface) toolkit created by Facbook',
        ' an open-source UI (User Interface) toolkit created by Yahoo'
      ],
      0,
    ),
    Question(
      'What is operating system?',
      [
        'software program that manages computer hardware only',
        'A type of hardware',
        'software program that manages computer hardware and software resources',
      ],
      2,
    ),
    Question(
      'For what does  Ip  stands for ?',
      [
        'Input protocol',
        'Internet program',
        'Internet protocol'
      ],
      2,
    ),
  ];

  int currentQuestionIndex = 0;
  int score = 0;
  int? selectedAnswerIndex;

  void checkAnswer() {
    if (selectedAnswerIndex ==
        questions[currentQuestionIndex].correctAnswerIndex) {
      setState(() {
        score++;
      });
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResultPage(score: score, totalQuestions: questions.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        title: const Text('Flutter Quiz'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Question ${currentQuestionIndex + 1}/${questions.length}',
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              questions[currentQuestionIndex].questionText,
              style: const TextStyle(fontSize: 24, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          Column(
            children: [
              for (int i = 0;
                  i < questions[currentQuestionIndex].choices.length;
                  i++)
                RadioListTile<int>(
                  title: Text(
                    questions[currentQuestionIndex].choices[i],
                    style: const TextStyle(color: Colors.white),
                  ),
                  value: i,
                  groupValue: selectedAnswerIndex,
                  onChanged: (int? value) {
                    setState(() {
                      selectedAnswerIndex = value;
                    });
                  },
                ),
            ],
          ),
          ElevatedButton(
            onPressed: selectedAnswerIndex != null ? checkAnswer : null,
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ResultPage(
      {required this.score, required this.totalQuestions, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        title: const Text('Quiz Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Score: $score/$totalQuestions',
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Restart Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String questionText;
  final List<String> choices;
  final int correctAnswerIndex;

  Question(this.questionText, this.choices, this.correctAnswerIndex);
}
