// lib/models/spot_model.dart

class Spot {
  final int id;
  final String name;
  final String type;
  final double lat;
  final double lon;
  final String description;

  String? distanceDisplay; // Misal: "3.2 km"
  double? distanceValue; // Nilai numerik jarak dalam kilometer (untuk sorting)

  Spot({
    required this.id,
    required this.name,
    required this.type,
    required this.lat,
    required this.lon,
    required this.description,
    this.distanceDisplay,
    this.distanceValue,
  });
}
