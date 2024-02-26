class AppConstants {
  static const APP_NAME = "FOOD_app";
  static const APP_VERSION = 1;
  static const String BASE_URL = "http://167.172.76.153/shopping-app/public";
  //if the api online doesn't work.
  //static const String BASE_URL = "http://localhost/shopping-app/public";
  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";

  //auth
  static const String REGISTRATION_URI = "/api/v1/auth/register";
  static const String LOGIN_URI = "/api/v1/auth/login";
  static const String USER_INFO_URI = "/api/v1/customer/info";

  //google map and address
  static const String GEOCODE_URI = "/api/v1/config/geocode-api";
  static const String USER_ADDRESS = "user_address";

  static const String ADD_USER_ADDRESS = "/api/v1/customer/address/add";
  static const String ADDRESS_LIST_URI = "/api/v1/customer/address/list";
  static const String ZONE_URI = "/api/v1/config/get-zone-id";
  static const String SEARCH_LOCATION_URI =
      "/api/v1/config/place-api-autocomplete";
  static const String PLACE_DETAIL_URI = "/api/v1/config/place-api-details";

  static const String UPLOADS = "/uploads/";
  static const String TOKEN = "";
  static const String PHONE = "";
  static const String PASSWORD = "";
  static const String CART_LIST = "cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";

/*REMAKE API*/

  // static const String BASE_URL = "http://localhost/backend-laravel/public";
  // static const String POPULAR_PRODUCT_URI = "/api/v1/popular";
  // static const String UPLOADS = "/storage/";
}
