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
      Column(
          children: [
            ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(40),
                    backgroundColor: backgroundColor,
                    shape: RoundedRectangleBorder()
                ),
                child: Icon(
                  icon,
                  size: 60,
                  color: Colors.white,
                )
            ),
            Text(
                label,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                )
            )
          ]
      );
  }
}