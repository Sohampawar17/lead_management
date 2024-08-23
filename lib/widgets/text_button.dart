import 'package:flutter/material.dart';

class CtextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
 final Color buttonColor;
  const CtextButton({
    super.key,
    required this.onPressed,
    required this.text, required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color:buttonColor,
       shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),
        ),
      ),
    );
  }
}
