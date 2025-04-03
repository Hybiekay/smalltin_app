import 'package:get/get.dart';
import 'package:smalltin/feature/auth/choose_field/choose_fields.dart';
import 'package:smalltin/feature/auth/password_screen.dart';
import 'package:smalltin/feature/auth/sign_in.dart';
import 'package:smalltin/feature/auth/update_password.dart';
import 'package:smalltin/feature/auth/update_username.dart';
import 'package:smalltin/feature/auth/verify_email.dart';
import 'package:smalltin/feature/contact_us/screens/contact_us.dart';
import 'package:smalltin/feature/edit_profile/screen/edit_profile.dart';
import 'package:smalltin/feature/history/screen/history.dart';
import 'package:smalltin/feature/home/home.dart';
import 'package:smalltin/feature/ladder/screen/ladder.dart';
import 'package:smalltin/feature/onboarding/screens/onboarding_screen.dart';
import 'package:smalltin/feature/questions/screens/question.dart';
import 'package:smalltin/feature/splash/splash_screen.dart';
import 'package:smalltin/feature/widget/loading_widget.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/home', page: () => const HomeScreen()),
    GetPage(name: '/', page: () => const SignInScreen()),
    GetPage(name: '/contact-us', page: () => const ContactUs()),
    GetPage(name: '/auth/sign-in', page: () => const SignInScreen()),
    GetPage(name: '/auth/login', page: () => const PasswordScreen()),
    GetPage(name: '/auth/verify-email', page: () => const VerifyEmail()),
    GetPage(name: '/auth/create-password', page: () => const CreatePassword()),
    GetPage(
        name: '/auth/confirm-password', page: () => const ComfirmPassword()),
    GetPage(name: '/auth/update-username', page: () => const UpdateName()),
    GetPage(name: '/choose-fields', page: () => const ChooseField()),
    GetPage(name: '/loading', page: () => const LoadingScreen()),
    GetPage(name: '/splash', page: () => const SplashScreen()),
    GetPage(name: '/onboarding', page: () => const OnboardingScreen()),
    GetPage(name: '/attempt-question', page: () => const Question()),
    GetPage(name: '/history', page: () => const HistoryStat()),
    GetPage(name: '/edit-profile', page: () => const EditProfile()),
    GetPage(name: '/ladder-board', page: () => const Ladder()),
  ];
}
