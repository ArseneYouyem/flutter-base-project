import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ErrorInterceptor {
  static String parseExecption(Exception err) {
    String errorMessage = "Une erreur est survenue";
    if (err is! DioException) {
      errorMessage = "$errorMessage $err";
    } else {
      if (err.response != null) {
        // Erreur avec réponse du serveur
        switch (err.response?.statusCode) {
          case 400:
            errorMessage = _parseBadRequestError(err.response?.data);
            break;
          case 401:
            errorMessage = "Session expirée. Veuillez vous reconnecter.";
            break;
          case 403:
            errorMessage = "Accès refusé";
            break;
          case 404:
            errorMessage = "Ressource non trouvée";
            break;
          case 500:
            errorMessage = "Erreur interne du serveur";
            break;
          default:
            errorMessage = "Erreur serveur (${err.response?.statusCode})";
        }
        if (kDebugMode) {
          var otherError1 = err.response?.data["error"] != null
              ? err.response?.data["error"].runtimeType == String
                  ? err.response?.data["error"]
                  : err.response?.data["error"]["message"]
              : "";
          var otherError2 = err.response?.data["errors"] ?? "";
          errorMessage = "$errorMessage\n$otherError1\n$otherError2";
        }
      } else {
        // Erreur sans réponse du serveur
        switch (err.type) {
          case DioExceptionType.connectionTimeout:
            errorMessage = "Temps de connexion écoulé";
            break;
          case DioExceptionType.sendTimeout:
            errorMessage = "Temps d'envoi écoulé";
            break;
          case DioExceptionType.receiveTimeout:
            errorMessage = "Temps de réponse écoulé";
            break;
          case DioExceptionType.badCertificate:
            errorMessage = "Certificat invalide";
            break;
          case DioExceptionType.cancel:
            errorMessage = "Requête annulée";
            break;
          case DioExceptionType.connectionError:
            errorMessage = "Erreur réseau. Vérifiez votre connexion internet";
            break;
          case DioExceptionType.unknown:
            errorMessage = "Erreur réseau. Vérifiez votre connexion internet";
            break;
          case DioExceptionType.badResponse:
            errorMessage = "Mauvaire reponse";
            break;
        }
      }
    }

    return errorMessage;
  }

  static String _parseBadRequestError(dynamic errorData) {
    try {
      if (errorData is Map<String, dynamic>) {
        return errorData['message'] ?? errorData['error'] ?? "Requête invalide";
      }
      return "Requête invalide";
    } catch (e) {
      return "Erreur lors du traitement de la requête";
    }
  }
}
