import 'package:flutter/material.dart';

import '../root/pallet.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppPalette.roxo,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.account_balance,
            color: Colors.white,
          ),
        ),

        const SizedBox(width: 10),

        const Text(
          'EDUCA FINANÇA',
          style: TextStyle(
            color: AppPalette.texto,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}