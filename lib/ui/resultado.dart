import 'package:flutter/material.dart';

import 'botao.dart';
import 'card.dart';

class ResultadoQuizPage extends StatelessWidget {
  final int score;
  final int total;

  const ResultadoQuizPage({
    super.key,
    required this.score,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resultado',
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: CardPadrao(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 65,
                ),
                const SizedBox(height: 15),
                const Text(
                  'Quiz Finalizado!',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Você acertou $score de $total perguntas.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Botao(
                  texto: 'Voltar',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
