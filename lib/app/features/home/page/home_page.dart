import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:greenplus/app/core/utils/string_extensions.dart';

import '../../../core/widgets/custom_button_2.dart';
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
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: ExactAssetImage('assets/images/a.png'))),
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
                OutlinedButton(onPressed: ()=>  widget.controller.obterMenusModulos(), child: const Text("Tentar novamente"))
              ],
            );
          }
          if (widget.controller.loaded) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Wrap(children: [
                    ...widget.controller.menusModulo.take(3).map((menu) {
                      return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: CustomButton2(
                            backgroundColor:
                                const Color.fromARGB(255, 27, 136, 83),
                            icon: menu.icon!.toIcon(),
                            onPressed: () {
                              // controller.navigateToScreen(
                              //     context, menu.screenIndex);
                            },
                            label: menu.title ?? '',
                          ));
                    }).toList(),
                  ]),
                  const SizedBox(
                    height: 40,
                  ),
                  Wrap(children: [
                    ...widget.controller.menusModulo.sublist(widget.controller.menusModulo.length - 3, widget.controller.menusModulo.length ).map((menu) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: CustomButton2(
                            backgroundColor:
                            const Color.fromARGB(255, 27, 136, 83),
                            icon: menu.icon!.toIcon(),
                            onPressed: () {
                              // controller.navigateToScreen(
                              //     context, menu.screenIndex);
                            },
                            label: menu.title ?? '',
                          ));
                    }).toList(),
                  ])
                ]);
          }

          return Container();
        })),
      ),
    ));
  }
}
