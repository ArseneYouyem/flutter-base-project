import 'package:flutter_dotenv/flutter_dotenv.dart';

// class ApiKey {
//   static final googleApiKey = dotenv.get('GOOGLE_API_KEY');
//   static final mapboxApiKey = dotenv.get('MAPBOX_API_KEY');
// }

class ApiPaths {
  static const prod = true;
  static final baseUrl = dotenv.get(prod ? 'BASE_URL_PROD' : 'BASE_URL_DEV');

  static String apiUrl = "";
  static const String imageUrl = "";

////////////////////////All api Path//////////////////////////

//auth
  static final String login = "$apiUrl/json/";
  static final String userData = "$apiUrl/user";
  static final String refreshToken = "$apiUrl/auth/refresh-token";
  static final String logOut = "$apiUrl/auth/logout";
}
