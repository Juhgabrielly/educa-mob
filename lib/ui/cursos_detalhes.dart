import 'package:flutter/material.dart';

import 'botao.dart';
import 'card.dart';
import 'quiz.dart';

class CursoDetalhesPage extends StatelessWidget {
  final String titulo;

  const CursoDetalhesPage({
    super.key,
    required this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Conteúdo do Curso',
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 18),

          const CardPadrao(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Conteúdo do Curso',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 14),

                Text('• Conceitos fundamentais'),

                SizedBox(height: 7),

                Text('• Organização financeira'),

                SizedBox(height: 7),

                Text('• Planejamento de gastos'),

                SizedBox(height: 7),

                Text('• Metas e objetivos'),

                SizedBox(height: 7),

                Text('• Tomada de decisões'),
              ],
            ),
          ),

          const SizedBox(height: 15),

          CardPadrao(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Teste seus conhecimentos',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Finalize o conteúdo e responda ao quiz.',
                ),

                const SizedBox(height: 15),

                Botao(
                  texto: 'Iniciar Quiz',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const QuizPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}