import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:greenplus/app/core/cursos/page/cursos_page.dart';
import 'package:greenplus/app/core/periodos/page/periodos_page.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/qrcode.dart';
import 'qrcode_controller.dart';

class QrCodePage extends StatefulWidget {
  final QrCodeController controller;
  const QrCodePage({super.key, required this.controller});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Observer(
            builder: (context) {
              return widget.controller.showPeriodosWidget ? const Text('Escolha um dos periodos específicos', 
        style: TextStyle(
          color: Colors.white
        ),) :  const Text('Escolha um dos cursos específicos', 
        style: TextStyle(
          color: Colors.white
        ),);
            }
          ),
          backgroundColor: const Color.fromARGB(255, 27, 136, 83),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white,),
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
                      Modular.to.pushNamed('/qrcode/qrcodelist/${widget.controller.cursoSelected?.id}/${periodo.id}');
                    });
              }

              return Container();
            }),
          )
        ],
      ),
    );
  }
}

// ignore: constant_identifier_names
enum SecurityType { WPA, nopass, WEP }

class QRCodeWifiGenerator extends StatefulWidget {
  const QRCodeWifiGenerator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QRCodeWifiGeneratorState createState() => _QRCodeWifiGeneratorState();
}

class _QRCodeWifiGeneratorState extends State<QRCodeWifiGenerator> {
  String networkName = '';
  String password = '';
  String title = "";
  String type = "Wi-Fi";
  SecurityType? securityType = SecurityType.nopass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white,), onPressed: () => Modular.to.pop()),
          title: const Text('Gerador de QR Code de Rede Wi-Fi', 
          style: TextStyle(
          color: Colors.white
        ),),
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
                                                            onPressed: () async {
                                                              String wifiData =
                                                                  'WIFI:T:${securityType?.name};S:$networkName;P:$password;;';
                                                              await _generateWifiQRCode(
                                                                  wifiData);
                                                              // ignore: use_build_context_synchronously
                                                              Navigator.of(
                                                                   context)
                                                                  .pop();
                                                                  // ignore: use_build_context_synchronously
                                                                  Navigator.of(context).pop();
                                                                  setState(() {
                                                                    
                                                                  });
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
                                        ]
                                      )
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
                                                )
                                              )
                                            ]
                                          )
                                        )
                                      ]
                                    )
                                  ]
                                )
                              )
                            )
                          ]
                        )
                      )
                    )
                  )
                )
              );
            }

  Future<void> _generateWifiQRCode(String data) async {
  await  Modular.get<QrCodeController>().addQrCode(qrCodeModel: QrCodeModel.fromMap({
      "content": data,
      "title": title,
      "type": type,
    }));
  }
}

class QRCodeLinkGenerator extends StatefulWidget {
  const QRCodeLinkGenerator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QRCodeLinkGeneratorState createState() => _QRCodeLinkGeneratorState();
}

class _QRCodeLinkGeneratorState extends State<QRCodeLinkGenerator> {
  String link = '';
  String title = '';
  String type = "Link";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white,), onPressed: () => Modular.to.pop()),
          title: const Text('Gerador de QR Code de Link', 
          style: TextStyle(
          color: Colors.white
        ),),
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
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Wrap(
                    children: [
              FractionallySizedBox(
                    widthFactor: 0.5,
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                            children: [
                              Expanded(
                                child: Column(
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
                                              onPressed: () async {
                                                await _generateLinkQRCode(link);
                                                setState(() {});
                                                // ignore: use_build_context_synchronously
                                                Navigator.of(context).pop();
                                                // ignore: use_build_context_synchronously
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("OK"),
                                            )
                                          ]
                                        );
                                      }
                                    );
                                  },
                                  child: const Text('Gerar QR Code'),
                                )
                              ]
                            )
                          ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20),                               
                                if (link.isNotEmpty)
                                  Container(
                                      color: Colors.white,
                                      child: QrImageView(
                                        data: link,
                                        version: QrVersions.auto,
                                        size: 200.0,
                                        )
                                      )
                                    ]
                                  )
                                )
                              ]
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

  Future _generateLinkQRCode(String data) async {
    await Modular.get<QrCodeController>().addQrCode(qrCodeModel: QrCodeModel.fromMap({
      "content": link,
      "title": title,
      "type": type,
    }));
  }
}



