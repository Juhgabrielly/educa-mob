import 'package:flutter/widgets.dart';

import 'app_repository.dart';

class AppRepositoryScope extends InheritedWidget {
  final AppRepository repository;

  const AppRepositoryScope({
    super.key,
    required this.repository,
    required super.child,
  });

  static AppRepository of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<AppRepositoryScope>();
    assert(scope != null, 'AppRepositoryScope não encontrado na árvore.');
    return scope!.repository;
  }

  @override
  bool updateShouldNotify(AppRepositoryScope oldWidget) =>
      repository != oldWidget.repository;
}
