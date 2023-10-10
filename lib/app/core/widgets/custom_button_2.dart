import 'package:flutter/material.dart';

class CustomButton2 extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final VoidCallback onPressed;
  final String label;

  CustomButton2({
    required this.backgroundColor,
    required this.icon,
    required this.onPressed,
    required this.label,
  });

 @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
          maxWidth: 170
      ),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(48),
              shape: CircleBorder(),
              primary: backgroundColor,
            ),
            child: Icon(
              icon,
              size: 80,
              color: Colors.white,
            )
          ),
          SizedBox(height: 10),
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