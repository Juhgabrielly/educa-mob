import 'package:flutter/material.dart';

import '../root/pallet.dart';
import 'card.dart';

class MetasPage extends StatelessWidget {
  const MetasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final metas = [
      ['Comprar um carro', .80],
      ['Viagem internacional', .67],
      ['Reserva de emergência', .45],
      ['Curso profissional', .32],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Metas Financeiras',
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'Metas Financeiras',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Acompanhe o progresso dos seus objetivos.',
            style: TextStyle(
              color: AppPalette.cinza,
            ),
          ),

          const SizedBox(height: 18),

          ...metas.map(
            (meta) {
              final progresso = meta[1] as double;

              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 12,
                ),
                child: CardPadrao(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              meta[0] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          Text(
                            '${(progresso * 100).round()}%',
                            style: const TextStyle(
                              color: AppPalette.roxo,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      LinearProgressIndicator(
                        value: progresso,
                        color: AppPalette.roxo,
                        backgroundColor: AppPalette.roxoClaro,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}