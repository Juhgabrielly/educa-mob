
import 'package:flutter/material.dart';
import 'data/app_repository.dart';
import 'data/app_repository_scope.dart';
import 'root/theme.dart';
import './ui/splash.dart';

void main() {
  runApp(EducaFinancaApp(repository: DemoAppRepository()));
}

class EducaFinancaApp extends StatelessWidget {
  final AppRepository repository;

  const EducaFinancaApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Educa Finança',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SplashScreen(),
      builder: (context, child) => AppRepositoryScope(
        repository: repository,
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}