// To parse this JSON data, do
//
//     final userAuth = userAuthFromJson(jsonString);

class User {
  dynamic id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
  });

  String get getFullName => "${firstName ?? ""} ${lastName ?? ""}".trim();

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
      };
}
