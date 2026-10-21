import 'package:educa_financa/data/app_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DemoAppRepository', () {
    late DemoAppRepository repository;

    setUp(() {
      repository = DemoAppRepository();
    });

    test('exposes course data using stable identifiers', () async {
      final courses = await repository.getCourses();
      final course = await repository.getCourse('financial-planning');

      expect(courses, hasLength(6));
      expect(course?.title, 'Planejamento e Organização Financeira');
      expect(course?.modules, isNotEmpty);
    });

    test('calculates a report balance from repository data', () async {
      final report = await repository.getFinancialReport();

      expect(report.income, 4850);
      expect(report.expenses, 2340);
      expect(report.balance, 2510);
      expect(report.transactions, hasLength(4));
    });

    test('submits quiz answers and returns the score', () async {
      final score = await repository.submitQuizAnswers(
        'financial-planning',
        const [
          QuizAnswer(questionId: 'budget-basics', selectedOption: 1),
          QuizAnswer(questionId: 'emergency-fund', selectedOption: 0),
          QuizAnswer(questionId: 'avoid-debt', selectedOption: 2),
        ],
      );

      expect(score, 3);
    });

    test('rejects quiz data for an unknown course', () async {
      expect(
        () => repository.getQuizQuestions('unknown-course'),
        throwsArgumentError,
      );
    });

    test('tracks the current user until sign out', () async {
      final user = await repository.signIn(
        email: 'teste@example.com',
        password: 'senha',
      );

      expect((await repository.getCurrentUser())?.id, user.id);
      await repository.signOut();
      expect(await repository.getCurrentUser(), isNull);
    });
  });
}
