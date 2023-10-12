import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:greenplus/app/core/cursos/page/cursos_page.dart';
import 'package:greenplus/app/core/periodos/page/periodos_page.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
          backgroundColor: Color.fromARGB(255, 27, 136, 83),
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
                return Center(
                  child: Container(child: QRCodeGenerator()),
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

class QRCodeGenerator extends StatefulWidget {
  @override
  _QRCodeGeneratorState createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  String networkName = '';
  String password = '';

  SecurityType? securityType = SecurityType.nopass;

  @override
  Widget build(BuildContext context) {
    print('WIFI:T:${securityType?.name};S:$networkName;P:$password;;');
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerador de QR Code de Rede Wi-Fi'),
      ),
      body: Padding(
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
              decoration: InputDecoration(labelText: 'Nome da Rede Wi-Fi'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              decoration: InputDecoration(labelText: 'Senha da Rede Wi-Fi'),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            Text("Tipo de Segurança", style: TextStyle(fontSize: 16)),
            Column(
              children: [
                RadioListTile<SecurityType>(
                  title: Text(SecurityType.nopass.name),
                  value: SecurityType.nopass,
                  groupValue: securityType,
                  onChanged: (SecurityType? value) {
                    setState(() {
                      securityType = value;
                    });
                  },
                ),
                RadioListTile<SecurityType>(
                  title: Text(SecurityType.WPA.name),
                  value: SecurityType.WPA,
                  groupValue: securityType,
                  onChanged: (SecurityType? value) {
                    setState(() {
                      securityType = value;
                    });
                  },
                ),
                RadioListTile<SecurityType>(
                  title: Text(SecurityType.WEP.name),
                  value: SecurityType.WEP,
                  groupValue: securityType,
                  onChanged: (SecurityType? value) {
                    setState(() {
                      securityType = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String wifiData =
                    'WIFI:T:${securityType?.name};S:$networkName;P:$password;;';
                _generateQRCode(wifiData);
              },
              child: Text('Gerar QR Code'),
            ),
            SizedBox(height: 20),
            if (networkName.isNotEmpty &&
                password.isNotEmpty)
              QrImageView(
                data: 'WIFI:T:${securityType?.name};S:$networkName;P:$password;;',
                version: QrVersions.auto,
                size: 200.0,
              ),
          ],
        ),
      ),
    );
  }

  void _generateQRCode(String data) {
    // Aqui você pode adicionar a lógica para gerar o QR code
    // Pode ser exibido na tela ou salvo como imagem, conforme necessário.
  }
}
