import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:greenplus/app/features/eventos/pages/eventos_controller.dart'; 

class ImageCarousel extends StatefulWidget {
  final EventosController controller; 
  final String idCurso;

  ImageCarousel({required this.controller, required this.idCurso});

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     widget.controller.obterEventos(idCurso: widget.idCurso,);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
    options: CarouselOptions(height: 400.0),
    items: [1,2,3,4,5].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              color: Colors.amber
            ),
            child: Text('text $i', style: TextStyle(fontSize: 16.0),)
          );
        },
      );
    }).toList(),
  );
  }
}
