class Evaluate {
  final String sb; // Use final for immutability
  final double mk; // Use final for immutability

  // Use required keyword for null safety
  Evaluate({required this.sb, required this.mk});

  // Convert the Evaluate object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'sb': sb,
      'mk': mk,
    };
  }
}

class EvaluateList {
  final List<Evaluate> evaluateList; // Use final for immutability

  // Use required keyword for null safety and initialize the list
  EvaluateList({required this.evaluateList});
}

// Function to extract evaluations from a map
List<Evaluate> extractEvaluation(List<dynamic> evMap) {
  return evMap.map((item) {
    return Evaluate(
      sb: item['sb'].toString(),
      mk: double.tryParse(item['mk'].toString()) ?? 0.0, // Safely parse to double
    );
  }).toList(); // Convert to a List<Evaluate>
}
