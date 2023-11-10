import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:greenplus/app/core/controllers/auth/auth_store.dart';
import 'package:mobx/mobx.dart';

import '../infra/repository/i_login_repository.dart';
import '../models/user.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  ILoginRepository loginRepository;
  AuthStore authStore;

  LoginControllerBase(this.loginRepository, this.authStore);

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @action
  Future<void> authenticate() async {
    final String enteredUsername = usernameController.text;
    final String enteredPassword = passwordController.text;

    await authStore
        .setUsuario(User(password: enteredPassword, username: enteredUsername));

    var result = await loginRepository.loginUsername(
        username: enteredUsername, password: enteredPassword);

    result.fold(
        (erro) => showDialog(
              context:
                  Modular.routerDelegate.navigatorKey.currentState!.context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Erro de Autenticação'),
                  content: Text(erro.message ?? ''),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    )
                  ],
                );
              },
            ), (token) {
      usernameController.clear();
      passwordController.clear();
      authStore.setUserAuthentication(authStore.user?.copyWith(token: token));
      Modular.to.pushNamed('/home');
    });
  }
}
