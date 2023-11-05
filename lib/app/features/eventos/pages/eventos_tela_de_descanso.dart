import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../core/pages/empty/empty_page.dart';
import 'eventos_controller.dart';

class TimeoutScreen extends StatefulWidget {
  final EventosController controller;

  const TimeoutScreen({super.key, required this.controller});

  @override
  // ignore: library_private_types_in_public_api
  _TimeoutScreenState createState() => _TimeoutScreenState();
}

class _TimeoutScreenState extends State<TimeoutScreen> {
  @override
  void initState() {
    super.initState();
    // resetTimeoutTimer();
    // pauseTimeoutTimer();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.obterEventos(idCurso: 'all');
    });
  }
    void _onScreenTapped() {
    Navigator.of(context).pop();
    //startTimeoutTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _onScreenTapped,
        child: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: ExactAssetImage('assets/images/a.png'),
            ),
          ),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: Observer(
                    builder: (context) {
                      if (widget.controller.listaEvento.isNotEmpty) {
                        return LayoutBuilder(
                          builder: (_, constrants){
                            return CarouselSlider(
                              options: CarouselOptions(
                                enlargeFactor: 0,
                                height: constrants.maxHeight,
                                viewportFraction: 1,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                                enlargeCenterPage: true,
                              ),
                              items: widget.controller.listaEvento.map((evento) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(Radius.circular(20))),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.memory(
                                              base64Decode(evento.image!),
                                              width: constrants.maxWidth * 0.85,
                                              height: constrants.maxHeight * 0.7,
                                              fit: BoxFit.contain,
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  evento.observacoes!,
                                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                ),
                                              ]
                                            )
                                          ]
                                        )
                                      )
                                    );
                                  }
                                );
                              }).toList()
                            );
                          }
                        );
                      } else if(widget.controller.erro){
                        return Column(children: [
                                const EmptyPage(
                                  imagePath: "assets/images/server_down.svg", message: "Erro ao carregar dados!",
                                  isSvg: true,
                                  heightPercent: 0.4,
                                  subMessage: "Tente novamente mais tarde", textColor: Colors.white,),
                                ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text("VOLTAR")),
                                  const SizedBox(height: 20,),
                                  ElevatedButton(onPressed: () =>  setState(() {
                                    initState();
                                  }),child: const Text("TENTE NOVAMENTE"))
                                ],
                              );
                            } else {
                                return const EmptyPage(
                                imagePath: "assets/images/empty.svg", message: "Sem Eventos",
                                isSvg: true,
                                heightPercent: 0.4,
                                subMessage: "Tente novamente mais tarde", textColor: Colors.white,);
                                }
                    }
                  )
                )
              ]
            )
          )
        )
          ),
      )
    );
  }
}
