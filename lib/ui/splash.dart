
import 'dart:async';
import 'package:flutter/material.dart';
import '../root/pallet.dart';
import '../ui/logo.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const _gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF7F2FF),
      Color(0xFFEDE4FF),
      Color(0xFFDCC8FF),
    ],
  );

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> escala;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    escala = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutBack,
    );

    controller.forward();

    Timer(const Duration(milliseconds: 2200), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: SplashScreen._gradient,
        ),
        child: Center(
          child: ScaleTransition(
            scale: escala,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Logo(tamanho: 76),
                SizedBox(height: 28),
                Text(
                  'Educa Finança',
                  style: TextStyle(
                    color: AppPalette.roxoEscuro,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Aprenda. Organize. Evolua.',
                  style: TextStyle(
                    color: AppPalette.textoSecundario,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 35),
                SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: AppPalette.roxo,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}