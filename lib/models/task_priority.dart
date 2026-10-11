enum TaskPriority {
  low,
  medium,
  high;

  String get label => switch (this) {
        TaskPriority.low => 'Low',
        TaskPriority.medium => 'Medium',
        TaskPriority.high => 'High',
      };


  int get weight => index;

  static TaskPriority fromName(String? name) => TaskPriority.values.firstWhere(
        (p) => p.name == name,
        orElse: () => TaskPriority.medium,
      );
}
