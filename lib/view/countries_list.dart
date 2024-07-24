import 'package:covid19_app/services/states_services.dart';
import 'package:covid19_app/view/detailscreen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      //appbar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          // seachbar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search with Country name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0))),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: statesServices.CountriesListApi(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    //shimmer effect
                    if (!snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.white,
                                    ),
                                    title: Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white,
                                    ),
                                    subtitle: Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ));
                        },
                      );
                      // data display
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]["country"];
                          if (searchController.text.isEmpty) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                            name: snapshot.data![index]
                                                ["country"],
                                            image: snapshot.data![index]
                                                  ["countryInfo"]["flag"],
                                            active: snapshot.data![index]
                                                  ["active"],
                                            critical: snapshot.data![index]
                                                  ["critical"],
                                            test: snapshot.data![index]
                                                  ["tests"],
                                            todayRecovered: snapshot.data![index]
                                                  ["todayRecovered"],
                                            totalCases:snapshot.data![index]
                                                  ["cases"],
                                            totalDeaths:snapshot.data![index]
                                                  ["deaths"], 
                                            totalRecovered:snapshot.data![index]
                                                  ["recovered"],

                                          ),
                                        ));
                                  },
                                  child: ListTile(
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ["countryInfo"]["flag"])),
                                      title: Text(
                                        snapshot.data![index]["country"],
                                      ),
                                      subtitle: Text(
                                        snapshot.data![index]["cases"]
                                            .toString(),
                                      )),
                                )
                              ],
                            );
                          } else if (name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                     Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                            name: snapshot.data![index]
                                                ["country"],
                                            image: snapshot.data![index]
                                                  ["countryInfo"]["flag"],
                                            active: snapshot.data![index]
                                                  ["active"],
                                            critical: snapshot.data![index]
                                                  ["critical"],
                                            test: snapshot.data![index]
                                                  ["tests"],
                                            todayRecovered: snapshot.data![index]
                                                  ["todayRecovered"],
                                            totalCases:snapshot.data![index]
                                                  ["cases"],
                                            totalDeaths:snapshot.data![index]
                                                  ["deaths"], 
                                            totalRecovered:snapshot.data![index]
                                                  ["recovered"],

                                          ),
                                        ));
                                  },
                                  child: ListTile(
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]["countryInfo"]
                                                  ["flag"])),
                                      title: Text(
                                        snapshot.data![index]["country"],
                                      ),
                                      subtitle: Text(
                                        snapshot.data![index]["cases"].toString(),
                                      )),
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    }
                  }))
        ],
      )),
    );
  }
}
