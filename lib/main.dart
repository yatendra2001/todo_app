import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:todo_app/repository/auth/auth_repo.dart';
import 'package:todo_app/screens/login_screen.dart';
import 'package:todo_app/screens/todo_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthRepo _authRepo = AuthRepo();
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: _authRepo.sessionManager.isLoggedIn,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data ?? false) {
              return TodoScreen();
            } else {
              return const LoginScreen();
            }
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
