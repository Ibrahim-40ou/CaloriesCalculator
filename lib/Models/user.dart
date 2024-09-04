class MyUser {
  late String? userId;
  late String fullName;
  late String email;
  late String measurementSystem;
  late String gender;
  late double age;
  late double height;
  late double weight;
  late String activityLevel;
  late double proteinPercentage;
  late double carbsPercentage;
  late double fatPercentage;
  late double bmr;
  late double calories;
  late double proteinInGrams;
  late double carbsInGrams;
  late double fatInGrams;

  MyUser({
    required this.userId,
    required this.fullName,
    required this.email,
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
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'measurementSystem': measurementSystem,
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
    };
  }

  static MyUser fromJson(Map<String, dynamic> user) {
    return MyUser(
      userId: user['userId'],
      fullName: user['fullName'],
      email: user['email'],
      measurementSystem: user['measurementSystem'],
      gender: user['gender'],
      age: user['age'],
      height: user['height'],
      weight: user['weight'],
      activityLevel: user['activityLevel'],
      proteinPercentage: user['proteinPercentage'],
      carbsPercentage: user['carbsPercentage'],
      fatPercentage: user['fatPercentage'],
      bmr: user['bmr'],
      calories: user['calories'],
      proteinInGrams: user['proteinInGrams'],
      carbsInGrams: user['carbsInGrams'],
      fatInGrams: user['fatInGrams'],
    );
  }
}
