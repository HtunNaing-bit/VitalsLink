/// Scenario Model for Prescriptive Digital Twinning
class Scenario {
  final String id;
  final String name;
  final List<String> actions;
  final Map<String, double> predictedImpact;
  final DateTime creationDate;

  Scenario({
    required this.id,
    required this.name,
    required this.actions,
    required this.predictedImpact,
    required this.creationDate,
  });

  Scenario copyWith({
    String? id,
    String? name,
    List<String>? actions,
    Map<String, double>? predictedImpact,
    DateTime? creationDate,
  }) {
    return Scenario(
      id: id ?? this.id,
      name: name ?? this.name,
      actions: actions ?? this.actions,
      predictedImpact: predictedImpact ?? this.predictedImpact,
      creationDate: creationDate ?? this.creationDate,
    );
  }
}
