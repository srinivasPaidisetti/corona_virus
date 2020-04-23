import 'package:coronavirus/network/models/complete_data.dart';
import 'package:coronavirus/ui/screens/menu/graph/graph_screen.dart';
import 'package:coronavirus/utils/common_utils.dart';
import 'package:coronavirus/utils/res/colors.dart';
import 'package:coronavirus/viewmodels/home/home_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../base_widget.dart';

class HomeScreen extends StatefulWidget {
  final CompleteData completeData;

  const HomeScreen({Key key, this.completeData}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime currentBackPressTime;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeModel>(
        model: HomeModel(),
        onModelReady: (model) => model.init(widget.completeData),
        builder: (context, model, child) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              resizeToAvoidBottomPadding: false,
              backgroundColor: Colors.black,
              drawer: SafeArea(
                child: Drawer(
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            navigateTo(
                                context,
                                GraphScreen(
                                  completeData: widget.completeData,
                                ));
                          },
                          child: Text(
                            'Graph View',
                            style: textStyleBold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              body: WillPopScope(
                onWillPop: onWillPop,
                child: SafeArea(
                  child: Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: primaryColorDark,
                            ),
                            child: TextFormField(
                              controller: model.wordController,
                              onChanged: (value) {
                                model.searchWord = value;
                              },
                              cursorColor: lightGreyColor,
                              style: TextStyle(color: lightGreyColor),
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  prefixText: '     ',
                                  suffixIcon: Icon(
                                    Icons.search,
                                    size: 20,
                                    color: lightGreyColor,
                                  ),
                                  hintText: 'Search Country',
                                  border: InputBorder.none),
                            ),
                          ),
                          ((model.searchList.length ?? 0) > 0 &&
                                  model.showSearchItemList)
                              ? CountrySearchList()
                              : Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: ListView(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30, bottom: 20),
                                          child: Text(
                                            'World wide information'
                                                .toUpperCase(),
                                            style: TextStyle(
                                                color: lightGreyColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        HomeCardView(
                                          title: 'Total Confirmed',
                                          count: model.completeData.global
                                              .totalConfirmed,
                                          color: Colors.blue,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        HomeCardView(
                                          title: 'Total Deaths',
                                          count: model
                                              .completeData.global.totalDeaths,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        HomeCardView(
                                          title: 'Total Recovered',
                                          count: model.completeData.global
                                              .totalRecovered,
                                          color: greenColor,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30, bottom: 20, top: 20),
                                          child: Text(
                                            '${model.wordController.text} Cases information'
                                                .toUpperCase(),
                                            style: TextStyle(
                                                color: lightGreyColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        BottomCountryDetail(
                                          color: Colors.blue,
                                          count:
                                              model?.country?.totalConfirmed ??
                                                  0,
                                          title: 'Number of Confirmed',
                                        ),
                                        BottomCountryDetail(
                                          color: Colors.blue,
                                          count:
                                              model?.country?.newConfirmed ?? 0,
                                          title: 'Today new Confirmed',
                                        ),
                                        BottomCountryDetail(
                                          color: redColor,
                                          count:
                                              model?.country?.totalDeaths ?? 0,
                                          title: 'Number of Deaths',
                                        ),
                                        BottomCountryDetail(
                                          color: redColor,
                                          count: model?.country?.newDeaths ?? 0,
                                          title: 'Today Deaths',
                                        ),
                                        BottomCountryDetail(
                                          color: Colors.green,
                                          count:
                                              model?.country?.totalRecovered ??
                                                  0,
                                          title: 'Discharged Patients',
                                        ),
                                        BottomCountryDetail(
                                          color: Colors.green,
                                          count:
                                              model?.country?.newRecovered ?? 0,
                                          title: 'Today Discharged Patients',
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        });
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Press back button to exit app");
      return Future.value(false);
    }
    SystemNavigator.pop();
    return Future.value(true);
  }
}

class HomeCardView extends StatelessWidget {
  final String title;
  final int count;
  final Color color;

  const HomeCardView({
    Key key,
    this.title,
    this.count,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
          color: primaryColorDark, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: lightGreyColor, fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            count.toString(),
            style: TextStyle(
                color: color, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class BottomCountryDetail extends StatelessWidget {
  final Color color;
  final int count;
  final String title;

  const BottomCountryDetail({
    Key key,
    this.color,
    this.count,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 60,
            ),
            SizedBox(
                height: 16,
                width: 16,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), color: color),
                )),
            SizedBox(
              width: 25,
            ),
            Text(
              '$title :    $count',
              style: TextStyle(
                color: lightGreyColor,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CountrySearchList extends StatelessWidget {
  const CountrySearchList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeModel model = Provider.of<HomeModel>(context);
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: model?.searchList?.length ?? 0,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                model.onSearchCountryTap(model.searchList[index]);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 250,
                      child: Text(
                        model.searchList[index].country,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: lightGreyColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Text(
                      model.searchList[index].totalConfirmed.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: lightGreyColor,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
