import 'package:flutter/material.dart';

class FlagButton extends StatelessWidget {
  final String text;
  final String flag;
  final VoidCallback onTap;

  FlagButton({
    required this.text,
    required this.flag,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset(
                'assets/flags/$flag', // Path to the flag image
                width: 50, // Width of the flag image
                height: 30, // Height of the flag image
                fit: BoxFit.cover, // Adjust the fit of the image
              ),
              SizedBox(width: 16.0), // Space between image and text
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
