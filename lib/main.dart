import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app/screens/quiz_screen/quiz_screen.dart';
import 'package:quize_app/screens/result_screen/result_screen.dart';
import 'package:quize_app/screens/welcome_screen.dart';
import 'package:quize_app/util/bindings_app.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BilndingsApp(),
      title: 'Quize App',
      home: const WelcomeScreen(),
      getPages: [
        GetPage(
            name: WelcomeScreen.routeName, page: () => const WelcomeScreen()),
        GetPage(name: QuizScreen.routeName, page: () => const QuizScreen()),
        GetPage(name: ResultScreen.routeName, page: () => const ResultScreen()),
      ],
    );
  }
}
