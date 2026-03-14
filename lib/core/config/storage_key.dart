class StorageKey {
  static const token = "token";
  static const refreshToken = "refreshToken";
  static const user = "user";
  static const appIsInit = "appIsInit";
  static const myLocation = "myLocation";

  static String cacheKey(Uri uri) => 'cache_GET_$uri';
}
