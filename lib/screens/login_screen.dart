import 'package:flutter/material.dart';
import 'package:todo_app/repository/auth/auth_repo.dart';
import 'package:todo_app/screens/todo_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final AuthRepo _authRepo = AuthRepo();

  bool isSignUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isSignUp ? "Sign Up" : "Sign In"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSignUp)
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (isSignUp) {
                  await _authRepo.signUpWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                      name: _nameController.text);
                } else {
                  await _authRepo.signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text);

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TodoScreen(),
                    ),
                  );
                }
              },
              child: Text(isSignUp ? "Sign Up" : "Sign In"),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                setState(() {
                  isSignUp = !isSignUp;
                });
              },
              child: Text(isSignUp
                  ? "Already have an account? Sign In"
                  : "Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
