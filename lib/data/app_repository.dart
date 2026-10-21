class AppUser {
  final String id;
  final String name;
  final String email;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
  });
}

class Course {
  final String id;
  final String title;
  final String description;
  final String iconName;
  final List<String> modules;

  const Course({
    required this.id,
    required this.title,
    required this.description,
    required this.iconName,
    required this.modules,
  });

}

class CourseProgress {
  final Course course;
  final double completion;

  const CourseProgress({
    required this.course,
    required this.completion,
  });
}

class InvestmentHolding {
  final String name;
  final double percentage;

  const InvestmentHolding({required this.name, required this.percentage});
}

class InvestmentPortfolio {
  final double total;
  final double returnPercentage;
  final List<InvestmentHolding> holdings;

  const InvestmentPortfolio({
    required this.total,
    required this.returnPercentage,
    required this.holdings,
  });
}

class FinancialTransaction {
  final String name;
  final String category;
  final double amount;
  final DateTime date;

  const FinancialTransaction({
    required this.name,
    required this.category,
    required this.amount,
    required this.date,
  });

  bool get isIncome => amount >= 0;
}

class FinancialReport {
  final double income;
  final double expenses;
  final List<FinancialTransaction> transactions;

  const FinancialReport({
    required this.income,
    required this.expenses,
    required this.transactions,
  });

  double get balance => income - expenses;
}

class FinancialGoal {
  final String id;
  final String title;
  final double saved;
  final double target;

  const FinancialGoal({
    required this.id,
    required this.title,
    required this.saved,
    required this.target,
  });

  double get progress => target <= 0 ? 0 : (saved / target).clamp(0, 1);
}

class SubscriptionPlan {
  final String id;
  final String name;
  final String price;
  final List<String> features;

  const SubscriptionPlan({
    required this.id,
    required this.name,
    required this.price,
    required this.features,
  });
}

class QuizQuestion {
  final String id;
  final String question;
  final List<String> options;
  final int correctOption;

  const QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctOption,
  });
}

class QuizAnswer {
  final String questionId;
  final int selectedOption;

  const QuizAnswer({
    required this.questionId,
    required this.selectedOption,
  });
}

abstract interface class AppRepository {
  Future<AppUser> signIn({required String email, required String password});
  Future<AppUser> register({
    required String name,
    required String email,
    required String password,
  });
  Future<AppUser?> getCurrentUser();
  Future<void> signOut();

  Future<List<Course>> getCourses();
  Future<Course?> getCourse(String id);
  Future<CourseProgress?> getContinueLearning();
  Future<InvestmentPortfolio> getInvestmentPortfolio();
  Future<FinancialReport> getFinancialReport();
  Future<List<FinancialGoal>> getFinancialGoals();
  Future<List<SubscriptionPlan>> getSubscriptionPlans();
  Future<void> selectSubscriptionPlan(String planId);
  Future<List<QuizQuestion>> getQuizQuestions(String courseId);
  Future<int> submitQuizAnswers(String courseId, List<QuizAnswer> answers);
}

class DemoAppRepository implements AppRepository {
  AppUser? _currentUser;

  static const courses = [
    Course(
      id: 'financial-planning',
      title: 'Planejamento e Organização Financeira',
      description: 'Organize receitas, despesas e orçamento.',
      iconName: 'account_balance_wallet',
      modules: [
        'Introdução aos conceitos fundamentais',
        'Organizando suas finanças',
        'Planejando objetivos financeiros',
        'Colocando o conhecimento em prática',
      ],
    ),
    Course(
      id: 'debt-credit',
      title: 'Gestão de Dívidas e Crédito',
      description: 'Entenda juros, crédito e dívidas.',
      iconName: 'credit_card',
      modules: [
        'Como funcionam os juros',
        'Uso consciente do crédito',
        'Estratégias para quitar dívidas',
        'Prevenção do endividamento',
      ],
    ),
    Course(
      id: 'investments',
      title: 'Investimentos',
      description: 'Conheça os conceitos básicos de investimentos.',
      iconName: 'trending_up',
      modules: [
        'Risco e retorno',
        'Renda fixa',
        'Renda variável',
        'Como montar uma carteira',
      ],
    ),
    Course(
      id: 'financial-math',
      title: 'Matemática Financeira',
      description: 'Aprenda porcentagem e juros.',
      iconName: 'calculate',
      modules: [
        'Porcentagens no dia a dia',
        'Juros simples',
        'Juros compostos',
        'Comparação de propostas',
      ],
    ),
    Course(
      id: 'business-finance',
      title: 'Educação Financeira Empresarial',
      description: 'Finanças para o ambiente profissional.',
      iconName: 'business_center',
      modules: [
        'Finanças pessoais e trabalho',
        'Planejamento de renda',
        'Benefícios e orçamento',
        'Decisões financeiras profissionais',
      ],
    ),
    Course(
      id: 'economic-psychology',
      title: 'Psicologia Econômica',
      description: 'Entenda suas decisões financeiras.',
      iconName: 'psychology',
      modules: [
        'Hábitos e decisões',
        'Consumo consciente',
        'Emoções e dinheiro',
        'Mudança de comportamento',
      ],
    ),
  ];

  static const quizQuestions = [
    QuizQuestion(
      id: 'budget-basics',
      question: 'Qual é o primeiro passo para organizar as finanças?',
      options: [
        'Ignorar as despesas',
        'Anotar receitas e despesas',
        'Fazer um empréstimo',
        'Comprar mais',
      ],
      correctOption: 1,
    ),
    QuizQuestion(
      id: 'emergency-fund',
      question: 'O que é uma reserva de emergência?',
      options: [
        'Dinheiro para imprevistos',
        'Limite do cartão',
        'Uma dívida',
        'Uma compra parcelada',
      ],
      correctOption: 0,
    ),
    QuizQuestion(
      id: 'avoid-debt',
      question: 'Qual atitude ajuda a evitar dívidas?',
      options: [
        'Gastar antes de receber',
        'Não acompanhar despesas',
        'Planejar o orçamento',
        'Pagar somente o mínimo',
      ],
      correctOption: 2,
    ),
  ];

  static const _plans = [
    SubscriptionPlan(
      id: 'free',
      name: 'Plano Gratuito',
      price: 'R\$ 0',
      features: [
        'Cursos selecionados',
        'Acompanhamento básico',
        'Quiz de aprendizagem',
      ],
    ),
    SubscriptionPlan(
      id: 'premium',
      name: 'Plano Premium',
      price: 'R\$ 19,90/mês',
      features: [
        'Acesso a todos os cursos',
        'Relatórios completos',
        'Metas personalizadas',
        'Conteúdo exclusivo',
      ],
    ),
  ];

  @override
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    _currentUser = AppUser(
      id: 'demo-user',
      name: email.split('@').first,
      email: email,
    );
    return _currentUser!;
  }

  @override
  Future<AppUser> register({
    required String name,
    required String email,
    required String password,
  }) async {
    _currentUser = AppUser(id: 'demo-user', name: name, email: email);
    return _currentUser!;
  }

  @override
  Future<AppUser?> getCurrentUser() async => _currentUser;

  @override
  Future<void> signOut() async {
    _currentUser = null;
  }

  @override
  Future<List<Course>> getCourses() async => courses;

  @override
  Future<Course?> getCourse(String id) async {
    for (final course in courses) {
      if (course.id == id) return course;
    }
    return null;
  }

  @override
  Future<CourseProgress?> getContinueLearning() async => CourseProgress(
        course: courses.first,
        completion: 0.65,
      );

  @override
  Future<InvestmentPortfolio> getInvestmentPortfolio() async =>
      const InvestmentPortfolio(
        total: 24315.30,
        returnPercentage: 18.1,
        holdings: [
          InvestmentHolding(name: 'Tesouro Direto', percentage: 35),
          InvestmentHolding(name: 'CDB', percentage: 25),
          InvestmentHolding(name: 'Fundos', percentage: 17),
          InvestmentHolding(name: 'Ações', percentage: 23),
        ],
      );

  @override
  Future<FinancialReport> getFinancialReport() async => FinancialReport(
        income: 4850,
        expenses: 2340,
        transactions: [
          FinancialTransaction(
            name: 'Salário',
            category: 'Receita',
            amount: 3500,
            date: DateTime(2026, 10, 5),
          ),
          FinancialTransaction(
            name: 'Aluguel',
            category: 'Moradia',
            amount: -1200,
            date: DateTime(2026, 10, 6),
          ),
          FinancialTransaction(
            name: 'Freelance',
            category: 'Receita',
            amount: 1350,
            date: DateTime(2026, 10, 7),
          ),
          FinancialTransaction(
            name: 'Supermercado',
            category: 'Alimentação',
            amount: -320,
            date: DateTime(2026, 10, 8),
          ),
        ],
      );

  @override
  Future<List<FinancialGoal>> getFinancialGoals() async => const [
        FinancialGoal(
          id: 'emergency-fund',
          title: 'Reserva de emergência',
          saved: 2400,
          target: 5000,
        ),
        FinancialGoal(
          id: 'vacation',
          title: 'Viagem de férias',
          saved: 1200,
          target: 3000,
        ),
        FinancialGoal(
          id: 'computer',
          title: 'Novo computador',
          saved: 2100,
          target: 3500,
        ),
      ];

  @override
  Future<List<SubscriptionPlan>> getSubscriptionPlans() async => _plans;

  @override
  Future<void> selectSubscriptionPlan(String planId) async {
    if (!_plans.any((plan) => plan.id == planId)) {
      throw ArgumentError.value(planId, 'planId', 'Plano desconhecido');
    }
  }

  @override
  Future<List<QuizQuestion>> getQuizQuestions(String courseId) async {
    if (await getCourse(courseId) == null) {
      throw ArgumentError.value(courseId, 'courseId', 'Curso desconhecido');
    }
    return quizQuestions;
  }

  @override
  Future<int> submitQuizAnswers(
    String courseId,
    List<QuizAnswer> answers,
  ) async {
    final questions = await getQuizQuestions(courseId);
    return answers.where((answer) {
      final question = questions.where(
        (question) => question.id == answer.questionId,
      );
      return question.isNotEmpty &&
          answer.selectedOption == question.first.correctOption;
    }).length;
  }
}
