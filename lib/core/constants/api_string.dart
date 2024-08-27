
class ApiString {
  static Uri endPoint(String url) {
    // return Uri.parse("http://10.0.2.2:8000/api/$url");
    return Uri.parse("https://smalltin.com/api/$url");
  }

  static String socketUrl() {
    return "realtime.smalltin.com";
    // if (Platform.isAndroid) {
    //   // return "http://10.0.2.2:3000";
    //   return "https://realtime.smalltin.com";
    // } else {
    //   // return "http://localhost:3000";
    //   return "https://realtime.smalltin.com";
    // }
  }

  static String imageUrl(String url) {
    // return "http://10.0.2.2:8000/storage/$url";
    return "https://smalltin.com/storage/$url";
  }

  static const String apiquiss = "8d08056b-bc4f-453d-93e4-cccead7fdb75";
}
