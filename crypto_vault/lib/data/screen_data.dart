import 'package:crypto_vault/models/screen_model.dart';
import 'package:crypto_vault/screens/main_screens/home_screen.dart';
import 'package:crypto_vault/screens/main_screens/web_access_screen.dart';
import 'package:crypto_vault/screens/main_screens/notifications_screen.dart';
import 'package:crypto_vault/screens/main_screens/faqs_screen.dart';
import 'package:crypto_vault/screens/main_screens/settings_screen.dart';

final Map<String, ScreenModel> screens = {
  HomeScreen.screenName: ScreenModel(
    screen: HomeScreen(),
    icon: HomeScreen.icon,
  ),
  WebAccessScreen.screenName: ScreenModel(
    screen: WebAccessScreen(),
    icon: WebAccessScreen.icon,
  ),
  NotificationsScreen.screenName: ScreenModel(
    screen: NotificationsScreen(),
    icon: NotificationsScreen.icon,
  ),
  FaqsScreen.screenName: ScreenModel(
    screen: FaqsScreen(),
    icon: FaqsScreen.icon,
  ),
  SettingsScreen.screenName: ScreenModel(
    screen: SettingsScreen(),
    icon: SettingsScreen.icon,
  ),
};
