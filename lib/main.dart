import 'package:flutter/material.dart';

import 'ui/splash.dart';
import 'ui/login.dart';
import 'ui/home.dart';
import 'ui/curso.dart';
import 'ui/cursos_detalhes.dart';
import 'ui/investimentos.dart';
import 'ui/relatorios.dart';
import 'ui/perfil.dart';
import 'ui/planos.dart';
import 'ui/quiz.dart';

void main() {
  runApp(const EducaFinancaApp());
}

class EducaFinancaApp extends StatelessWidget {
  const EducaFinancaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Educa Finança',

      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6D28D9),
        ),

        scaffoldBackgroundColor: const Color(0xFFF6F0FF),

        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF2D1457),
        ),
      ),

      // PRIMEIRA TELA
      home: const SplashScreen(),

      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/cursos': (context) => const CursosPage(),

        '/curso-detalhes': (context) => const CursoDetalhesPage(
              titulo: 'Curso',
            ),

        '/investimentos': (context) => const InvestimentosPage(),
        '/relatorios': (context) => const RelatoriosPage(),
        '/perfil': (context) => const PerfilPage(),
        '/planos': (context) => const PlanosPage(),
        '/quiz': (context) => const QuizPage(),
      },
    );
  }
}