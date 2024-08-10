class ApiString {
  static Uri endPoint(String url) {
    return Uri.parse("http://10.0.2.2:8000/api/$url");
    //return Uri.parse("https://smalltin.com/api/$url");
  }

  static const String apiquiss = "8d08056b-bc4f-453d-93e4-cccead7fdb75";
}
