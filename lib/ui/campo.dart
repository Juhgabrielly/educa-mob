
import 'package:flutter/material.dart';
import '../root/pallet.dart';

class Campo extends StatefulWidget {
  final String titulo;
  final String dica;
  final bool senha;
  final TextEditingController? controller;
  final TextInputType teclado;

  const Campo({
    super.key,
    required this.titulo,
    required this.dica,
    this.senha = false,
    this.controller,
    this.teclado = TextInputType.text,
  });

  @override
  State<Campo> createState() => _CampoState();
}

class _CampoState extends State<Campo> {
  bool ocultar = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.titulo,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: AppPalette.texto,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: widget.controller,
          keyboardType: widget.teclado,
          obscureText: widget.senha && ocultar,
          decoration: InputDecoration(
            hintText: widget.dica,
            prefixIcon: Icon(
              widget.senha
                  ? Icons.lock_outline
                  : Icons.person_outline,
              size: 20,
            ),
            suffixIcon: widget.senha
                ? IconButton(
                    onPressed: () {
                      setState(() => ocultar = !ocultar);
                    },
                    icon: Icon(
                      ocultar
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}