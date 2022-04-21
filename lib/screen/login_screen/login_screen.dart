import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup Screen"),
      ),
      body: Form(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0,
              ),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,

                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  hintText: 'Enter email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0,
              ),
              child: TextFormField(
                keyboardType: TextInputType.text,
                obscureText: true,

                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  hintText: 'Enter password',
                ),
              ),
            ),
            RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                color: Colors.orange,
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                ),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
