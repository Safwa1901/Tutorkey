class Rate {
  final double theRate;

  Rate({
    required this.theRate,
  });
}

double calculateRating(double oldR, double newR) {
  // Ensure oldR and newR are valid (not negative or exceeding a max rating, if any)
  if (oldR < 0 || newR < 0) {
    throw ArgumentError("Ratings cannot be negative.");
  }

  return (oldR + newR) / 2; // Calculate the average
}
