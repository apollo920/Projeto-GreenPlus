import 'package:flutter/material.dart';

class CustomButtonQuadrado extends StatefulWidget {
  final Color backgroundColor;
  final IconData icon;
  final VoidCallback onPressed;
  final String label;

  const CustomButtonQuadrado({
    super.key, 
    required this.backgroundColor,
    required this.icon,
    required this.onPressed,
    required this.label,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomButtonQuadradoState createState() => _CustomButtonQuadradoState();
}

class _CustomButtonQuadradoState extends State<CustomButtonQuadrado> {
  double _size = 60.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 250),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MouseRegion(
            onEnter: (event) {
              setState(() {
                _size = 70.0;
              });
            },
            onExit: (event) {
              setState(() {
                _size = 60.0;
              });
            },
            child: GestureDetector(
              onTap: widget.onPressed,
              child: AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: Stack(
                  children: [
                    ElevatedButton(
                      onPressed: widget.onPressed,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(40),
                        backgroundColor: widget.backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                      ),
                      child: SizedBox(
                        width: _size,
                        height: _size,
                      )
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          widget.icon,
                          size: _size,
                          color: Colors.white,
                        )
                      )
                    )
                  ]
                )
              )
            )
          ),
          const SizedBox(height: 10),
          Text(
            widget.label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontFamily: 'Poppins'
            )
          )
        ]
      )
    );
  }
}
