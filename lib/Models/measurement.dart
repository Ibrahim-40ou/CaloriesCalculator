class Measurement {
  late String? measurementId;
  final String fullName;
  final String gender;
  final double age;
  final double height;
  final double weight;
  final String activityLevel;
  final double proteinPercentage;
  final double carbsPercentage;
  final double fatPercentage;
  final double bmr;
  final double calories;
  final double proteinInGrams;
  final double carbsInGrams;
  final double fatInGrams;
  late String measurementSystem;
  final String date;

  Measurement({
    this.measurementId,
    required this.fullName,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.activityLevel,
    required this.proteinPercentage,
    required this.carbsPercentage,
    required this.fatPercentage,
    required this.bmr,
    required this.calories,
    required this.proteinInGrams,
    required this.carbsInGrams,
    required this.fatInGrams,
    required this.measurementSystem,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'measurementId': measurementId,
      'fullName': fullName,
      'gender': gender,
      'age': age,
      'height': height,
      'weight': weight,
      'activityLevel': activityLevel,
      'proteinPercentage': proteinPercentage,
      'carbsPercentage': carbsPercentage,
      'fatPercentage': fatPercentage,
      'bmr': bmr,
      'calories': calories,
      'proteinInGrams': proteinInGrams,
      'carbsInGrams': carbsInGrams,
      'fatInGrams': fatInGrams,
      'measurementSystem': measurementSystem,
      'date' : date,
    };
  }

  static Measurement fromJson(Map<String, dynamic> measurement) {
    return Measurement(
      measurementId: measurement['measurementId'],
      fullName: measurement['fullName'],
      gender: measurement['gender'],
      age: measurement['age'],
      height: measurement['height'],
      weight: measurement['weight'],
      activityLevel: measurement['activityLevel'],
      proteinPercentage: measurement['proteinPercentage'],
      carbsPercentage: measurement['carbsPercentage'],
      fatPercentage: measurement['fatPercentage'],
      bmr: measurement['bmr'],
      calories: measurement['calories'],
      proteinInGrams: measurement['proteinInGrams'],
      carbsInGrams: measurement['carbsInGrams'],
      fatInGrams: measurement['fatInGrams'],
      measurementSystem: measurement['measurementSystem'],
      date: measurement['date'],
    );
  }
}
