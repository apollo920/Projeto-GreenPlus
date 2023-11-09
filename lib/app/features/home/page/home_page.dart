import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:greenplus/app/core/utils/string_extensions.dart';

import '../../../core/controllers/auth/auth_store.dart';
import '../../../core/pages/empty/empty_page.dart';
import '../../../core/widgets/buttons/custom_button_redondo.dart';
import '../../../core/widgets/buttons/expandable_fab.dart';
import '../../../core/widgets/grid_menus.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final HomeController controller;

  const HomePage({super.key, required this.controller});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.obterMenusModulos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: (Modular.get<AuthStore>().user?.isAdmin ?? false)
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () => Modular.to.pop())
              : null,
          title: const Text(
            "Opções de funcionalidades",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 27, 136, 83),
        ),
        floatingActionButton:
          ExpandableFab(
            fabButtons: [
              FabActionButton(
                icon: Icons.picture_as_pdf,
                onPressed: () =>
                  Modular.to.pushNamed('/horarios/pdfpicker'),
                title: 'Sobre o App',
              ),
              FabActionButton(
                icon: Icons.picture_as_pdf,
                onPressed: () =>
                  sair(),
                title: 'Sair',
              ),
            ],
          ),                  
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: ExactAssetImage('assets/images/aa.png'))),
            child: Center(child:
                SingleChildScrollView(child: Observer(builder: (context) {
              if (widget.controller.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (widget.controller.erro) {
                return Column(
                  children: [
                    const EmptyPage(
                      imagePath: "assets/images/server_down.svg",
                      message: "Erro ao carregar dados!",
                      isSvg: true,
                      heightPercent: 0.4,
                      subMessage: "Tente novamente mais tarde",
                      textColor: Colors.white,
                    ),
                    ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("VOLTAR")),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () => widget.controller.obterMenusModulos(),
                      child: const Text("TENTE NOVAMENTE"),
                    ),
                  ],
                );
              }
              if (widget.controller.loaded) {
                int halfLength = widget.controller.menusModulo.length <= 5 ? 5 : (widget.controller.menusModulo.length / 2).ceil();
                return GridMenus(
                    contentLine1:
                        widget.controller.menusModulo.take(halfLength).map((menu) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CustomButtonRedondo(
                            backgroundColor:
                                const Color.fromARGB(255, 49, 150, 101),
                            icon: menu.icon!.toIcon(),
                            onPressed: () {
                              Modular.to.pushNamed(menu.action ?? "/");
                            },
                            label: menu.title ?? '',
                          ));
                    }).toList(),
                    contentLine2:
                        widget.controller.menusModulo.skip(halfLength).map((menu) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CustomButtonRedondo(
                            backgroundColor:
                                const Color.fromARGB(255, 49, 150, 101),
                            icon: menu.icon!.toIcon(),
                            onPressed: () {
                              Modular.to.pushNamed(menu.action ?? "/");
                            },
                            label: menu.title ?? '',
                          ));
                    }).toList());
              }
              return Container();
            })))));
  }

  sair() {
    var senhaCorreta = "1234";
    showDialog(
  context: context,
  builder: (BuildContext context) {
    String senhaDigitada = '';
    return AlertDialog(
      title: Text('Digite a senha:'),
      content: TextFormField(
        keyboardType: TextInputType.number,
        obscureText: true,
        onChanged: (value) {
          senhaDigitada = value;
        },
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Verificar'),
          onPressed: () {
            if (senhaDigitada.toString() == senhaCorreta) {
              Navigator.pop(context);
              Modular.to.pop();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Senha correta!'),
                    content: const Text('Acesso concedido.'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Fechar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Senha incorreta!'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Fechar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ],
    );
  },
);

  }
}
