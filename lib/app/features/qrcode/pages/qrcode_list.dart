import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:greenplus/app/core/controllers/auth/auth_store.dart';
import 'package:greenplus/app/core/widgets/buttons/expandable_fab.dart';
import 'package:greenplus/app/features/qrcode/pages/qrcode_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/pages/empty/empty_page.dart';

class QRCodeListScreen extends StatefulWidget {
  final QrCodeController controller;
  final String idCurso;
  final String idPeriodo;

  const QRCodeListScreen(
      {required this.controller,
      required this.idCurso,
      required this.idPeriodo,
      super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QRCodeListScreenState createState() => _QRCodeListScreenState();
}

class _QRCodeListScreenState extends State<QRCodeListScreen> {
  final snackBar = SnackBar(
    content: const Text("Deletado com sucesso!"),
    action: SnackBarAction(
      label: 'Confirmar',
      onPressed: () {},
    ),
  );
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller
          .obterQrCodes(idCurso: widget.idCurso, idPeriodo: widget.idPeriodo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Modular.to.pop()),
          title: const Text(
            "Lista de QrCodes",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 27, 136, 83),
        ),
        floatingActionButton: (Modular.get<AuthStore>().user?.isAdmin ?? false)
            ? Observer(
                builder: (_) {
                  if (!widget.controller.erro) {
                    return ExpandableFab(
                      fabButtons: [
                        FabActionButton(
                          icon: Icons.wifi,
                          onPressed: () =>
                              Modular.to.pushNamed('/qrcode/qrcodewifi'),
                          title: 'QrCode de WI-FI',
                        ),
                        FabActionButton(
                          icon: Icons.library_add,
                          onPressed: () =>
                              Modular.to.pushNamed('/qrcode/qrcodelink'),
                          title: 'QrCode de Links',
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              )
            : null,
        body: Center(
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: ExactAssetImage('assets/images/aa.png'),
                  ),
                ),
                child: SingleChildScrollView(
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Observer(builder: (context) {
                            if (widget.controller.loading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                                  );
                                }
                            return Container(
                                alignment: Alignment.center,
                                child: Wrap(
                                    alignment: WrapAlignment.center,
                                    spacing: 20,
                                    runSpacing: 20,
                                    children: [
                                      if (widget
                                          .controller.listaQrCode.isNotEmpty)
                                        ...widget.controller.listaQrCode
                                            .map((qrCode) {
                                          final content = qrCode.content;
                                          final title = qrCode.title;
                                          final type = qrCode.type;
                                          return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        QRCodeZoomScreen(
                                                            data: content,
                                                            title: title),
                                                  ),
                                                );
                                              },
                                              child: Column(children: [
                                                Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    width: 200,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            title!,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Container(
                                                            color: Colors.white,
                                                            child: QrImageView(
                                                              data: content!,
                                                              version:
                                                                  QrVersions
                                                                      .auto,
                                                              size: 150.0,
                                                            ),
                                                          ),
                                                          Text(
                                                            type!,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Visibility(
                                                              visible: widget
                                                                  .controller
                                                                  .showTrash(),
                                                              child: ElevatedButton(
                                                                  onPressed: () => showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                Text(
                                                                              "Você tem certeza que deseja apagar o QrCode '$title' ?",
                                                                            ),
                                                                            actions: [
                                                                              TextButton(
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: const Text("Cancelar"),
                                                                              ),
                                                                              TextButton(
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop();
                                                                                  _deleteQRCode((qrCode.id!));
                                                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                                },
                                                                                child: const Text("Ok"),
                                                                              )
                                                                            ],
                                                                          );
                                                                        },
                                                                      ),
                                                                  style: ButtonStyle(
                                                                    backgroundColor: MaterialStateProperty.all<
                                                                            Color>(
                                                                        Colors
                                                                            .red),
                                                                    shape: MaterialStateProperty
                                                                        .all<
                                                                            OutlinedBorder>(
                                                                      const CircleBorder(),
                                                                    ),
                                                                  ),
                                                                  child: const Padding(
                                                                      padding: EdgeInsets.all(8.0),
                                                                      child: Icon(
                                                                        Icons
                                                                            .delete,
                                                                        color: Colors
                                                                            .white,
                                                                      ))))
                                                        ]))
                                              ]));
                                        }).toList()
                                      else if (widget.controller.erro)
                                        Column(
                                          children: [
                                            const EmptyPage(
                                              imagePath:
                                                  "assets/images/server_down.svg",
                                              message:
                                                  "Erro ao carregar dados!",
                                              isSvg: true,
                                              heightPercent: 0.4,
                                              subMessage:
                                                  "Tente novamente mais tarde",
                                              textColor: Colors.white,
                                            ),
                                            ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: const Text("VOLTAR")),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            ElevatedButton(
                                                onPressed: () => widget
                                                    .controller
                                                    .obterQrCodes(
                                                        idCurso: widget.idCurso,
                                                        idPeriodo:
                                                            widget.idPeriodo),
                                                child: const Text(
                                                    "TENTE NOVAMENTE"))
                                          ],
                                        )
                                      else
                                        const EmptyPage(
                                          imagePath: "assets/images/empty.svg",
                                          message: "Sem QRCodes",
                                          isSvg: true,
                                          heightPercent: 0.4,
                                          subMessage:
                                              "Tente novamente mais tarde",
                                          textColor: Colors.white,
                                        ),
                                    ]));
                          }))
                    ]))))));
  }

  Future<void> _deleteQRCode(String id) async {
    await Modular.get<QrCodeController>().deleteQrCode(idQrcode: id);
  }
}

class QRCodeZoomScreen extends StatelessWidget {
  final String data;
  final String title;

  const QRCodeZoomScreen({super.key, required this.data, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Modular.to.pop()),
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 27, 136, 83),
          elevation: 0,
        ),
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: ExactAssetImage('assets/images/aa.png'),
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
          ),
          Center(
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: QrImageView(
                    data: data,
                    version: QrVersions.auto,
                    size: 500.0,
                  )))
        ]));
  }
}
