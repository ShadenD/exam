// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app/controllers/quiz_controller.dart';
import '../constants.dart';



class ProgressTimer extends StatelessWidget {
  ProgressTimer({super.key});
  final controller = Get.find<QuizController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 50,
        width: 50,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: 1 - (controller.second.value / 15),
              color: KPrimaryColor,
              backgroundColor: Colors.grey,
              strokeWidth: 8,
            ),
            Center(
              child: Text(
                '${controller.second.value}',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: KPrimaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
