import 'package:aspirant_minds/buttons_UI/text_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Quiz extends StatefulWidget {
  const Quiz(this.switchScreen, {super.key, required this.pageName});

  final String pageName;
  final void Function(String screenName) switchScreen;

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  int _currentIndex = 0;
  int _totalScore = 0;
  bool isCompleted = false;
  int? _selectedAnswer;
  List<dynamic> quizData = [];

  @override
  void initState() {
    super.initState();
    fetchQuizData();
  }

  void fetchQuizData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _quizData = json.decode(prefs.getString('quiz_data') ?? "");
    print("inside fetchQuiz : $_quizData");
    if (_quizData.length > 0) {
      setState(() {
        quizData = _quizData;
      });
    }
  }

  void _checkAnswer() {
    if (_selectedAnswer ==
        (quizData.elementAt(_currentIndex)['correctIndex'] ?? "")) {
      _totalScore++;
    }
    if (_currentIndex < quizData.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedAnswer = null;
      });
    } else {
      _showResult();
    }
  }

  void _showResult() {
    setState(() {
      isCompleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.90,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.90,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: isCompleted
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.check_circle_rounded,
                              color: Colors.green, size: 100),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Quiz completed!',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                              color: const Color.fromRGBO(240, 130, 0, 1),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'You scored $_totalScore out of ${quizData.length}',
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              widget.switchScreen("course_details");
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(240, 130, 0, 1),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: const BorderSide(
                                      color: Color.fromRGBO(240, 130, 0, 1)),
                                ),
                              ),
                            ),
                            child: const Text(
                              "Submit",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          quizData.elementAt(_currentIndex)['question'] ?? "",
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        ...(quizData.elementAt(_currentIndex)['answers'] ??
                                "" as List<dynamic>)
                            .asMap()
                            .entries
                            .map(
                          (entry) {
                            int index = entry.key;
                            String answer = entry.value;
                            return RadioListTile(
                              value: index,
                              groupValue: _selectedAnswer,
                              activeColor: const Color.fromRGBO(240, 130, 0, 1),
                              onChanged: (value) {
                                setState(() {
                                  _selectedAnswer = value as int;
                                });
                              },
                              title: Text(
                                answer,
                                style: TextStyle(fontSize: 18),
                              ),
                            );
                          },
                        ).toList(),
                        const SizedBox(height: 20),
                        TxtButton(
                          buttonText: 'Submit',
                          btnColor: const Color.fromRGBO(240, 130, 0, 1),
                          txtColor: Colors.white,
                          borderColor: Colors.grey,
                          isIconBtn: false,
                          onClick:
                              _selectedAnswer == null ? () {} : _checkAnswer,
                          width: 0.4,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
