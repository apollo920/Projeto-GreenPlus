import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:greenplus/app/core/controllers/auth/auth_store.dart';
import 'package:greenplus/app/core/cursos/page/cursos_page.dart';
import 'package:greenplus/app/core/periodos/page/periodos_page.dart';
import 'package:greenplus/app/features/qrcode/infra/datasources/qrcode_datasource_impl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/qrcode.dart';

import '../../../core/widgets/buttons/expandable_fab.dart';
import 'qrcode_controller.dart';

class QrCodePage extends StatefulWidget {
  final QrCodeController controller;

  const QrCodePage({super.key, required this.controller});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Escolha um dos cursos específicos'),
          backgroundColor: const Color.fromARGB(255, 27, 136, 83),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_sharp),
            onPressed: () {
              widget.controller.back();
            },
          )),
      body: Column(
        children: [
          Expanded(
            child: Observer(builder: (context) {
              if (widget.controller.showCursosWidget) {
                return CursosPage(
                    controller: Modular.get(),
                    callBack: (curso) {
                      widget.controller.setCursoSelected(curso);
                    });
              }
              if (widget.controller.showPeriodosWidget) {
                return PeriodosPage(
                    controller: Modular.get(),
                    idCurso: widget.controller.cursoSelected!.id!,
                    callBack: (periodo) {
                      widget.controller.setPeriodoSelected(periodo);
                    });
              }

              if (widget.controller.showQrCode) {
                return  Center(
                  child: QRCodeListScreen(),
                );
              }

              return Container();
            }),
          )
        ],
      ),
    );
  }
}

enum SecurityType { WPA, nopass, WEP }

class QRCodeWifiGenerator extends StatefulWidget {
  const QRCodeWifiGenerator({super.key});

  @override
  _QRCodeWifiGeneratorState createState() => _QRCodeWifiGeneratorState();
}

class _QRCodeWifiGeneratorState extends State<QRCodeWifiGenerator> {
  String networkName = '';
  String password = '';
  String title = "";
  SecurityType? securityType = SecurityType.nopass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Gerador de QR Code de Rede Wi-Fi'),
          backgroundColor: const Color.fromARGB(255, 27, 136, 83),
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: ExactAssetImage('assets/images/a.png'))),
            child: Center(
              child: SingleChildScrollView(
                  child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Wrap(children: [
                  FractionallySizedBox(
                      widthFactor: 0.5,
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      networkName = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Nome da Rede Wi-Fi'),
                                ),
                                TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      password = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Senha da Rede Wi-Fi',
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5)),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("Tipo de Segurança", textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 16)),
                                          Column(
                                            children: [
                                              RadioListTile<SecurityType>(
                                                title: Text(
                                                    SecurityType.nopass.name),
                                                value: SecurityType.nopass,
                                                groupValue: securityType,
                                                onChanged:
                                                    (SecurityType? value) {
                                                  setState(() {
                                                    securityType = value;
                                                  });
                                                },
                                              ),
                                              RadioListTile<SecurityType>(
                                                title:
                                                    Text(SecurityType.WPA.name),
                                                value: SecurityType.WPA,
                                                groupValue: securityType,
                                                onChanged:
                                                    (SecurityType? value) {
                                                  setState(() {
                                                    securityType = value;
                                                  });
                                                },
                                              ),
                                              RadioListTile<SecurityType>(
                                                title:
                                                    Text(SecurityType.WEP.name),
                                                value: SecurityType.WEP,
                                                groupValue: securityType,
                                                onChanged:
                                                    (SecurityType? value) {
                                                  setState(() {
                                                    securityType = value;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          ElevatedButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                        title: const Text(
                                                            "Digite o Título do QRcode:"),
                                                        content: TextField(
                                                            onChanged: (value) {
                                                              setState(() {
                                                                title = value;
                                                              });
                                                            },
                                                            decoration:
                                                                const InputDecoration(
                                                              hintText:
                                                                  "Título",
                                                            )),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                "Cancelar"),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              String wifiData =
                                                                  'WIFI:T:${securityType?.name};S:$networkName;P:$password;;';
                                                              _generateWifiQRCode(
                                                                  wifiData);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                "OK"),
                                                          )
                                                        ]);
                                                  });
                                            },
                                            child: const Text('Gerar QR Code'),
                                          ),
                                          const SizedBox(height: 20),
                                          ElevatedButton(
                                              onPressed: () {
                                                Modular.to
                                                    .pushNamed("/qrcodelist");
                                              },
                                              child: const Text(
                                                  "Lista de qrcodes")),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          if (networkName.isNotEmpty &&
                                              password.isNotEmpty)
                                            Container(
                                                color: Colors.white,
                                                child: QrImageView(
                                                  data:
                                                      'WIFI:T:${securityType?.name};S:$networkName;P:$password;;',
                                                  version: QrVersions.auto,
                                                  size: 200.0,
                                                ))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ])))
                ]),
              )),
            )));
  }

  void _generateWifiQRCode(String data) {
    listaQrCode.add({
      "content": data,
      "title": title,
      "type": "Link",
    });
  }
}

class QRCodeLinkGenerator extends StatefulWidget {
  const QRCodeLinkGenerator({super.key});

  @override
  _QRCodeLinkGeneratorState createState() => _QRCodeLinkGeneratorState();
}

class _QRCodeLinkGeneratorState extends State<QRCodeLinkGenerator> {
  String link = '';
  String title = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Gerador de QR Code de Link'),
          backgroundColor: const Color.fromARGB(255, 27, 136, 83),
        ),
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: ExactAssetImage('assets/images/a.png'),
              ),
            ),
            child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Wrap(children: [
              FractionallySizedBox(
                    widthFactor: 0.5,
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                onChanged: (value) {
                                  setState(() {
                                    link = value;
                                  });
                                },
                                decoration:
                                    const InputDecoration(labelText: 'Link'),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                            "Digite o Título do QRcode:"),
                                        content: TextField(
                                          onChanged: (value) {
                                            setState(() {
                                              title = value;
                                            });
                                          },
                                          decoration: const InputDecoration(
                                            hintText: "Título",
                                          ),
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
                                              _generateLinkQRCode(link);
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("OK"),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Text('Gerar QR Code'),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  Modular.to.pushNamed("/qrcodelist");
                                },
                                child: const Text("Lista de qrcodes"),
                              ),
                              const SizedBox(height: 20),
                              if (link.isNotEmpty)
                                Container(
                                    color: Colors.white,
                                    child: QrImageView(
                                      data: link,
                                      version: QrVersions.auto,
                                      size: 200.0,
                                    ))
                            ])))
            ]),
                ))));
  }

  void _generateLinkQRCode(String data) {
    Modular.get<QrCodeController>().listaQrCode.add(QrCodeModel.fromMap({
      "content": link,
      "title": title,
      "type": "Link",
    }));
  }
}

class QRCodeListScreen extends StatefulWidget {

  QRCodeListScreen({super.key});

  @override
  State<QRCodeListScreen> createState() => _QRCodeListScreenState();
}

class _QRCodeListScreenState extends State<QRCodeListScreen> {
  //final database = listaQrCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: (Modular.get<AuthStore>().user?.isAdmin ?? false) ? ExpandableFab(
        fabButtons: [
          FabActionButton(
            icon: Icons.wifi,
            onPressed: () => Modular.to.pushNamed('/qrcodewifi'),
            title: 'QrCode de WI-FI',
          ),
          FabActionButton(
            icon: Icons.library_add,
            onPressed: () => Modular.to.pushNamed('/qrcodelink'),
            title: 'QrCode de Links',
          ),
        ],
      ) : null,
        appBar: AppBar(
          title: const Text('Lista de QR Codes'),
          backgroundColor: const Color.fromARGB(255, 27, 136, 83),
        ),
        body: Center(
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: ExactAssetImage('assets/images/a.png'),
                  ),
                ),
                child: SingleChildScrollView(
                    child: Center(
                        child: Observer(
                          builder: (context) {
                            return Wrap(
                                spacing: 20,
                                runSpacing: 20,
                                children: Modular.get<QrCodeController>().listaQrCode.map((element) {
                                  final content = element.content;
                                  final title = element.title;
                                  final type = element.type;

                                  return Column(children: [
                                    Container(
                                        width: 200,
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(children: [
                                          Text(
                                            title!,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Container(
                                            color: Colors.white,
                                            child: QrImageView(
                                              data: content!,
                                              version: QrVersions.auto,
                                              size: 150.0,
                                            ),
                                          ),
                                          Text(type!,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                              ))
                                        ]))
                                  ]);
                                }).toList());
                          }
                        ))))));
  }
}
