import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final LoginController controller;

  const LoginPage({super.key, required this.controller});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    _removeSplashScreen();
  }
  void _removeSplashScreen() async {
    await Future.delayed(Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/aa.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Colors.white, width: 2.0),
            ),
            child: Wrap(
              children: [
                SingleChildScrollView(
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: widget.controller.usernameController,
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: widget.controller.passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              border: OutlineInputBorder(),
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                          Container(height: 60),
                          ElevatedButton(
                            onPressed: () {
                              widget.controller.authenticate();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            )
                          )
                        ]
                      )
                    )
                  )
                )
              ]
            )
          )
        )
      )
    );
  }
}
