import 'package:get/get.dart';
import 'package:parallel/route/app_routes.dart';
import 'package:parallel/util/mixin/get_self_profile_mixin.dart';

class FirsPageController extends GetxController with GetSelfProfileMixin {
  final RxBool isShowLoginButtons = false.obs;

  @override
  void onReady() {
    super.onReady();
    _getSelfProfile();
  }

  void _getSelfProfile() async {
    Future.delayed(const Duration(seconds: 2)).then(
      (value) => getUserMe().then(
        (value) {
          if (selfProfile.value != null) {
            Get.toNamed(RoutePaths.main);
          } else {
            isShowLoginButtons.value = true;
          }
        },
      ).catchError(
        (exception) {
          isShowLoginButtons.value = true;
        },
      ),
    );
  }

  void onSignUp() {
    Get.toNamed(
      RoutePaths.signUp,
    );
  }

  void onLogin() {
    Get.toNamed(
      RoutePaths.login,
    );
  }
}
