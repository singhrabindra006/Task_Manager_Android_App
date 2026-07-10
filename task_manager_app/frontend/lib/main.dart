import 'package:flutter/material.dart';
import 'package:frontend/feature/auth/pages/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final inputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
    borderRadius: BorderRadius.circular(10),
  );

  static final errorInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.red, width: 1.5),
    borderRadius: BorderRadius.circular(10),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(20),
          enabledBorder: inputBorder,
          focusedBorder: inputBorder,
          border: inputBorder,

          // error state
          errorBorder: errorInputBorder,
          focusedErrorBorder: errorInputBorder,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            minimumSize: const Size(double.infinity, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        useMaterial3: true,
      ),
      home: const SignupPage(),
    );
  }
}
