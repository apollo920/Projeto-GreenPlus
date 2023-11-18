import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:greenplus/app/features/eventos/pages/eventos_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../core/controllers/auth/auth_store.dart';
import '../../../core/pages/empty/empty_page.dart';
import '../../../core/widgets/buttons/expandable_fab.dart';

class EventosCarousel extends StatefulWidget {
  final EventosController controller;
  final String idCurso;

  const EventosCarousel(
      {super.key, required this.controller, required this.idCurso});

  @override
  // ignore: library_private_types_in_public_api
  _EventosCarouselState createState() => _EventosCarouselState();
}

class _EventosCarouselState extends State<EventosCarousel> {
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
      widget.controller.obterEventos(idCurso: widget.idCurso);
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
              onPressed: () {
                widget.controller.setCursoSelected(null);
                Modular.to.pop();
              }),
          title: const Center(
            child: Text(
              "Lista de Eventos",
              style: TextStyle(color: Colors.white),
            ),
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
                          icon: Icons.library_add,
                          onPressed: () =>
                              Modular.to.pushNamed('/eventos/eventospicker'),
                          title: 'Adicione uma imagem',
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
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: ExactAssetImage('assets/images/aa.png'),
                  ),
                ),
                child: Center(
                    child: Column(children: [
                  Expanded(child: Observer(builder: (context) {
                    if (widget.controller.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                    if (widget.controller.listaEvento.isNotEmpty) {
                      return LayoutBuilder(builder: (_, constrants) {
                        return CarouselSlider(
                            options: CarouselOptions(
                              height: constrants.maxHeight,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              enlargeCenterPage: true,
                            ),
                            items: widget.controller.listaEvento.map((evento) {
                              return Builder(builder: (BuildContext context) {
                                return Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Container(
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: ExactAssetImage(
                                                  'assets/images/a.png'),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.memory(
                                                base64Decode(evento.image!),
                                                width:
                                                    constrants.maxWidth * 0.85,
                                                height:
                                                    constrants.maxHeight * 0.7,
                                                fit: BoxFit.contain,
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      evento.observacoes!,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Visibility(
                                                        visible: widget
                                                            .controller
                                                            .showTrash(),
                                                        child: ElevatedButton(
                                                            onPressed:
                                                                () =>
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              const Text(
                                                                            "Você tem certeza que deseja apagar a imagem selecionada?",
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
                                                                                _deleteEventos((evento.id!));
                                                                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                              },
                                                                              child: const Text("Ok"),
                                                                            )
                                                                          ],
                                                                        );
                                                                      },
                                                                    ),
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Colors
                                                                          .red),
                                                              shape: MaterialStateProperty
                                                                  .all<
                                                                      OutlinedBorder>(
                                                                const CircleBorder(),
                                                              ),
                                                            ),
                                                            child:
                                                                const Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            8.0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color: Colors
                                                                          .white,
                                                                    ))))
                                                  ])
                                            ])));
                              });
                            }).toList());
                      });
                    } else if (widget.controller.erro) {
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
                              onPressed: () => setState(() {
                                    widget.controller
                                        .obterEventos(idCurso: widget.idCurso);
                                  }),
                              child: const Text("TENTE NOVAMENTE"))
                        ],
                      );
                    } else {
                      return const EmptyPage(
                        imagePath: "assets/images/empty.svg",
                        message: "Sem Eventos",
                        isSvg: true,
                        heightPercent: 0.4,
                        subMessage: "Tente novamente mais tarde",
                        textColor: Colors.white,
                      );
                    }
                  }))
                ])))));
  }

  Future<void> _deleteEventos(String id) async {
    await Modular.get<EventosController>().deleteEventos(idEvento: id);
  }
}
