import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/feature/auth/cubit/auth_cubit.dart';
import 'package:frontend/feature/auth/pages/signup_page.dart';
import 'package:frontend/feature/home/cubit/task_cubit.dart';
import 'package:frontend/feature/home/pages/home_page.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => TaskCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
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
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Lato",
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(20),
          enabledBorder: MyApp.inputBorder,
          focusedBorder: MyApp.inputBorder,
          border: MyApp.inputBorder,

          // error state
          errorBorder: MyApp.errorInputBorder,
          focusedErrorBorder: MyApp.errorInputBorder,
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
      home: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoggedIn) {
            return const HomePage();
          }
          return const SignupPage();
        },
      ),
    );
  }
}
