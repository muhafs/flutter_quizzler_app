import 'question.dart';

class QuizBrain {
  int _currentQuestion = 0;

  final List<Question> _quiz = [
    Question('Human has two legs.', true),
    Question('Cows usually eat meat.', false),
    Question('The birds can breath underwater.', false),
  ];

  void getNextQuestion() {
    if (_currentQuestion < _quiz.length - 1) {
      _currentQuestion++;
    }
  }

  String getQuestion() {
    return _quiz[_currentQuestion].question;
  }

  bool getAnswer() {
    return _quiz[_currentQuestion].answer;
  }

  bool isFinished() {
    if (_currentQuestion >= _quiz.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void resetQuiz() {
    _currentQuestion = 0;
  }
}
