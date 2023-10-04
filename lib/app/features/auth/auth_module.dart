import 'package:flutter_modular/flutter_modular.dart';

import 'login/login_module.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes =>
      [
        ModuleRoute("/login", module: LoginModule())
      ];
}
