// TODO Implement this library.
class CovidData {
  final String name;
  final String flag;
  final int todayDeaths;
  final int todayConfirmed;
  final int todayRecovered;
  final int totalDeaths;
  final int totalConfirmed;
  final int totalRecovered;
  final int totalCritical;
  final int totalActive;
  final int Population;

  CovidData({
    required this.name,
    required this.flag,
    required this.todayDeaths,
    required this.todayConfirmed,
    required this.todayRecovered,
    required this.totalDeaths,
    required this.totalConfirmed,
    required this.totalRecovered,
    required this.totalCritical,
    required this.totalActive,
    required this.Population,
  });

  factory CovidData.fromJson({required json}) {
    return CovidData(
      name: json["country"],
      flag: json["countryInfo"]["flag"],
      todayDeaths: json["todayDeaths"],
      todayConfirmed: json["todayCases"],
      todayRecovered: json["todayRecovered"],
      totalDeaths: json["deaths"],
      totalConfirmed: json["cases"],
      totalRecovered: json["recovered"],
      totalCritical: json["critical"],
      totalActive: json["active"],
      Population: json["population"],
    );
  }
}
