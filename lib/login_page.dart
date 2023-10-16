import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Here, you can perform authentication checks.
                // For simplicity, we'll assume any non-empty username and password is valid.
                final username = usernameController.text;
                final password = passwordController.text;
                if (username.isNotEmpty && password.isNotEmpty) {
                  Navigator.pushReplacementNamed(context, '/dashboard', arguments: username);
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
