import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/model/answer_model.dart';
import 'package:parallel/_data/model/model/question_model.dart';
import 'package:parallel/const.dart';
import 'package:parallel/module/personalized_questions/personalized_questions_controller.dart';
import 'package:parallel/style/app_colors.dart';
import 'package:parallel/widget/__.dart';
import 'package:parallel/widget/p_list_view_widget.dart';

class PersonalizedQuestionsScreen extends GetView<PersonalizedQuestionsController> {
  const PersonalizedQuestionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Obx(
            () => controller.current == 6
                ? Text('txt_sign_up'.tr.capitalizeFirst!)
                : Text('${controller.current} ${'txt_of'.tr} ${controller.total}',
                    style: Get.theme.textTheme.headlineMedium),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: InkWell(
                onTap: () => controller.submitAnswers(),
                child: Row(
                  children: [
                    Obx(
                      () => controller.current == 6
                          ? const SizedBox.shrink()
                          : Text(
                              'txt_skip'.tr.capitalizeFirst!,
                              style: Get.theme.textTheme.labelLarge!.copyWith(fontSize: 14),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
      body: Obx(
        () => controller.questionRx.isEmpty
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : PageView.builder(
                onPageChanged: controller.onQuestionChanged,
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.pageController,
                itemCount: controller.questionRx.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index < controller.questionRx.length) {
                    final QuestionModel question = controller.questionRx[index];
                    if (question.answers.isEmpty) {
                      return _buildFreeTextQuestion(question);
                    } else {
                      return _buildQuestionWithAnswers(question);
                    }
                  } else if (index == controller.questionRx.length) {
                    return finishedQuestion();
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
      ),
    );
  }

  Widget _buildFreeTextQuestion(QuestionModel question) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: horizontalPaddingScreen,
      ),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Text(
            question.question,
            style: Get.theme.textTheme.headlineLarge,
          ),
          const SizedBox(height: 34),
          Expanded(
            child: PInputTextFieldWidget(
              maxLines: 10,
              onChanged: (value) {
                if (question.answers.isEmpty) {
                  final index = controller.questionRx.indexOf(question);
                  if (index != -1) {
                    if (index >= controller.freeTextAnswers.length) {
                      final additionalCount = index - controller.freeTextAnswers.length + 1;
                      for (int i = 0; i < additionalCount; i++) {
                        controller.freeTextAnswers.add('');
                      }
                    }
                    controller.freeTextAnswers[index] = value;
                  }
                }
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Obx(
                  () => PButtonWidget(
                    text: controller.current == 5
                        ? 'txt_continue'.tr
                        : 'txt_next'.tr.capitalizeFirst!,
                    onPressed: controller.current == 5
                        ? controller.submitAnswers
                        : controller.goToNextPage,
                  ),
                ),
                const SizedBox(height: 16),
                if (controller.current != 1)
                  PButtonWidget(
                    colorTrascparent: true,
                    text: 'txt_previous'.tr,
                    onPressed: controller.goToPreviousPage,
                  ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionWithAnswers(QuestionModel question) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 16,
      ),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Text(
            question.question,
            style: Get.theme.textTheme.headlineLarge,
          ),
          const SizedBox(height: 34),
          Expanded(
            child: PListViewWidget(
              count: question.answers.length,
              onBuildItem: (index) {
                question.answers[index].questionId = question.id;
                return itemAnswer(question.answers[index]);
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Obx(
                  () => PButtonWidget(
                    text: controller.current == 5
                        ? 'txt_continue'.tr
                        : 'txt_next'.tr.capitalizeFirst!,
                    onPressed: controller.goToNextPage,
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => controller.current != 1
                      ? PButtonWidget(
                          colorTrascparent: true,
                          text: 'txt_previous'.tr,
                          onPressed: controller.goToPreviousPage,
                        )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemAnswer(AnswerModel answer) {
    return Obx(
      () => GestureDetector(
        onTap: () => controller.toggleAnswerSelection(answer),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 19,
          ),
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.onBackground,
            borderRadius: BorderRadius.circular(14),
            gradient: controller.isAnswerSelected(answer)
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.pink.withOpacity(0.1), AppColors.blue.withOpacity(0.2)],
                  )
                : null,
          ),
          child: Obx(
            () => Row(
              children: [
                if (controller.isAnswerSelected(answer)) const PSVGIcon(icon: 'icon_check'),
                const SizedBox(width: 10),
                Text(
                  answer.answer,
                  style: Get.theme.textTheme.labelLarge!.copyWith(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget finishedQuestion() {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const PSVGIcon(
                    icon: 'icon_check_gradient',
                    height: 96,
                    width: 96,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'txt_great_job'.tr.capitalizeFirst!,
                    style: Get.theme.textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'txt_thank_you_for_helping_us'.tr.capitalizeFirst!,
                    textAlign: TextAlign.center,
                    style: Get.theme.textTheme.titleLarge!.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            PButtonWidget(
              text: 'txt_lets_begin'.tr,
              onPressed: () => controller.submitAnswers(),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
