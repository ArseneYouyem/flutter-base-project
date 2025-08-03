import 'dart:convert';

LocationModel locationModelFromJson(String str) =>
    LocationModel.fromJson(json.decode(str));
String locationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  bool? status;
  String? timezone;
  String? country;
  String? countryCode;
  String? regionName;
  String? city;
  double? lat;
  double? lon;
  bool get isAfrica =>
      "${timezone?.split("/").first}".toLowerCase() == "africa";

  LocationModel({
    this.status,
    this.timezone,
    this.country,
    this.countryCode,
    this.regionName,
    this.city,
    this.lat,
    this.lon,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        status: json["status"] == "success",
        timezone: json["timezone"],
        country: json["country"],
        countryCode: json["countryCode"],
        regionName: json["regionName"],
        city: json["city"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "status": status! ? "success" : "fail",
        "timezone": timezone,
        "country": country,
        "countryCode": countryCode,
        "regionName": regionName,
        "city": city,
        "lat": lat,
        "lon": lon,
      };
}
