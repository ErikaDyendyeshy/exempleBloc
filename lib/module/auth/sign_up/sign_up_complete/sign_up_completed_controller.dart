import 'package:get/get.dart';
import 'package:parallel/route/app_routes.dart';

class SignUpCompletedController extends GetxController {
  void openPersonalizedQuestionScreen() {
    Get.offAllNamed(RoutePaths.personalizedQuestions);
  }

  void goToMainScreen() {
    Get.offAllNamed(RoutePaths.main);
  }
}
