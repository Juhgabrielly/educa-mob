
import 'package:flutter/material.dart';

import '../data/app_repository.dart';
import '../data/app_repository_scope.dart';
import '../root/pallet.dart';
import '../ui/card.dart';
import './cursos_detalhes.dart';

class CursosPage extends StatelessWidget {
  const CursosPage({super.key});

  IconData _iconeCurso(String iconName) => switch (iconName) {
        'credit_card' => Icons.credit_card,
        'trending_up' => Icons.trending_up,
        'calculate' => Icons.calculate,
        'business_center' => Icons.business_center,
        'psychology' => Icons.psychology,
        _ => Icons.account_balance_wallet,
      };

  Widget _buildCursoCard(BuildContext context, Course curso) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(17),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(17),
          splashColor: AppPalette.roxo.withValues(alpha: 0.10),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CursoDetalhesPage(courseId: curso.id),
              ),
            );
          },
          child: CardPadrao(
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFE5FF),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(_iconeCurso(curso.iconName), color: AppPalette.roxo),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        curso.title,
                        style: const TextStyle(
                          color: AppPalette.roxoEscuro,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        curso.description,
                        style: const TextStyle(
                          color: AppPalette.textoSecundario,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 9),
                      const Text(
                        'Ver conteúdo →',
                        style: TextStyle(
                          color: AppPalette.roxo,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Course>>(
      future: AppRepositoryScope.of(context).getCourses(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const _LoadError(
            message: 'Não foi possível carregar os cursos.',
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final cursos = snapshot.data!;
        return ListView(
          padding: const EdgeInsets.all(18),
          children: [
            const Text(
              'Nossos Cursos',
              style: TextStyle(
                color: AppPalette.roxoEscuro,
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Conhecimento para tomar decisões melhores.',
              style: TextStyle(
                color: AppPalette.textoSecundario,
                fontSize: 16,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            if (cursos.isEmpty)
              const Text('Nenhum curso disponível no momento.')
            else
              ...cursos.map((curso) => _buildCursoCard(context, curso)),
          ],
        );
      },
    );
  }
}

class _LoadError extends StatelessWidget {
  final String message;

  const _LoadError({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppPalette.textoSecundario),
        ),
      ),
    );
  }
}