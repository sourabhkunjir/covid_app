import 'package:covid19_app/models/world_states_model.dart';
import 'package:covid19_app/services/states_services.dart';
import 'package:covid19_app/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid 19-App"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        
      ),
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .01,
          ),
          //future builder wrap for all future apis values
          FutureBuilder(
            future: statesServices.fetchWorldStatesRecords(),
            builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
              if (!snapshot.hasData) {
                return Expanded(
                  flex: 1,
                  child: SpinKitFadingCircle(
                    color: Colors.white,
                    size: 50,
                    controller: _controller,
                  ),
                );
              } else {
                return Column(
                  children: [
                    // animated spinkit piechart
                    PieChart(
                      dataMap: {
                        "Total": double.parse(snapshot.data!.cases!.toString()),
                        "Recoverd":
                            double.parse(snapshot.data!.recovered!.toString()),
                        "Deaths":
                            double.parse(snapshot.data!.deaths!.toString()),
                      },
                      chartRadius: MediaQuery.of(context).size.width / 3.2,
                      chartValuesOptions: const ChartValuesOptions(
                          showChartValuesInPercentage: true),
                      legendOptions: const LegendOptions(
                          legendPosition: LegendPosition.left),
                      animationDuration: const Duration(milliseconds: 1200),
                      chartType: ChartType.ring,
                      colorList: colorList,
                    ),
                    //middle containers
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * .06),
                      child: Card(
                        child: Column(
                          children: [
                            ReusableRow(
                              title: "cases",
                              value: snapshot.data!.cases.toString(),
                            ),
                            ReusableRow(
                              title: "death",
                              value: snapshot.data!.deaths.toString(),
                            ),
                            ReusableRow(
                              title: "recovered",
                              value: snapshot.data!.recovered.toString(),
                            ),
                            ReusableRow(
                              title: "active",
                              value: snapshot.data!.active.toString(),
                            ),
                            ReusableRow(
                              title: "critical",
                              value: snapshot.data!.critical.toString(),
                            ),
                            ReusableRow(
                              title: "today deaths",
                              value: snapshot.data!.todayDeaths.toString(),
                            ),
                            ReusableRow(
                              title: "today recovered",
                              value: snapshot.data!.todayRecovered.toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // below track countries button
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CountriesListScreen(),
                            ));
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xff1aa260),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text("Track Countries"),
                        ),
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ],
      ),
    )));
  }
}

// ================================================================================================
class ReusableRow extends StatelessWidget {
  ReusableRow({super.key, required this.title, required this.value});

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 5, right: 10, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
