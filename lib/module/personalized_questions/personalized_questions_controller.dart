import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/model/answer_model.dart';
import 'package:parallel/_data/model/model/question_model.dart';
import 'package:parallel/_domain/repository/abstract/profile_repository.dart';
import 'package:parallel/route/app_routes.dart';

class PersonalizedQuestionsController extends GetxController {
  final ProfileRepository _profileRepository = Get.find();

  late PageController pageController;
  final RxInt selectedPageIndex = 0.obs;

  final RxList<QuestionModel> questions = RxList<QuestionModel>([]);
  final RxList<AnswerModel> selectedAnswers = RxList<AnswerModel>([]);
  final RxList<String> freeTextAnswers = RxList<String>([]);

  final RxList<QuestionModel> questionRx = RxList.empty();

  PersonalizedQuestionsController() {
    pageController = PageController();
  }

  @override
  void onInit() {
    super.onInit();
    getQuestionsList();
  }

  void getQuestionsList() {
    _profileRepository.getQuestionsList().then((List<QuestionModel> question) {
      questionRx.value = question;
    });
  }

  void onQuestionChanged(int index) {
    selectedPageIndex.value = index;
  }

  bool isAnswerSelected(AnswerModel answer) {
    return selectedAnswers.contains(answer);
  }

  void goToPreviousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void toggleAnswerSelection(AnswerModel answer) {
    if (isAnswerSelected(answer)) {
      selectedAnswers.remove(answer);
    } else {
      selectedAnswers.add(answer);
    }
  }

  void submitAnswers() {
    final List<Map<String, dynamic>> answersList = [];

    for (final answer in selectedAnswers) {
      final Map<String, dynamic> answerData = {
        'question_id': answer.questionId,
        'answer': answer.answer,
      };
      answersList.add(answerData);
    }

    for (int i = 0; i < questionRx.length; i++) {
      final questionId = questionRx[i].id;

      if (i < freeTextAnswers.length) {
        final freeTextAnswer = freeTextAnswers[i];
        if (freeTextAnswer.isNotEmpty) {
          final Map<String, dynamic> freeTextAnswerData = {
            'question_id': questionId,
            'answer': freeTextAnswer,
          };
          answersList.add(freeTextAnswerData);
        }
      }
    }

    _profileRepository.submitAnswers(answersList: answersList).then((value) {
      Get.offAndToNamed(RoutePaths.main);
    });
  }

  void goToNextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  int get total => questionRx.length;

  int get current => selectedPageIndex.value + 1;
}
