import 'package:flutter/material.dart';

import '../root/pallet.dart';
import 'card.dart';
import 'cursos_detalhes.dart';

class CursosPage extends StatelessWidget {
  const CursosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cursos = [
      [
        'Planejamento e Organização Financeira',
        Icons.account_balance_wallet_outlined
      ],
      ['Gestão de Dívidas e Crédito', Icons.credit_card],
      ['Investimentos', Icons.trending_up],
      ['Matemática Financeira', Icons.calculate_outlined],
      ['Educação Financeira Empresarial', Icons.business_center_outlined],
      ['Psicologia Econômica', Icons.psychology_outlined],
    ];

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'Cursos',
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Aprenda no seu ritmo e evolua sua vida financeira.',
          style: TextStyle(
            color: AppPalette.cinza,
          ),
        ),
        const SizedBox(height: 20),
        ...cursos.map(
          (curso) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 12,
              ),
              child: CardPadrao(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CursoDetalhesPage(
                        titulo: curso[0] as String,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppPalette.roxoClaro,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Icon(
                        curso[1] as IconData,
                        color: AppPalette.roxo,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            curso[0] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Curso online • Aulas e atividades',
                            style: TextStyle(
                              color: AppPalette.cinza,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: AppPalette.roxo,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
