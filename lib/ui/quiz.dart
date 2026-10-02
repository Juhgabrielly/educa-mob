import 'package:flutter/material.dart';

import '../root/pallet.dart';
import 'botao.dart';
import 'card.dart';
import 'resultado.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int selecionada = -1;

  final respostas = [
    'Utilizar o dinheiro sem nenhum planejamento.',
    'Definir objetivos, organizar gastos e acompanhar resultados.',
    'Evitar qualquer tipo de investimento.',
    'Gastar toda a renda no início do mês.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz',
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'Pergunta 1 de 5',
            style: TextStyle(
              color: AppPalette.roxo,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            'Qual é uma boa prática para uma vida financeira organizada?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          ...List.generate(
            respostas.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: CardPadrao(
                  onTap: () {
                    setState(() {
                      selecionada = index;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        selecionada == index
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: selecionada == index
                            ? AppPalette.roxo
                            : AppPalette.cinza,
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          respostas[index],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 10),

          Botao(
            texto: 'Finalizar',
            onPressed: selecionada == -1
                ? null
                : () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const ResultadoQuizPage(),
                      ),
                    );
                  },
          ),
        ],
      ),
    );
  }
}