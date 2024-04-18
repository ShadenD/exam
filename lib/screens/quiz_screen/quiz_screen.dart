// ignore_for_file: use_super_parameters, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app/controllers/quiz_controller.dart';
import 'package:quize_app/widgets/custom_button.dart';
import 'package:quize_app/widgets/progress_timer.dart';
import 'package:quize_app/widgets/question_card.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);
  static const routeName = '/quiz_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Colors.black87),
          ),
          SafeArea(
            child: GetBuilder<QuizController>(
              init: QuizController(),
              builder: (controller) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: 'Question ',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: Colors.white),
                              children: [
                                TextSpan(
                                  text: controller.numberOfQuestion
                                      .round()
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(color: Colors.white),
                                ),
                                TextSpan(
                                  text: '/',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(color: Colors.white),
                                ),
                                TextSpan(
                                  text: controller.countOfQuestion.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ProgressTimer(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 450,
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => QuestionCard(
                          questionModel: controller.questionsList[index],
                        ),
                        controller: controller.pageController,
                        itemCount: controller.questionsList.length,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    "assets/images/shf.png",
                    height: 250,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: GetBuilder<QuizController>(
        init: QuizController(),
        builder: (controller) => CustomButton(
            onPressed: () => controller.nextQuestion(), text: 'Next'),
      ),
    );
  }
}
