
import 'package:flutter/material.dart';
import '../root/pallet.dart';

class Logo extends StatelessWidget {
  final double tamanho;
  final bool compacto;

  const Logo({
    super.key,
    this.tamanho = 46,
    this.compacto = false,
  });

  @override
  Widget build(BuildContext context) {
    final texto = compacto ? 'Educa' : 'Educa Finança';
    final subtexto = compacto ? null : 'Educação financeira';

    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: tamanho,
            height: tamanho,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppPalette.roxoClaro,
                  AppPalette.roxo,
                ],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.account_balance_wallet_rounded,
              color: Colors.white,
              size: tamanho * 0.58,
            ),
          ),
          SizedBox(width: compacto ? 8 : 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                texto,
                style: TextStyle(
                  fontSize: compacto ? 14 : 16,
                  fontWeight: FontWeight.w800,
                  color: AppPalette.roxoEscuro,
                ),
              ),
              if (subtexto != null)
                Text(
                  subtexto,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppPalette.textoSecundario,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}