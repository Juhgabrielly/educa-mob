import 'package:flutter/material.dart';

import '../root/pallet.dart';

class Botao extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed;
  final bool contorno;

  const Botao({
    super.key,
    required this.texto,
    this.onPressed,
    this.contorno = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: contorno
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppPalette.roxo,
                side: const BorderSide(
                  color: AppPalette.roxo,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                texto,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : FilledButton(
              onPressed: onPressed,
              style: FilledButton.styleFrom(
                backgroundColor: AppPalette.roxo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                texto,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
