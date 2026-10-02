import 'package:flutter/material.dart';

import '../root/pallet.dart';

class Campo extends StatelessWidget {
  final String titulo;
  final String hint;
  final bool senha;

  const Campo({
    super.key,
    required this.titulo,
    required this.hint,
    this.senha = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            color: AppPalette.texto,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 7),
        TextField(
          obscureText: senha,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFFCFAFF),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(
                color: Color(0xFFE5D9F5),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(
                color: Color(0xFFE5D9F5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(
                color: AppPalette.roxo,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
