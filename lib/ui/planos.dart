import 'package:flutter/material.dart';

import '../root/pallet.dart';
import 'botao.dart';
import 'card.dart';

class PlanosPage extends StatelessWidget {
  const PlanosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Planos',
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'Escolha como você quer evoluir financeiramente.',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 18),

          const _Plano(
            titulo: 'Plano Gratuito',
            preco: 'R\$ 0',
            itens: [
              'Cursos básicos',
              'Quiz',
              'Relatórios básicos',
            ],
          ),

          const SizedBox(height: 15),

          const _Plano(
            titulo: 'Plano Premium',
            preco: 'R\$ 19,90',
            itens: [
              'Todos os cursos',
              'Relatórios completos',
              'Investimentos',
              'Metas financeiras',
            ],
          ),
        ],
      ),
    );
  }
}

class _Plano extends StatelessWidget {
  final String titulo;
  final String preco;
  final List<String> itens;

  const _Plano({
    required this.titulo,
    required this.preco,
    required this.itens,
  });

  @override
  Widget build(BuildContext context) {
    return CardPadrao(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            preco,
            style: const TextStyle(
              fontSize: 27,
              color: AppPalette.roxo,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          ...itens.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppPalette.roxo,
                    size: 18,
                  ),

                  const SizedBox(width: 8),

                  Text(item),
                ],
              ),
            ),
          ),

          const SizedBox(height: 15),

          Botao(
            texto: 'Continuar',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}