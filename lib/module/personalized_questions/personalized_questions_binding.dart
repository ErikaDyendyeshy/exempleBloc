import 'package:get/get.dart';
import 'package:parallel/module/personalized_questions/personalized_questions_controller.dart';

class PersonalizedQuestionsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalizedQuestionsController>(() => PersonalizedQuestionsController());
  }
}
