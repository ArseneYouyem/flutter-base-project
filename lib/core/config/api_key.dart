import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiKey {
  static final googleApiKey = dotenv.get('GOOGLE_API_KEY');
  static final mapboxApiKey = dotenv.get('MAPBOX_API_KEY');
}

class ApiPaths {
  static const prod = true;
  static final baseUrl = dotenv.get(prod ? 'BASE_URL_PROD' : 'BASE_URL_DEV');

  static String apiUrl = "$baseUrl/api/v2";
  static const String imageUrl = "";

  static final String refreshToken = "$apiUrl/auth/refresh-token";
  static final String logOut = "$apiUrl/auth/logout";

////////////////////////All api Path//////////////////////////

//auth
  static final String login = "$apiUrl/login";
}
