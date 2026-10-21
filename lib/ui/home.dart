
import 'package:flutter/material.dart';

import '../data/app_repository.dart';
import '../data/app_repository_scope.dart';
import '../root/pallet.dart';
import '../ui/logo.dart';
import 'curso.dart';
import 'investimentos.dart';
import 'relatorios.dart';
import 'perfil.dart';
import 'metas.dart';
import 'cursos_detalhes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selecionada = 0;

  final List<Widget> paginas = const [
    InicioConteudo(),
    CursosPage(),
    InvestimentosPage(),
    RelatoriosPage(),
    PerfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Logo(tamanho: 28, compacto: true),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Nenhuma notificação nova.'),
                ),
              );
            },
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: IndexedStack(
        index: selecionada,
        children: paginas,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selecionada,
        onDestinationSelected: (index) {
          setState(() => selecionada = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Cursos',
          ),
          NavigationDestination(
            icon: Icon(Icons.trending_up),
            label: 'Investir',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Relatórios',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class InicioConteudo extends StatelessWidget {
  const InicioConteudo({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'Sua jornada de educação financeira começa aqui.',
          style: TextStyle(
            color: AppPalette.roxoEscuro,
            fontSize: 25,
            height: 1.2,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 10),

        const Text(
          'Aprenda a cuidar do seu dinheiro com confiança.',
          style: TextStyle(
            color: AppPalette.textoSecundario,
            fontSize: 14,
            height: 1.4,
          ),
        ),

        const SizedBox(height: 22),

        const _ContinueLearningCard(),

        const SizedBox(height: 24),

        const Text(
          'Explore a plataforma',
          style: TextStyle(
            color: AppPalette.roxoEscuro,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 13),

        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.05,
          children: [
            _Atalho(
              icone: Icons.menu_book,
              titulo: 'Cursos',
              descricao: 'Aprenda no seu ritmo',
              aoTocar: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CursosPage(),
                  ),
                );
              },
            ),
            _Atalho(
              icone: Icons.pie_chart_outline,
              titulo: 'Relatórios',
              descricao: 'Veja sua evolução',
              aoTocar: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RelatoriosPage(),
                  ),
                );
              },
            ),
            _Atalho(
              icone: Icons.trending_up,
              titulo: 'Investimentos',
              descricao: 'Conheça possibilidades',
              aoTocar: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const InvestimentosPage(),
                  ),
                );
              },
            ),
            _Atalho(
              icone: Icons.flag_outlined,
              titulo: 'Metas',
              descricao: 'Planeje conquistas',
              aoTocar: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MetasPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _ContinueLearningCard extends StatelessWidget {
  const _ContinueLearningCard();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CourseProgress?>(
      future: AppRepositoryScope.of(context).getContinueLearning(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Não foi possível carregar seu curso atual.');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final progress = snapshot.data;
        if (progress == null) return const SizedBox.shrink();

        return Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppPalette.roxo, AppPalette.roxoClaro],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.auto_awesome, color: Colors.white, size: 21),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Continue aprendendo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                progress.course.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  height: 1.25,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 9),
              Text(
                progress.course.description,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 18),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: progress.completion,
                  minHeight: 8,
                  color: Colors.white,
                  backgroundColor: const Color(0x776D4DB1),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${(progress.completion * 100).round()}% concluído',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppPalette.roxo,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CursoDetalhesPage(
                        courseId: progress.course.id,
                      ),
                    ),
                  ),
                  child: const Text('Continuar curso'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Atalho extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String descricao;
  final VoidCallback aoTocar;

  const _Atalho({
    required this.icone,
    required this.titulo,
    required this.descricao,
    required this.aoTocar,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(17),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: aoTocar,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppPalette.borda,
            ),
            borderRadius: BorderRadius.circular(17),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFE5FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icone,
                  color: AppPalette.roxo,
                  size: 23,
                ),
              ),

              const Spacer(),

              Text(
                titulo,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppPalette.roxoEscuro,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                descricao,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppPalette.textoSecundario,
                  fontSize: 11,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}