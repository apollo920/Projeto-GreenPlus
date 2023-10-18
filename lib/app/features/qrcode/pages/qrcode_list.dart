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

  const QRCodeListScreen({required this.controller, required this.idCurso, required this.idPeriodo, super.key});


  @override
  _QRCodeListScreenState createState() => _QRCodeListScreenState();
}

class _QRCodeListScreenState extends State<QRCodeListScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.obterQrCodes(idCurso: widget.idCurso, idPeriodo: widget.idPeriodo);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white,), onPressed: () => Modular.to.pop()),
        title: const Text("Lista de QrCodes",
        style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: const Color.fromARGB(255, 27, 136, 83),
      ),
      floatingActionButton: (Modular.get<AuthStore>().user?.isAdmin ?? false)
          ? ExpandableFab(
              fabButtons: [
                FabActionButton(
                  icon: Icons.wifi,
                  onPressed: () => Modular.to.pushNamed('/qrcode/qrcodewifi'),
                  title: 'QrCode de WI-FI',
                ),
                FabActionButton(
                  icon: Icons.library_add,
                  onPressed: () => Modular.to.pushNamed('/qrcode/qrcodelink'),
                  title: 'QrCode de Links',
                ),
              ],
            )
          : null,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Observer(
                      builder: (context) {
                        return Container(
                          alignment: Alignment.center,
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 20,
                            runSpacing: 20,
                            children: [
                              if(widget.controller
                                  .listaQrCode.isNotEmpty)
                                  ...widget.controller
                                  .listaQrCode
                                  .map(
                                    (qrCodeModel) {
                                      final content = qrCodeModel.content;
                                      final title = qrCodeModel.title;
                                      final type = qrCodeModel.type;
                                      return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    QRCodeZoomScreen(
                                                      data: content,
                                                    ),
                                                  ),
                                                );
                                              },
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.circular(15),
                                                    ),
                                                    width: 200,
                                                    padding: const EdgeInsets.all(16.0),
                                                    child: Column(
                                                        children: [
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
                                                          Text(
                                                              type!,
                                                              style: const TextStyle(
                                                                fontSize: 18,
                                                                color: Colors.black,
                                                              )
                                                            )
                                                          ]
                                                        )
                                                      ),
                                                Visibility(
                                                   visible: qrCodeModel.id?.isNotEmpty ?? false ,
                                                  child: ElevatedButton(onPressed: () => showDialog(context: context, builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text("Você tem certeza que deseja apagar o QrCode '$title' ?"),
                                                      actions: [
                                                        TextButton(
                                                        onPressed:() {
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: const Text("Cancelar")),
                                                        TextButton(
                                                          onPressed: (){
                                                            Navigator.of(context).pop();
                                                            _deleteQRCode(int.parse(qrCodeModel.id!));
                                                          },
                                                          child: const Text("Ok"))
                                                        ]
                                                      );}),
                                                    style: ButtonStyle(
                                                    backgroundColor: const MaterialStatePropertyAll<Color>(Colors.red),
                                                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(30)))
                                                  ), child: const Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: Icon(Icons.delete,
                                                    color: Colors.white,)),),
                                                )
                                              ]
                                            )
                                          );
                                        }
                                      )
                                    .toList()
                              else if(widget.controller.erro)
                                Column(
                                  children: [
                                    const EmptyPage(
                                      imagePath: "assets/images/server_down.svg", message: "Erro ao carregar dados!",
                                      isSvg: true,
                                      heightPercent: 0.4,
                                      subMessage: "Tente novamente mais tarde", textColor: Colors.white,),
                                    ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text("VOLTAR"))
                                  ],
                                )
                              else
                                const EmptyPage(
                                imagePath: "assets/images/empty.svg", message: "Sem QRCodes",
                                isSvg: true,
                                heightPercent: 0.4,
                                subMessage: "Tente novamente mais tarde", textColor: Colors.white,)
                            ]
                          )
                        );
                      }
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
  Future<void> _deleteQRCode(int id) async {
  await Modular.get<QrCodeController>().deleteQrCode(idQrcode: id);
  }
}

class QRCodeZoomScreen extends StatelessWidget {
  final String data;

  const QRCodeZoomScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 27, 136, 83),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: ExactAssetImage('assets/images/a.png'),
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
              )
            )
          )
        ]
      )
    );
  }
}
