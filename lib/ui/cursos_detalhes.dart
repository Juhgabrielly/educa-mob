
import 'package:flutter/material.dart';
import '../data/app_repository.dart';
import '../data/app_repository_scope.dart';
import '../root/pallet.dart';
import '../ui/card.dart';
import '../ui/botao.dart';
import 'quiz.dart';

class CursoDetalhesPage extends StatelessWidget {
  final String courseId;

  const CursoDetalhesPage({
    super.key,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do curso')),
      body: FutureBuilder<Course?>(
        future: AppRepositoryScope.of(context).getCourse(courseId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Não foi possível carregar os detalhes do curso.'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final course = snapshot.data;
          if (course == null) {
            return const Center(child: Text('Curso não encontrado.'));
          }

          return ListView(
            padding: const EdgeInsets.all(18),
            children: [
              const Icon(
                Icons.menu_book_rounded,
                color: AppPalette.roxo,
                size: 55,
              ),
              const SizedBox(height: 15),
              Text(
                course.title,
                style: const TextStyle(
                  color: AppPalette.roxoEscuro,
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                course.description,
                style: const TextStyle(
                  color: AppPalette.textoSecundario,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 22),
              const Text(
                'Conteúdo do curso',
                style: TextStyle(
                  color: AppPalette.roxoEscuro,
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              CardPadrao(
                child: Column(
                  children: course.modules.asMap().entries.map((item) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFFEFE5FF),
                        child: Text(
                          '${item.key + 1}',
                          style: const TextStyle(
                            color: AppPalette.roxo,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      title: Text(
                        item.value,
                        style: const TextStyle(fontSize: 13),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              Botao(
                texto: 'Iniciar Quiz',
                icone: Icons.quiz_outlined,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizPage(courseId: course.id),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}