import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:greenplus/app/core/utils/string_extensions.dart';

import '../../../core/widgets/custom_button_2.dart';
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
          title: Text("Opções de funcionalidades",
            style: TextStyle(
                color: Colors.white
            ),),
          backgroundColor: Color.fromARGB(255, 27, 136, 83),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: ExactAssetImage('assets/images/a.png'))),
          child: Center(
            child: SingleChildScrollView(child: Observer(builder: (context) {
              if (widget.controller.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (widget.controller.erro) {
                return Column(
                  children: [
                    Container(
                      color: Colors.red,
                      child: const Text("Error"),
                    ),
                    OutlinedButton(onPressed: () =>
                        widget.controller.obterMenusModulos(),
                        child: const Text("Tentar novamente"))
                  ],
                );
              }
              if (widget.controller.loaded) {
                return GridMenus(
                  contentLine1: widget.controller.menusModulo.take(3).map((
                      menu) {
                    return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: CustomButton2(
                          backgroundColor:
                          const Color.fromARGB(255, 27, 136, 83),
                          icon: menu.icon!.toIcon(),
                          onPressed: () {
                            Modular.to.pushNamed(menu.action ?? "/");
                          },
                          label: menu.title ?? '',
                        ));
                  }).toList(),
                  contentLine2: widget.controller.menusModulo.skip((widget.controller.menusModulo.length.toInt() / 2).ceil()).map((menu) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomButton2(
                          backgroundColor:
                          const Color.fromARGB(255, 27, 136, 83),
                          icon: menu.icon!.toIcon(),
                          onPressed: () {
                            Modular.to.pushNamed(menu.action ?? "/");
                          },
                          label: menu.title ?? '',
                        ));
                  }).toList());
              }

              return Container();
            })),
          ),
        ));
  }
}

