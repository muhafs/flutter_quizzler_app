import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(const Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  Expanded buildButton({
    required String text,
    MaterialColor? color = Colors.blue,
    required bool value,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextButton(
          onPressed: () {
            bool correctAnswer = quizBrain.getAnswer();

            setState(() {
              if (quizBrain.isFinished()) {
                Alert(
                  context: context,
                  title: "Horray!",
                  desc: "you have finished all the quiz !",
                  buttons: [
                    DialogButton(
                      onPressed: () => Navigator.pop(context),
                      width: 120,
                      child: const Text(
                        "Play Again",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ],
                ).show();

                quizBrain.resetQuiz();
                scoreKeeper.clear();
              } else {
                if (correctAnswer == value) {
                  scoreKeeper.add(
                    const Icon(Icons.check, color: Colors.green),
                  );
                } else {
                  scoreKeeper.add(
                    const Icon(Icons.close, color: Colors.red),
                  );
                }

                quizBrain.getNextQuestion();
              }
            });
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: scoreKeeper,
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestion(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildButton(text: 'True', color: Colors.green, value: true),
              buildButton(text: 'False', color: Colors.red, value: false),
            ],
          ),
        )
      ],
    );
  }
}
