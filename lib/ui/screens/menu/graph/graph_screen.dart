import 'package:coronavirus/network/models/complete_data.dart';
import 'package:coronavirus/viewmodels/home/home_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphScreen extends StatefulWidget {
  CompleteData completeData;

  GraphScreen({this.completeData});

  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  @override
  Widget build(BuildContext context) {
    HomeModel model = Provider.of<HomeModel>(context);
    return Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Chart title
                title: ChartTitle(text: 'Half yearly sales analysis'),
                // Enable legend
                legend: Legend(isVisible: true),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <LineSeries<Country, String>>[
                  LineSeries<Country, String>(
                      dataSource: widget.completeData.countries,
                      xValueMapper: (Country sales, _) =>
                      sales.countryCode,
                      yValueMapper: (Country sales, _) => sales.totalRecovered,
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ]),
          ],
        ));
  }
}
