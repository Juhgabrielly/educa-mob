
import 'package:flutter/material.dart';
import '../data/app_repository.dart';
import '../data/app_repository_scope.dart';
import '../root/pallet.dart';
import '../ui/botao.dart';
import 'resultado.dart';

class QuizPage extends StatefulWidget {
  final String courseId;

  const QuizPage({super.key, required this.courseId});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Future<List<QuizQuestion>>? _questionsFuture;
  int perguntaAtual = 0;
  int? resposta;
  bool enviando = false;
  final respostas = <QuizAnswer>[];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _questionsFuture ??= AppRepositoryScope.of(context)
        .getQuizQuestions(widget.courseId);
  }

  Future<void> confirmar(List<QuizQuestion> perguntas) async {
    if (resposta == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione uma alternativa.'),
        ),
      );
      return;
    }

    final respostasAtualizadas = [
      ...respostas,
      QuizAnswer(
        questionId: perguntas[perguntaAtual].id,
        selectedOption: resposta!,
      ),
    ];

    if (perguntaAtual == perguntas.length - 1) {
      setState(() => enviando = true);
      try {
        final pontos = await AppRepositoryScope.of(context)
            .submitQuizAnswers(widget.courseId, respostasAtualizadas);
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ResultadoQuizPage(
              score: pontos,
              total: perguntas.length,
            ),
          ),
        );
      } on Exception catch (error) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Não foi possível enviar suas respostas: $error')),
        );
      } finally {
        if (mounted) setState(() => enviando = false);
      }
    } else {
      setState(() {
        respostas
          ..clear()
          ..addAll(respostasAtualizadas);
        perguntaAtual++;
        resposta = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz financeiro')),
      body: FutureBuilder<List<QuizQuestion>>(
        future: _questionsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Não foi possível carregar o quiz.'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final questions = snapshot.data!;
          if (questions.isEmpty) {
            return const Center(child: Text('Este curso não possui quiz.'));
          }
          return _buildQuiz(questions);
        },
      ),
    );
  }

  Widget _buildQuiz(List<QuizQuestion> perguntas) {
    final pergunta = perguntas[perguntaAtual];

    return ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Pergunta ${perguntaAtual + 1} de ${perguntas.length}',
            style: const TextStyle(
              color: AppPalette.roxo,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: (perguntaAtual + 1) / perguntas.length,
              minHeight: 8,
              color: AppPalette.roxo,
              backgroundColor: AppPalette.borda,
            ),
          ),
          const SizedBox(height: 25),
          Text(
            pergunta.question,
            style: const TextStyle(
              color: AppPalette.roxoEscuro,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 20),
          RadioGroup<int>(
            groupValue: resposta,
            onChanged: (valor) {
              setState(() => resposta = valor);
            },
            child: Column(
              children: pergunta.options.asMap().entries.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: RadioListTile<int>(
                    value: item.key,
                    title: Text(item.value),
                    activeColor: AppPalette.roxo,
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                      side: const BorderSide(color: AppPalette.borda),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 15),
          Botao(
            texto: enviando ? 'Enviando...' : 'Confirmar resposta',
            onPressed: enviando ? null : () => confirmar(perguntas),
          ),
        ],
      );
  }
}