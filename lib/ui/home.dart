import 'package:flutter/material.dart';

import '../root/pallet.dart';
import 'card.dart';
import 'logo.dart';
import 'curso.dart';
import 'investimentos.dart';
import 'relatorios.dart';
import 'perfil.dart';
import 'metas.dart';

// ======================================================
// 1. PÁGINA PRINCIPAL
// ======================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pagina = 0;

  final List<Widget> telas = const [
    InicioPage(),
    CursosPage(),
    InvestimentosPage(),
    RelatoriosPage(),
    PerfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPalette.fundo,
        foregroundColor: AppPalette.texto,
        elevation: 0,
        title: const Logo(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),

      body: telas[pagina],

      bottomNavigationBar: NavigationBar(
        selectedIndex: pagina,
        indicatorColor: AppPalette.roxoClaro,

        onDestinationSelected: (valor) {
          setState(() {
            pagina = valor;
          });
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
            selectedIcon: Icon(Icons.trending_up),
            label: 'Investimentos',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Relatórios',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

// ======================================================
// 2. TELA INICIAL
// ======================================================

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================================================
            // TÍTULO PRINCIPAL
            // ==================================================

            const Text(
              'Aprenda no ritmo\ne evolua sua vida\nfinanceira.',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w800,
                height: 1.12,
                color: AppPalette.roxo,
                decoration: TextDecoration.none,
              ),
            ),

            const SizedBox(height: 10),

            // ==================================================
            // SUBTÍTULO
            // ==================================================

            const Text(
              'Aprenda, organize sua vida financeira '
              'e tome decisões melhores.',
              style: TextStyle(
                fontSize: 14,
                color: AppPalette.cinza,
                height: 1.45,
                decoration: TextDecoration.none,
              ),
            ),

            const SizedBox(height: 22),

            // ==================================================
            // CARDS DE ACESSO RÁPIDO
            // ==================================================

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              crossAxisSpacing: 12,
              mainAxisSpacing: 12,

              childAspectRatio: 1.05,

              children: const [
                _CardHome(
                  icone: Icons.menu_book,
                  titulo: 'Cursos',
                  descricao: 'Aprenda sobre finanças.',
                  pagina: CursosPage(),
                ),

                _CardHome(
                  icone: Icons.bar_chart,
                  titulo: 'Relatórios',
                  descricao: 'Acompanhe seus resultados.',
                  pagina: RelatoriosPage(),
                ),

                _CardHome(
                  icone: Icons.trending_up,
                  titulo: 'Investimentos',
                  descricao: 'Veja seus investimentos.',
                  pagina: InvestimentosPage(),
                ),

                _CardHome(
                  icone: Icons.flag_outlined,
                  titulo: 'Metas',
                  descricao: 'Acompanhe seus objetivos.',
                  pagina: MetasPage(),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ==================================================
            // CARD DE PROGRESSO
            // ==================================================

            CardPadrao(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Continue aprendendo',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Planejamento e Organização Financeira',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const LinearProgressIndicator(
                    value: 0.65,
                    color: AppPalette.roxo,
                    backgroundColor: AppPalette.roxoClaro,
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    '65% concluído',
                    style: TextStyle(
                      color: AppPalette.cinza,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// 3. CARD DE ACESSO RÁPIDO
// ======================================================

class _CardHome extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String descricao;
  final Widget pagina;

  const _CardHome({
    required this.icone,
    required this.titulo,
    required this.descricao,
    required this.pagina,
  });

  @override
  Widget build(BuildContext context) {
    return CardPadrao(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => pagina,
          ),
        );
      },

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ícone
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppPalette.roxoClaro,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icone,
              color: AppPalette.roxo,
            ),
          ),

          const SizedBox(height: 12),

          // Título
          Text(
            titulo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),

          const SizedBox(height: 4),

          // Descrição
          Text(
            descricao,
            style: const TextStyle(
              fontSize: 11,
              color: AppPalette.cinza,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}