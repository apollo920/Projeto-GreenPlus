
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/screen_size/size_config.dart';


class EmptyPage extends StatelessWidget {
  final String imagePath;
  final String message;
  final String? subMessage;
  final double widthPercent;
  final double heightPercent;
  final Color textColor;
  final bool isSvg;
  final bool enableButtonAtendimento;
  final Function()? functioRetry;

  const EmptyPage({
    super.key, 
    required this.imagePath,
    required this.message,
    this.subMessage,
    this.isSvg = false,
    this.enableButtonAtendimento = false,
    this.textColor = Colors.black38,
    this.widthPercent = 0.5,
    this.functioRetry,
    this.heightPercent = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Container(
        width: SizeConfig.screenWidth,
        padding: const EdgeInsets.all(30.0),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            imageContainer(context),
            messageContainer(),
            subMessageContainer(),
            if(functioRetry != null) LoadErrorWithRetry(
              onPressed: functioRetry,
            ),
          ],
        ),
      ),
    );
  }

  Widget imageContainer(BuildContext context) {
    double height = SizeConfig.screenHeight!;
    return SizedBox(
      height: height * heightPercent,
      child: isSvg ? SvgPicture.asset(imagePath) : Image.asset(imagePath),
    );
  }

  Widget messageContainer() {
    return Container(
      margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16.0,
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget subMessageContainer() {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: Text(
        subMessage ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16.0,
          color: textColor,
        ),
      ),
    );
  }
}

class LoadErrorWithRetry extends StatelessWidget {

  final Function()? onPressed;

  const LoadErrorWithRetry({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Padding(
            padding:  EdgeInsets.only(bottom: 8.0),
            child:  Text("Tivemos um problema ao carregar os dados"),
          ),
          ElevatedButton.icon(icon: const Icon(Icons.replay, color: Colors.white,),  onPressed: onPressed, label: const Text("TENTE NOVAMENTE"),)
        ],
      ),
    );
  }
}
