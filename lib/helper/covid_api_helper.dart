import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/covid.dart';

class CovidApiHelper {
  CovidApiHelper._();

  static final CovidApiHelper covidApiHelper = CovidApiHelper._();

  final String URL = "https://disease.sh/v3/covid-19/countries";

  Future<List<CovidData>?> fetchCovidData() async {
    http.Response res = await http.get(
      Uri.parse(URL),
    );

    if (res.statusCode == 200) {
      List decodedData = jsonDecode(res.body);

      List<CovidData> covidData = decodedData.map((e) {
        return CovidData.fromJson(json: e);
      }).toList();
      return covidData;
    }
    return null;
  }
}
