
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';

import '../../controllers/network_provider.dart';
import '../empty/empty_page.dart';
import 'connection_screen_controller.dart';

class ConnectivityScreen extends StatefulWidget {

  final ConnectionScreenController controller;
  const ConnectivityScreen({super.key, required this.controller});

  @override
  State<ConnectivityScreen> createState() => _ConnectivityScreenState();
}

class _ConnectivityScreenState
    extends State<ConnectivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Observer(
        builder: (_) {
          if (!widget.controller.loading) return customBody();
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  PreferredSizeWidget customAppBar() {
    return AppBar(
      leading: Container(),
      elevation: 0.0,
      title: const Text(
        'SEM CONEXÃO',
        style: TextStyle(
          fontSize: 16.0,
          fontFamily: 'Sebino',
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.redAccent,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.refresh, color: Colors.white),
          onPressed: () async =>
              await Modular.get<NetworkProvider>().initCheck(),
        )
      ],
    );
  }

  Widget customBody() {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: const <Widget>[
        EmptyPage(
          imagePath: 'assets/server_down.svg',
          isSvg: true,
          message: 'Conecte-se á Internet',
          subMessage: 'Você está off-line. Verifique sua conexão.',
        ),
        //TODO REVER ESSA LOGICA
        // if(false)
        //   Padding(
        //     padding: const EdgeInsets.only(top: 8.0),
        //     child: BaseGradientButtonWithIcon(
        //       icon: Icon(Icons.credit_card, color: Colors.white,),
        //       onPressed: () => Modular.to
        //           .pushNamed("/beneficiario/carteiras/", arguments: "Carteira"),
        //       text: "ACESSAR CARTEIRAS",
        //     ),
        //   ),
      ],
    );
  }

  Widget imgIllustration() {
    return Container(
      margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: SvgPicture.asset("assets/server_down.svg"),
    );
  }
}
