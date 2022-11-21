import 'package:flutter/material.dart';

import 'helper/covid_api_helper.dart';
import 'models/covid.dart';

void main() {
  runApp(MaterialApp(
    home: Homepage(),
  ));
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  dynamic selectedCountry;
  List country = [];
  List flag = [];
  dynamic i;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid App"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: FutureBuilder(
                  future: CovidApiHelper.covidApiHelper.fetchCovidData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error : ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      List<CovidData> data = snapshot.data as List<CovidData>;
                      country = data.map((e) => e.name).toList();
                      return Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField(
                              iconSize: 25,
                              icon: const Icon(Icons.location_on_outlined),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.blue.withOpacity(0.1),
                              ),
                              hint: const Text("Select Country"),
                              value: selectedCountry,
                              onChanged: (val) {
                                setState(() {
                                  selectedCountry = val;
                                  i = country.indexOf(val);
                                });
                              },
                              items: country.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.50,
                                    child: Text(e),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          (i != null)
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    Card(
                                      elevation: 10,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              height: 130,
                                              width: double.infinity,
                                              child: Image.network(
                                                data[i].flag,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Text(
                                              "${data[i].name}",
                                            ),
                                            Text(
                                              "Population: ${data[i].Population}",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    infobox(
                                        title: "Confirmed",
                                        totalCount: data[i].totalConfirmed,
                                        todayCount: data[i].todayConfirmed,
                                        color: Colors.black),
                                    infobox(
                                        title: "Recovered",
                                        totalCount: data[i].totalRecovered,
                                        todayCount: data[i].todayRecovered,
                                        color: Colors.green),
                                    infobox(
                                        title: "Deaths",
                                        totalCount: data[i].totalDeaths,
                                        todayCount: data[i].todayDeaths,
                                        color: Colors.red),
                                    infobox2(
                                        title: "Active",
                                        totalCount: data[i].totalActive,
                                        color: Colors.blue),
                                    infobox2(
                                        title: "Critical",
                                        totalCount: data[i].totalCritical,
                                        color: Colors.orange),
                                  ],
                                )
                              : Container(),
                        ],
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  infobox(
      {required title,
      required totalCount,
      required todayCount,
      required color}) {
    return Card(
      elevation: 5,
      child: Container(
        height: 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "$totalCount",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Today",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "$todayCount",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  infobox2({required title, required totalCount, required color}) {
    return Card(
      elevation: 5,
      child: Container(
        height: 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "$totalCount",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
