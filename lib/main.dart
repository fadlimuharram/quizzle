import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  void insertIcon(Icon i) {
    if (!quizBrain.setScoreKeeper(i)) {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Finished!",
        desc: "you've reached the end of the quiz!",
        buttons: [
          DialogButton(
            child: Text(
              "CANCLE",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              setState(() {
                quizBrain.resetQuiz();
              });

              Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
    }
  }

  void checkAnswer(bool userPickedAnswer) {
    setState(() {
      bool correctAnswer = quizBrain.getQuestionAnswer();

      if (correctAnswer == userPickedAnswer) {
        insertIcon(Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        insertIcon(Icon(
          Icons.close,
          color: Colors.red,
        ));
      }

      quizBrain.nextQuestion();
    });
  }

//  List<String> questions = [
//    'You can lead a cow down stairs but not upstairs.',
//    'Approximately one querter of human bones are in the feet.',
//    'A Slug\'s blood is green'
//  ];
//
//  List<bool> answers = [false, true, true];
//
//  List<Question> questionsBank = [
//    Question(q: 'You can lead a cow down stairs but not upstairs.', a: false),
//    Question(
//        q: 'Approximately one querter of human bones are in the feet.',
//        a: true),
//    Question(q: 'A Slug\'s blood is green', a: true)
//  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.

                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper
        Row(
          children: quizBrain.scoreKeeper,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
