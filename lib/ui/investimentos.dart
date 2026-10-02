import 'package:flutter/material.dart';

import '../root/pallet.dart';
import 'card.dart';

class InvestimentosPage extends StatelessWidget {
  const InvestimentosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'Seus Investimentos',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 5),

        const Text(
          'Acompanhe sua carteira e seus investimentos.',
          style: TextStyle(
            color: AppPalette.cinza,
          ),
        ),

        const SizedBox(height: 18),

        const Row(
          children: [
            Expanded(
              child: _Info(
                titulo: 'Patrimônio',
                valor: 'R\$ 24.315,30',
              ),
            ),

            SizedBox(width: 10),

            Expanded(
              child: _Info(
                titulo: 'Rentabilidade',
                valor: '18,1%',
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        const CardPadrao(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'Minha carteira',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 15),

              _Investimento(
                titulo: 'Tesouro Direto',
                valor: 'R\$ 8.500,00',
                porcentagem: '35%',
              ),

              _Investimento(
                titulo: 'CDB',
                valor: 'R\$ 6.200,00',
                porcentagem: '25%',
              ),

              _Investimento(
                titulo: 'Fundos',
                valor: 'R\$ 4.100,00',
                porcentagem: '17%',
              ),

              _Investimento(
                titulo: 'Ações',
                valor: 'R\$ 5.515,30',
                porcentagem: '23%',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Info extends StatelessWidget {
  final String titulo;
  final String valor;

  const _Info({
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

class _Investimento extends StatelessWidget {
  final String titulo;
  final String valor;
  final String porcentagem;

  const _Investimento({
    required this.titulo,
    required this.valor,
    required this.porcentagem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  titulo,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Text(valor),

              const SizedBox(width: 8),

              Text(
                porcentagem,
                style: const TextStyle(
                  color: AppPalette.roxo,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 7),

          const LinearProgressIndicator(
            value: .55,
            color: AppPalette.roxo,
            backgroundColor: AppPalette.roxoClaro,
          ),
        ],
      ),
    );
  }
}