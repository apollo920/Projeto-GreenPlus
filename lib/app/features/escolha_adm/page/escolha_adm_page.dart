import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:greenplus/app/core/utils/string_extensions.dart';

import '../../../core/widgets/custom_button_2.dart';
import 'escolha_adm_controller.dart';

class EscolhaAdmPage extends StatefulWidget {
  final EscolhaAdmController controller;

  const EscolhaAdmPage({super.key, required this.controller});

  @override
  State<EscolhaAdmPage> createState() => _EscolhaAdmPageState();
}

class _EscolhaAdmPageState extends State<EscolhaAdmPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.obterEscolhaAdm();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visualização ou Modificação de conteúdos",
        style: TextStyle(
          color: Colors.white,
        ),
        ),
        backgroundColor: Color.fromARGB(255, 27, 136, 83),
        
      ),
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
                OutlinedButton(onPressed: ()=>  widget.controller.obterEscolhaAdm(), child: const Text("Tentar novamente"))
              ],
            );
          }
          if (widget.controller.loaded) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Wrap(children: [
                    ...widget.controller.escolhaAdm.map((menu) {
                      return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: CustomButton2(
                            backgroundColor:
                                const Color.fromARGB(255, 27, 136, 83),
                            icon: menu.icon!.toIcon(),
                            onPressed: () {
                              Modular.to.pushNamed('/home');
                            },
                            label: menu.title ?? '',
                          ));
                    }).toList(),
                  ]),
                  const SizedBox(
                    height: 40,
                  ),
                ]);
          }

          return Container();
        })),
      ),
    ));
  }
}
