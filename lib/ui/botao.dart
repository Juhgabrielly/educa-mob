
import 'package:flutter/material.dart';
import '../root/pallet.dart';

class Botao extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed;
  final IconData? icone;

  const Botao({
    super.key,
    required this.texto,
    required this.onPressed,
    this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icone == null
            ? const SizedBox.shrink()
            : Icon(icone, size: 19),
        label: Text(
          texto,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPalette.roxo,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
      ),
    );
  }
}

class BotaoContorno extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed;

  const BotaoContorno({
    super.key,
    required this.texto,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 49,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppPalette.roxo,
          side: const BorderSide(color: AppPalette.borda),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: Text(texto),
      ),
    );
  }
}