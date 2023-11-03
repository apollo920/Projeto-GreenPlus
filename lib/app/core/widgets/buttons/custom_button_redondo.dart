import 'package:flutter/material.dart';

class CustomButtonRedondo extends StatefulWidget {
  final Color backgroundColor;
  final IconData icon;
  final VoidCallback onPressed;
  final String label;

  const CustomButtonRedondo({
    super.key, 
    required this.backgroundColor,
    required this.icon,
    required this.onPressed,
    required this.label,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomButtonRedondoState createState() => _CustomButtonRedondoState();
}

class _CustomButtonRedondoState extends State<CustomButtonRedondo> {
  double _size = 75.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 170),
      child: Column(
        children: [
          MouseRegion(
            onEnter: (event) {
              setState(() {
                _size = 85.0;
              });
            },
            onExit: (event) {
              setState(() {
                _size = 75.0;
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
                        padding: const EdgeInsets.all(48), 
                        backgroundColor: widget.backgroundColor,
                        shape: const CircleBorder(),
                        alignment: Alignment.center,
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
