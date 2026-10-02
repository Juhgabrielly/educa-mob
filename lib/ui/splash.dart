
import 'dart:async';

import 'package:flutter/material.dart';

import '../root/pallet.dart';
import 'login.dart';


// ============================================================
// SPLASH SCREEN
// ============================================================

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


// ============================================================
// ESTADO
// ============================================================

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  late Animation<double> _opacity;


  // ==========================================================
  // INIT
  // ==========================================================

  @override
  void initState() {
    super.initState();

    // --------------------------------------------------------
    // CONTROLLER
    // --------------------------------------------------------

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 900,
      ),
    );


    // --------------------------------------------------------
    // FADE
    // --------------------------------------------------------

    _opacity = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );


    // --------------------------------------------------------
    // INICIA ANIMAÇÃO
    // --------------------------------------------------------

    _controller.forward();


    // --------------------------------------------------------
    // ABRE LOGIN DEPOIS DE 1,8 SEGUNDOS
    // --------------------------------------------------------

    Timer(
      const Duration(
        milliseconds: 1800,
      ),
      () {

        if (!mounted) {
          return;
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginPage(),
          ),
        );
      },
    );
  }


  // ==========================================================
  // DISPOSE
  // ==========================================================

  @override
  void dispose() {

    _controller.dispose();

    super.dispose();
  }


  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,

        height: double.infinity,

        // ----------------------------------------------------
        // FUNDO GRADIENTE
        // ----------------------------------------------------

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            colors: [
              Color(0xFFF7F2FF),
              Color(0xFFEDE4FF),
              Color(0xFFDCC8FF),
            ],

            begin: Alignment.topLeft,

            end: Alignment.bottomRight,
          ),
        ),


        // ----------------------------------------------------
        // CONTEÚDO
        // ----------------------------------------------------

        child: SafeArea(

          child: Center(

            child: FadeTransition(

              opacity: _opacity,

              child: Padding(

                padding: const EdgeInsets.all(24),

                child: Column(

                  mainAxisSize: MainAxisSize.min,

                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  crossAxisAlignment:
                      CrossAxisAlignment.center,

                  children: [

                    // ========================================
                    // LOGO
                    // ========================================

                    Image.asset(
                      'assets/educa.png',

                      width: 130,

                      height: 130,

                      fit: BoxFit.contain,
                    ),


                    const SizedBox(
                      height: 18,
                    ),


                    // ========================================
                    // NOME
                    // ========================================

                    const Text(

                      'Educa Finança',

                      textAlign:
                          TextAlign.center,

                      style: TextStyle(

                        color:
                            AppPalette.roxo,

                        fontSize: 30,

                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),


                    const SizedBox(
                      height: 8,
                    ),


                    // ========================================
                    // SUBTÍTULO
                    // ========================================

                    const Text(

                      'Aprenda. Organize. Evolua.',

                      textAlign:
                          TextAlign.center,

                      style: TextStyle(

                        color:
                            AppPalette.texto,

                        fontSize: 14,
                      ),
                    ),


                    const SizedBox(
                      height: 30,
                    ),


                    // ========================================
                    // LOADING
                    // ========================================

                    const SizedBox(

                      width: 28,

                      height: 28,

                      child:
                          CircularProgressIndicator(

                        strokeWidth: 2.5,

                        color:
                            AppPalette.roxo,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}