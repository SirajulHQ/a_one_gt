import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/features/category/view/categories_page.dart';
import 'package:a_one_gt/features/auth/view/create_accout_page.dart';
import 'package:a_one_gt/features/auth/view/email_Signin_Page.dart';
import 'package:a_one_gt/features/auth/view/forgot_Password.dart';
import 'package:a_one_gt/features/auth/view/password_Signin_Page.dart';
import 'package:a_one_gt/features/auth/view/splash_screen.dart';
import 'package:a_one_gt/features/home/view/home_page.dart';
import 'package:a_one_gt/features/main_navigation/main_navigation_widget.dart';
import 'package:a_one_gt/features/cart/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),

      routes: {
        '/email': (context) => const EmailSigninPage(),
        '/password': (context) => const PasswordSigninPage(),
        '/forgot_password': (context) => const ForgotPasswordPage(),
        '/create_account': (context) => const CreateAccountPage(),
        '/categories': (context) => const CategoriesPage(),
        '/main_navigation': (context) => const MainNavigationPage(),
        '/home': (context) => const HomePage(category: "All"),
      },

      home: Builder(
        builder: (context) {
          Dimensions.init(context);
          return const SplashScreen();
        },
      ),
    );
  }
}
