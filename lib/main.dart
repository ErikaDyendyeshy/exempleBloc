import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:parallel/app_binding.dart';
import 'package:parallel/route/app_pages.dart';
import 'package:parallel/style/theme.dart';
import 'package:parallel/translation/translation.dart';

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await _setupFlutterNotifications();
  showFlutterNotification(message);
}

Future<void> _setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) async {
  await flutterLocalNotificationsPlugin.show(
    1,
    message.notification?.title,
    message.notification?.body,
    NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        icon: 'launch_background',
      ),
    ),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.setAutoInitEnabled(false);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    const Parallel(),
  );
}

class Parallel extends StatelessWidget {
  const Parallel({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppPages.initial,
      initialBinding: AppBinding(),
      getPages: AppPages.routes,
      locale: const Locale('en'),
      fallbackLocale: const Locale('en', 'US'),
      theme: lightTheme,
      translations: Translation(),
      debugShowCheckedModeBanner: false,
    );
  }
}
