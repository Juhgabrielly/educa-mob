import 'package:flutter/material.dart';

import '../root/pallet.dart';
import 'card.dart';

class RelatoriosPage extends StatelessWidget {
  const RelatoriosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'Resultados Financeiros',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 5),

        const Text(
          'Acompanhe sua evolução financeira.',
          style: TextStyle(
            color: AppPalette.cinza,
          ),
        ),

        const SizedBox(height: 18),

        Row(
          children: const [
            Expanded(
              child: _InfoCard(
                titulo: 'Saldo',
                valor: 'R\$ 4.000,00',
              ),
            ),

            SizedBox(width: 10),

            Expanded(
              child: _InfoCard(
                titulo: 'Receitas',
                valor: 'R\$ 3.889,00',
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Row(
          children: const [
            Expanded(
              child: _InfoCard(
                titulo: 'Investimentos',
                valor: 'R\$ 510,00',
              ),
            ),

            SizedBox(width: 10),

            Expanded(
              child: _InfoCard(
                titulo: 'Gastos',
                valor: 'R\$ 1.420,00',
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        const CardPadrao(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'Histórico Financeiro',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 15),

              _Linha(
                'Salário',
                '+ R\$ 3.889,00',
                true,
              ),

              _Linha(
                'Investimento',
                '- R\$ 400,00',
                false,
              ),

              _Linha(
                'Alimentação',
                '- R\$ 220,00',
                false,
              ),

              _Linha(
                'Transporte',
                '- R\$ 150,00',
                false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String titulo;
  final String valor;

  const _InfoCard({
    required this.titulo,
    required this.valor,
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
              color: AppPalette.cinza,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            valor,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _Linha extends StatelessWidget {
  final String titulo;
  final String valor;
  final bool positivo;

  const _Linha(
    this.titulo,
    this.valor,
    this.positivo,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(titulo),
          ),

          Text(
            valor,
            style: TextStyle(
              color: positivo
                  ? Colors.green
                  : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}