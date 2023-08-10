import 'package:get/get.dart';

import 'package:parallel/route/__.dart';
import 'package:parallel/route/app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = RoutePaths.firstPage;

  static final routes = [
    //====================================
    GetPage(
      name: RoutePaths.firstPage,
      page: () => const FirstPageScreen(),
      binding: FirstPageBinding(),
    ),
    GetPage(
      name: RoutePaths.main,
      page: () => const MainScreen(),
      binding: MainBinding(),
    ),

    //====================================auth
    GetPage(
      name: RoutePaths.signUp,
      page: () => const SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: RoutePaths.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: RoutePaths.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: RoutePaths.signUpCompleted,
      page: () => const SignUpCompletedScreen(),
      binding: SignUpCompleteBinding(),
    ),

    //====================================feed
    GetPage(
      name: RoutePaths.feed,
      page: () => const FeedScreen(),
      binding: FeedBinding(),
    ),

    //=====================================chat
    GetPage(
      name: RoutePaths.chatList,
      page: () => const ChatListScreen(),
      binding: ChatListBinding(),
    ),

    //=====================================notifications
    GetPage(
      name: RoutePaths.notificationList,
      page: () => const NotificationListScreen(),
      binding: NotificationListBinding(),
    ),

    //====================================profile
    GetPage(
      name: RoutePaths.profile,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: RoutePaths.editProfile,
      page: () => const EditProfileScreen(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: RoutePaths.changeEmail,
      page: () => const ChangeEmailScreen(),
      binding: ChangeEmailBinding(),
    ),
    GetPage(
      name: RoutePaths.changePassword,
      page: () => const ChangePasswordScreen(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: RoutePaths.createPost,
      page: () => const CreatePostScreen(),
      binding: CreatePostBinding(),
    ),
    GetPage(
      name: RoutePaths.editPost,
      page: () => const EditPostScreen(),
      binding: EditPostBinding(),
    ),
    GetPage(
      name: RoutePaths.otherProfile,
      page: () => const OtherProfileScreen(),
      binding: OtherProfileBinding(),
    ),
    GetPage(
      name: RoutePaths.connectionList,
      page: () => const ConnectionListScreen(),
      binding: ConnectionListBinding(),
    ),

    //====================================search
    GetPage(
      name: RoutePaths.search,
      page: () => const SearchScreen(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: RoutePaths.smartDesires,
      page: () => const SmartDesiresScreen(),
      binding: SmartDesiresBinding(),
    ),
    GetPage(
      name: RoutePaths.smartSearch,
      page: () => const SmartSearchScreen(),
      binding: SmartSearchBinding(),
    ),

    //====================================setting
    GetPage(
      name: RoutePaths.setting,
      page: () => const SettingScreen(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: RoutePaths.termsPrivacyPolicy,
      page: () => const TermsPrivacyPolicyScreen(),
      binding: TermsPrivacyPolicyBinding(),
    ),
    GetPage(
      name: RoutePaths.notificationSettings,
      page: () => const NotificationSettingsScreen(),
      binding: NotificationSettingsBinding(),
    ),
    GetPage(
      name: RoutePaths.supportEmail,
      page: () => const SupportEmailScreen(),
      binding: SupportEmailBinding(),
    ),

    //====================================personalized question
    GetPage(
      name: RoutePaths.personalizedQuestions,
      page: () => const PersonalizedQuestionsScreen(),
      binding: PersonalizedQuestionsBinding(),
    ),
    //====================================posts
    GetPage(
      name: RoutePaths.postDetail,
      page: () => PostDetailScreen(),
      binding: PostDetailBinding(),
    ),
  ];
}
