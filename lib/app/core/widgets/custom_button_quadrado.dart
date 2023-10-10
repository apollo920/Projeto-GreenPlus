import 'package:flutter/material.dart';

class CustomButtonQuadrado extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final VoidCallback onPressed;
  final String label;

  const CustomButtonQuadrado({
    required this.backgroundColor,
    required this.icon,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return
      Container(
        constraints: const BoxConstraints(
        maxWidth: 250
      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(40),
                      backgroundColor: backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))                     
                  ),
                  child: Icon(
                    icon,
                    size: 60,
                    color: Colors.white,
                  )
              ),
              Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  )
              )
            ]
        ),
      );
  }
}