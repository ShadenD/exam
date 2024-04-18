// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app/models/question_model.dart';
import 'package:quize_app/screens/result_screen/result_screen.dart';
import 'package:quize_app/screens/welcome_screen.dart';

class QuizController extends GetxController {
  String name = '';
  int get countOfQuestion => questionsList.length;
  final List<QuestionModel> questionsList = [
    QuestionModel(
      id: 1,
      question:
          "To access properties of an object, the mouse technique to use is?",
      answer: 1,
      options: [
        ' right-clicking '
            'shift-clicking '
            'dragging'
            'dropping '
      ],
    ),
    QuestionModel(
      id: 2,
      question: "Best State Mangment Ststem is ",
      answer: 1,
      options: ['BloC', 'GetX', 'Provider', 'riverPod'],
    ),
    QuestionModel(
      id: 3,
      question: "Best Flutter dev",
      answer: 2,
      options: ['sherif', 'sherif ahmed', 'ahmed sherif', 'doc sherif'],
    ),
    QuestionModel(
      id: 4,
      question: "Sherif is",
      answer: 1,
      options: ['eng', 'Doc', 'eng/Doc', 'Doc/Eng'],
    ),
    QuestionModel(
      id: 5,
      question: "Best Rapper in Egypt",
      answer: 3,
      options: ['Eljoker', 'Abyu', 'R3', 'All of the above'],
    ),
    QuestionModel(
      id: 6,
      question: "Real Name of ahmed sherif",
      answer: 2,
      options: ['ahmed sherif', 'sherif', 'Haytham', 'NONE OF ABOVE'],
    ),
    QuestionModel(
      id: 7,
      question: "Sherif love",
      answer: 3,
      options: ['Pharma', 'Micro', 'Medicnal', 'NONE OF ABOVE'],
    ),
    QuestionModel(
      id: 8,
      question: "hello",
      answer: 3,
      options: ['hello', 'hi', 'hola', 'Suiiiiiiiiiiii'],
    ),
    QuestionModel(
      id: 9,
      question: "Best Channel for Flutter ",
      answer: 2,
      options: [
        'Sec it',
        'Sec it developer',
        'sec it developers',
        'mesh sec it '
      ],
    ),
    QuestionModel(
      id: 10,
      question: "Best State Mangment Ststem is ",
      answer: 1,
      options: ['BloC', 'GetX', 'Provider', 'riverPod'],
    ),
  ];

  bool isPressed = false;
  double numberOfQuestion = 1;
  int? selectAnswer;
  int? correctAnswer;
  int countOfCorrectAnswers = 0;
  final Map<int, bool> _questionIsAnswerd = {};
  late PageController pageController;
  Timer? timer;
  final maxSec = 15;
  final RxInt second = 15.obs;

  @override
  void onInit() {
    pageController = PageController(initialPage: 1);
    resetAnswer();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  double get scoreResult {
    return countOfCorrectAnswers * 100 / questionsList.length;
  }

  void checkAnswer(QuestionModel questionModel, int selectAnswer1) {
    isPressed = true;
    selectAnswer = selectAnswer1;
    correctAnswer = questionModel.answer;

    if (correctAnswer == selectAnswer) {
      countOfCorrectAnswers++;
    }
    stopTimer();
    _questionIsAnswerd.update(questionModel.id, (value) => true);
    Future.delayed(const Duration(milliseconds: 500))
        .then((value) => nextQuestion());
    update();
  }

  bool checkIsQuestionAnswered(int quesId) {
    return _questionIsAnswerd.entries
        .firstWhere((element) => element.key == quesId)
        .value;
  }

  void nextQuestion() {
    if (timer != null || timer!.isActive) {
      stopTimer();
    }

    if (pageController.page == questionsList.length - 1) {
      Get.offAndToNamed(ResultScreen.routeName);
    } else {
      isPressed = false;
      pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
      startTimer();
    }
    numberOfQuestion = pageController.page! + 1;
    print('number of page index:  ${pageController.page!}');
    update();
  }

  void resetAnswer() {
    for (var element in questionsList) {
      _questionIsAnswerd.addAll({element.id: false});
    }
    update();
  }

  //get right and wrong color
  Color getColor(int answerIndex) {
    if (isPressed) {
      if (answerIndex == correctAnswer) {
        return Colors.green.shade700;
      } else if (answerIndex == selectAnswer && correctAnswer != selectAnswer) {
        return Colors.red.shade700;
      }
    }
    return Colors.white;
  }

  //het right and wrong icon
  IconData getIcon(int answerIndex) {
    if (isPressed) {
      if (answerIndex == correctAnswer) {
        return Icons.done;
      } else if (answerIndex == selectAnswer && correctAnswer != selectAnswer) {
        return Icons.close;
      }
    }
    return Icons.close;
  }

  void startTimer() {
    resetTimer();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (second.value > 0) {
        second.value--;
      } else {
        stopTimer();
        nextQuestion();
      }
    });
  }

  void resetTimer() => second.value = maxSec;
  void stopTimer() => timer!.cancel();
  void startAgain() {
    correctAnswer = null;
    numberOfQuestion = 1;
    countOfCorrectAnswers = 0;
    resetAnswer();
    selectAnswer = null;
    Get.offAllNamed(WelcomeScreen.routeName);
  }
}
